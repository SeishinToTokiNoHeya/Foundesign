#if os(macOS)
  import AppKit
  import FoundesignFoundation
  import SwiftUI

  struct FoundesignAlertDialogPresenter<Content: View>: NSViewControllerRepresentable {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let content: () -> Content

    func makeCoordinator() -> FoundesignAlertDialogAppKitCoordinator {
      FoundesignAlertDialogAppKitCoordinator()
    }

    func makeNSViewController(context: Context) -> FoundesignModalAppKitAnchor {
      let anchor = FoundesignModalAppKitAnchor()
      context.coordinator.anchor = anchor
      anchor.attachmentChanged = { [weak coordinator = context.coordinator] in
        coordinator?.scheduleUpdate()
      }
      return anchor
    }

    func updateNSViewController(_ controller: FoundesignModalAppKitAnchor, context: Context) {
      context.coordinator.update(
        binding: $isPresented,
        onDismiss: onDismiss,
        content: isPresented ? AnyView(content()) : nil,
        environment: context.environment
      )
    }

    static func dismantleNSViewController(
      _ controller: FoundesignModalAppKitAnchor,
      coordinator: FoundesignAlertDialogAppKitCoordinator
    ) {
      controller.attachmentChanged = nil
      DispatchQueue.main.async {
        coordinator.presentation.invalidate()
      }
    }
  }
#endif
