#if os(macOS)
import AppKit
import SwiftUI

extension FoundesignWheelPickerScroll: NSViewControllerRepresentable {
  func makeNSViewController(context: Context) -> FoundesignWheelPickerAppKitController<Content> {
    FoundesignWheelPickerAppKitController(configuration: self)
  }

  func updateNSViewController(_ controller: FoundesignWheelPickerAppKitController<Content>, context: Context) {
    controller.update(self)
  }
}

final class FoundesignWheelPickerAppKitController<Content: View>: NSViewController {
  private var configuration: FoundesignWheelPickerScroll<Content>
  private let scrollView = FoundesignWheelPickerNSScrollView()
  private let host: NSHostingView<Content>
  private var viewportSize: CGSize = .zero
  private var isInteracting = false
  private var isUpdating = false
  private var lastCenteredIndex: Int?

  init(configuration: FoundesignWheelPickerScroll<Content>) {
    self.configuration = configuration
    host = NSHostingView(rootView: configuration.content)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:)는 지원하지 않습니다.")
  }

  override func loadView() {
    view = NSView()
    scrollView.drawsBackground = false
    scrollView.hasVerticalScroller = false
    scrollView.hasHorizontalScroller = false
    scrollView.verticalScrollElasticity = .none
    scrollView.horizontalScrollElasticity = .none
    scrollView.contentView = FoundesignWheelPickerClipView()
    scrollView.contentView.drawsBackground = false
    scrollView.contentView.postsBoundsChangedNotifications = true
    scrollView.isPickerEnabled = configuration.isEnabled
    scrollView.documentView = host
    view.addSubview(scrollView)

    scrollView.onScroll = { [weak self] in self?.isInteracting = true }
    scrollView.onStep = { [weak self] delta in self?.wheelStepped(delta) }
    let tap = NSClickGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
    scrollView.addGestureRecognizer(tap)

    NotificationCenter.default.addObserver(
      self, selector: #selector(boundsChanged),
      name: NSView.boundsDidChangeNotification, object: scrollView.contentView
    )
    NotificationCenter.default.addObserver(
      self, selector: #selector(scrollEnded),
      name: NSScrollView.didEndLiveScrollNotification, object: scrollView
    )
  }

  override func viewDidLayout() {
    super.viewDidLayout()
    let changed = viewportSize != view.bounds.size
    viewportSize = view.bounds.size
    isUpdating = true
    scrollView.frame = view.bounds
    layoutContent()
    if changed {
      alignSelection()
    }
    isUpdating = false
  }

  func update(_ newValue: FoundesignWheelPickerScroll<Content>) {
    let shouldAlign = configuration.values != newValue.values
    || configuration.selectionIndex != newValue.selectionIndex
    || configuration.metrics != newValue.metrics
    || configuration.isEnabled != newValue.isEnabled
    configuration = newValue
    host.rootView = newValue.content
    guard isViewLoaded else { return }
    isUpdating = true
    scrollView.isPickerEnabled = newValue.isEnabled
    layoutContent()
    if shouldAlign {
      alignSelection()
    }
    isUpdating = false
  }

  private func layoutContent() {
    host.frame = CGRect(
      x: 0, y: 0, width: scrollView.contentSize.width,
      height: configuration.metrics.contentHeight
    )
  }

  private func alignSelection() {
    if isInteracting {
      scrollView.suppressCurrentGesture = true
    }
    isInteracting = false
    lastCenteredIndex = nil
    scroll(to: configuration.selectionIndex ?? 0)
  }

  private func scroll(to index: Int) {
    scrollView.contentView.scroll(to: CGPoint(x: 0, y: configuration.metrics.offset(for: index)))
    scrollView.reflectScrolledClipView(scrollView.contentView)
  }

  @objc private func boundsChanged() {
    guard
      !isUpdating,
      isInteracting,
      configuration.isEnabled,
      let index = configuration.metrics.index(at: scrollView.contentView.bounds.minY),
      index != lastCenteredIndex else {
      return
    }
    lastCenteredIndex = index
    configuration.onCenter(index)
  }

  @objc private func scrollEnded() {
    guard
      !isUpdating,
      isInteracting,
      configuration.isEnabled,
      let index = configuration.metrics.index(at: scrollView.contentView.bounds.minY) else {
      return
    }
    select(index)
  }

  @objc private func itemTapped(_ recognizer: NSClickGestureRecognizer) {
    guard configuration.isEnabled, !isInteracting else {
      return
    }
    let y = recognizer.location(in: host).y - configuration.metrics.inset
    guard y >= 0, y < CGFloat(configuration.metrics.count) * configuration.metrics.itemHeight else {
      return
    }
    select(Int(y / configuration.metrics.itemHeight))
  }

  private func wheelStepped(_ delta: CGFloat) {
    guard
      configuration.isEnabled, delta != 0,
      let index = configuration.metrics.index(at: scrollView.contentView.bounds.minY) else {
      return
    }
    select(min(configuration.metrics.count - 1, max(0, index + (delta < 0 ? 1 : -1))))
  }

  private func select(_ index: Int) {
    isInteracting = false
    lastCenteredIndex = nil
    scroll(to: index)
    configuration.selectionIndex = index
    configuration.onCommit(index)
  }
}

private final class FoundesignWheelPickerClipView: NSClipView {
  override var isFlipped: Bool { true }
}

private final class FoundesignWheelPickerNSScrollView: NSScrollView {
  var isPickerEnabled = true
  var suppressCurrentGesture = false
  var onScroll: (() -> Void)?
  var onStep: ((CGFloat) -> Void)?

  override var acceptsFirstResponder: Bool { isPickerEnabled }

  override func scrollWheel(with event: NSEvent) {
    guard isPickerEnabled else {
      return
    }
    if event.phase.isEmpty && event.momentumPhase.isEmpty {
      suppressCurrentGesture = false
      onStep?(event.scrollingDeltaY)
    } else {
      if event.phase.contains(.began) {
        suppressCurrentGesture = false
      }
      guard !suppressCurrentGesture else {
        return
      }
      onScroll?()
      super.scrollWheel(with: event)
    }
  }
}
#endif
