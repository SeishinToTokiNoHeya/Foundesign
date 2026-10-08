#if os(iOS)
import FoundesignFoundation
import SwiftUI
import UIKit

@MainActor
final class FoundesignModalUIKitAnchor: UIViewController {
  var attachmentChanged: (() -> Void)?

  override func loadView() {
    let view = FoundesignModalUIKitAnchorView()
    view.attachmentChanged = { [weak self] in
      self?.attachmentChanged?()
    }
    view.isUserInteractionEnabled = false
    self.view = view
  }
}

@MainActor
private final class FoundesignModalUIKitAnchorView: UIView {
  var attachmentChanged: (() -> Void)?

  override func didMoveToWindow() {
    super.didMoveToWindow()
    attachmentChanged?()
  }
}
#endif
