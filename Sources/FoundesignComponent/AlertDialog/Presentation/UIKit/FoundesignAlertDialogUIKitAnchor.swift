#if os(iOS)
import FoundesignFoundation
import SwiftUI
import UIKit

@MainActor
final class FoundesignAlertDialogUIKitAnchor: UIViewController {
  var attachmentChanged: (() -> Void)?

  override func loadView() {
    let view = FoundesignAlertDialogUIKitAnchorView()
    view.attachmentChanged = { [weak self] in
      self?.attachmentChanged?()
    }
    view.isUserInteractionEnabled = false
    self.view = view
  }
}

@MainActor
private final class FoundesignAlertDialogUIKitAnchorView: UIView {
  var attachmentChanged: (() -> Void)?

  override func didMoveToWindow() {
    super.didMoveToWindow()
    attachmentChanged?()
  }
}
#endif
