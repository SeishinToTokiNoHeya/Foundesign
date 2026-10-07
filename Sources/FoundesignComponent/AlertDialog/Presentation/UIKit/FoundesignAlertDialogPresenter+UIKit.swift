#if os(iOS)
import FoundesignFoundation
import SwiftUI
import UIKit

struct FoundesignAlertDialogPresenter<Content: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  let onDismiss: (() -> Void)?
  let content: () -> Content

  func makeCoordinator() -> FoundesignAlertDialogUIKitCoordinator {
    FoundesignAlertDialogUIKitCoordinator()
  }

  func makeUIViewController(
    context: Context
  ) -> FoundesignAlertDialogUIKitAnchor {
    let anchor = FoundesignAlertDialogUIKitAnchor()
    context.coordinator.anchor = anchor
    anchor.attachmentChanged = { [weak coordinator = context.coordinator] in
      coordinator?.scheduleUpdate()
    }
    return anchor
  }

  func updateUIViewController(
    _ controller: FoundesignAlertDialogUIKitAnchor,
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
    _ controller: FoundesignAlertDialogUIKitAnchor,
    coordinator: FoundesignAlertDialogUIKitCoordinator
  ) {
    controller.attachmentChanged = nil
    DispatchQueue.main.async {
      coordinator.presentation.invalidate()
    }
  }
}
#endif
