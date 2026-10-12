#if os(iOS)
  import SwiftUI
  import UIKit

  struct FoundesignBottomSheetPresenter<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let content: (FoundesignBottomSheetPresentation) -> Content

    func makeCoordinator() -> FoundesignBottomSheetUIKitCoordinator {
      FoundesignBottomSheetUIKitCoordinator()
    }

    func makeUIViewController(context: Context) -> FoundesignModalUIKitAnchor {
      let anchor = FoundesignModalUIKitAnchor()
      context.coordinator.anchor = anchor
      anchor.attachmentChanged = { [weak coordinator = context.coordinator] in
        coordinator?.scheduleUpdate()
      }
      return anchor
    }

    func updateUIViewController(_ controller: FoundesignModalUIKitAnchor, context: Context) {
      context.coordinator.update(
        binding: $isPresented,
        content: isPresented ? AnyView(content(context.coordinator.presentation)) : nil,
        environment: context.environment
      )
    }

    static func dismantleUIViewController(
      _ controller: FoundesignModalUIKitAnchor,
      coordinator: FoundesignBottomSheetUIKitCoordinator
    ) {
      controller.attachmentChanged = nil
      DispatchQueue.main.async { coordinator.presentation.lifecycle.invalidate() }
    }
  }

  @MainActor
  final class FoundesignBottomSheetUIKitCoordinator {
    weak var anchor: FoundesignModalUIKitAnchor?
    private var binding: Binding<Bool> = .constant(false)
    private var content = AnyView(EmptyView())
    private var environment = EnvironmentValues()
    private var host: FoundesignBottomSheetUIKitController?
    private var updateScheduled = false

    lazy var presentation = FoundesignBottomSheetPresentation(
      present: { [weak self] in self?.present() ?? false },
      remove: { [weak self] completion in
        guard let self else {
          completion()
          return
        }
        self.remove(completion: completion)
      }
    )

    func update(binding: Binding<Bool>, content: AnyView?, environment: EnvironmentValues) {
      self.binding = binding
      if let content { self.content = content }
      self.environment = environment
      host?.rootView = hostedContent
      host?.overrideUserInterfaceStyle = environment.colorScheme == .dark ? .dark : .light
      scheduleUpdate()
    }

    func scheduleUpdate() {
      guard !updateScheduled else { return }
      updateScheduled = true
      DispatchQueue.main.async { [weak self] in
        guard let self else { return }
        self.updateScheduled = false
        let ready = self.anchor?.viewIfLoaded?.window != nil
        self.presentation.lifecycle.update(
          isPresented: self.binding, onDismiss: nil, isReady: ready)
        if !ready { self.presentation.lifecycle.requestDismissal() }
      }
    }

    private var hostedContent: AnyView {
      AnyView(content.environment(\.self, environment))
    }

    private func present() -> Bool {
      guard let window = anchor?.viewIfLoaded?.window,
        var presenter = window.rootViewController
      else { return false }
      while let presented = presenter.presentedViewController { presenter = presented }
      if presenter.isBeingPresented || presenter.isBeingDismissed {
        presenter.transitionCoordinator?.animate(alongsideTransition: nil) { [weak self] _ in
          self?.scheduleUpdate()
        }
        return false
      }
      let host = FoundesignBottomSheetUIKitController(rootView: hostedContent)
      host.owner = self
      // 원본 화면을 유지하면서 현재 window 전체를 덮어 탭바 위에도 표시합니다.
      host.modalPresentationStyle = .overFullScreen
      host.isModalInPresentation = true
      host.overrideUserInterfaceStyle = environment.colorScheme == .dark ? .dark : .light
      host.view.backgroundColor = .clear
      self.host = host
      presenter.present(host, animated: false)
      return true
    }

    private func remove(completion: @escaping () -> Void) {
      guard let host else {
        completion()
        return
      }
      host.owner = nil
      guard host.presentingViewController != nil else {
        self.host = nil
        completion()
        return
      }
      host.dismiss(animated: false) { [self] in
        self.host = nil
        completion()
      }
    }
  }

  private final class FoundesignBottomSheetUIKitController: UIHostingController<AnyView> {
    var owner: FoundesignBottomSheetUIKitCoordinator?

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      // 상위 모달이 함께 닫히는 경우에도 소유자의 표시 상태를 정리합니다.
      if presentingViewController == nil {
        owner?.presentation.lifecycle.presentationDidFinish()
        owner?.presentation.lifecycle.requestDismissal()
      }
    }
  }
#endif
