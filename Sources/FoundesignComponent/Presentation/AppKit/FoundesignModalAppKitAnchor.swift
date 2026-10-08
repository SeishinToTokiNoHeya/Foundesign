#if os(macOS)
  import AppKit
  import FoundesignFoundation
  import SwiftUI

  @MainActor
  final class FoundesignModalAppKitAnchor: NSViewController {
    var attachmentChanged: (() -> Void)?
    var attachedWindow: NSWindow? {
      isViewLoaded ? view.window : nil
    }

    override func loadView() {
      let view = FoundesignModalAppKitAnchorView()
      view.attachmentChanged = { [weak self] in
        self?.attachmentChanged?()
      }
      self.view = view
    }
  }

  @MainActor
  private final class FoundesignModalAppKitAnchorView: NSView {
    var attachmentChanged: (() -> Void)?

    override func viewDidMoveToWindow() {
      super.viewDidMoveToWindow()
      attachmentChanged?()
    }

    override func hitTest(_ point: NSPoint) -> NSView? {
      nil
    }
  }
#endif
