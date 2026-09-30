#if os(macOS)
import AppKit
import FoundesignFoundation
import SwiftUI

struct AlertDialogPresenter<Content: View>: NSViewControllerRepresentable {
  @Binding var isPresented: Bool
  let onDismiss: (() -> Void)?
  let content: () -> Content

  func makeCoordinator() -> AlertDialogAppKitCoordinator {
    AlertDialogAppKitCoordinator()
  }

  func makeNSViewController(context: Context) -> AlertDialogAppKitAnchor {
    let anchor = AlertDialogAppKitAnchor()
    context.coordinator.anchor = anchor
    anchor.attachmentChanged = { [weak coordinator = context.coordinator] in
      coordinator?.scheduleUpdate()
    }
    return anchor
  }

  func updateNSViewController(_ controller: AlertDialogAppKitAnchor, context: Context) {
    context.coordinator.update(
      binding: $isPresented,
      onDismiss: onDismiss,
      content: isPresented ? AnyView(content()) : nil,
      environment: context.environment
    )
  }

  static func dismantleNSViewController(
    _ controller: AlertDialogAppKitAnchor,
    coordinator: AlertDialogAppKitCoordinator
  ) {
    controller.attachmentChanged = nil
    DispatchQueue.main.async {
      coordinator.presentation.invalidate()
    }
  }
}
#endif
