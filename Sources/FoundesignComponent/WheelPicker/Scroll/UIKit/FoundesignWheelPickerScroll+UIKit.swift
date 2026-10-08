#if os(iOS)
  import SwiftUI
  import UIKit

  extension FoundesignWheelPickerScroll: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FoundesignWheelPickerUIKitController<Content> {
      FoundesignWheelPickerUIKitController(configuration: self)
    }

    func updateUIViewController(
      _ controller: FoundesignWheelPickerUIKitController<Content>, context: Context
    ) {
      controller.update(self)
    }
  }

  final class FoundesignWheelPickerUIKitController<Content: View>: UIViewController,
    UIScrollViewDelegate, UIGestureRecognizerDelegate
  {
    private var configuration: FoundesignWheelPickerScroll<Content>
    private let scrollView = UIScrollView()
    private let host: UIHostingController<Content>
    private var viewportSize: CGSize = .zero
    private var isInteracting = false
    private var isUpdating = false
    private var lastCenteredIndex: Int?

    init(configuration: FoundesignWheelPickerScroll<Content>) {
      self.configuration = configuration
      host = UIHostingController(rootView: configuration.content)
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:)는 지원하지 않습니다.")
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .clear
      scrollView.backgroundColor = .clear
      scrollView.delegate = self
      scrollView.showsVerticalScrollIndicator = false
      scrollView.showsHorizontalScrollIndicator = false
      scrollView.contentInsetAdjustmentBehavior = .never
      scrollView.decelerationRate = .fast
      scrollView.bounces = false
      scrollView.scrollsToTop = false
      scrollView.isScrollEnabled = configuration.isEnabled
      view.addSubview(scrollView)

      addChild(host)
      host.view.backgroundColor = .clear
      host.safeAreaRegions = []
      scrollView.addSubview(host.view)
      host.didMove(toParent: self)

      let tap = UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
      tap.delegate = self
      tap.require(toFail: scrollView.panGestureRecognizer)
      scrollView.addGestureRecognizer(tap)
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
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
      let shouldAlign =
        configuration.values != newValue.values
        || configuration.selectionIndex != newValue.selectionIndex
        || configuration.metrics != newValue.metrics
        || configuration.isEnabled != newValue.isEnabled
      configuration = newValue
      host.rootView = newValue.content
      guard isViewLoaded else {
        return
      }
      isUpdating = true
      scrollView.isScrollEnabled = newValue.isEnabled
      layoutContent()
      if shouldAlign {
        alignSelection()
      }
      isUpdating = false
    }

    private func layoutContent() {
      let size = CGSize(width: scrollView.bounds.width, height: configuration.metrics.contentHeight)
      host.view.frame = CGRect(origin: .zero, size: size)
      scrollView.contentSize = size
    }

    private func alignSelection() {
      isInteracting = false
      lastCenteredIndex = nil

      scrollView.panGestureRecognizer.isEnabled = false
      scrollView.panGestureRecognizer.isEnabled = configuration.isEnabled
      scrollView.setContentOffset(
        CGPoint(x: 0, y: configuration.metrics.offset(for: configuration.selectionIndex ?? 0)),
        animated: false
      )
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      isInteracting = true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      guard
        !isUpdating,
        isInteracting,
        configuration.isEnabled,
        let index = configuration.metrics.index(at: scrollView.contentOffset.y),
        index != lastCenteredIndex
      else {
        return
      }
      lastCenteredIndex = index
      configuration.onCenter(index)
    }

    func scrollViewWillEndDragging(
      _ scrollView: UIScrollView,
      withVelocity velocity: CGPoint,
      targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
      guard let index = configuration.metrics.index(at: targetContentOffset.pointee.y) else {
        return
      }
      targetContentOffset.pointee.y = configuration.metrics.offset(for: index)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      if !decelerate {
        settle()
      }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      settle()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
      guard !scrollView.isDragging, !scrollView.isDecelerating else {
        return
      }
      settle()
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      configuration.isEnabled && !scrollView.isDragging && !scrollView.isDecelerating
    }

    @objc private func itemTapped(_ recognizer: UITapGestureRecognizer) {
      let y = recognizer.location(in: host.view).y - configuration.metrics.inset
      guard y >= 0, y < CGFloat(configuration.metrics.count) * configuration.metrics.itemHeight
      else {
        return
      }
      move(to: Int(y / configuration.metrics.itemHeight))
    }

    private func move(to index: Int) {
      guard configuration.isEnabled else {
        return
      }
      isInteracting = true
      let offset = configuration.metrics.offset(for: index)

      if abs(scrollView.contentOffset.y - offset) < 0.5 {
        scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
        commit(index)
      } else {
        scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
      }
    }

    private func settle() {
      guard
        !isUpdating,
        isInteracting,
        configuration.isEnabled,
        let index = configuration.metrics.index(at: scrollView.contentOffset.y)
      else {
        return
      }

      if abs(scrollView.contentOffset.y - configuration.metrics.offset(for: index)) >= 0.5 {
        move(to: index)
      } else {
        commit(index)
      }
    }

    private func commit(_ index: Int) {
      isInteracting = false
      lastCenteredIndex = nil
      configuration.selectionIndex = index
      configuration.onCommit(index)
    }
  }
#endif
