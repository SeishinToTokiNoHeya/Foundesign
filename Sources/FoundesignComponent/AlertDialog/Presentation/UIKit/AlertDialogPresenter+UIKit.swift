#if os(iOS)
import FoundesignFoundation
import SwiftUI
import UIKit

struct AlertDialogPresenter<Content: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  let onDismiss: (() -> Void)?
  let content: () -> Content

  func makeCoordinator() -> AlertDialogUIKitCoordinator {
    AlertDialogUIKitCoordinator()
  }

  func makeUIViewController(
    context: Context
  ) -> AlertDialogUIKitAnchor {
    let anchor = AlertDialogUIKitAnchor()
    context.coordinator.anchor = anchor
    anchor.attachmentChanged = { [weak coordinator = context.coordinator] in
      coordinator?.scheduleUpdate()
    }
    return anchor
  }

  func updateUIViewController(
    _ controller: AlertDialogUIKitAnchor,
    context: Context
  ) {
    context.coordinator.update(
      binding: $isPresented,
      onDismiss: onDismiss,
      content: isPresented ? AnyView(content()) : nil,
      environment: context.environment
    )
  }

  static func dismantleUIViewController(
    _ controller: AlertDialogUIKitAnchor,
    coordinator: AlertDialogUIKitCoordinator
  ) {
    controller.attachmentChanged = nil
    DispatchQueue.main.async {
      coordinator.presentation.invalidate()
    }
  }
}
#endif
