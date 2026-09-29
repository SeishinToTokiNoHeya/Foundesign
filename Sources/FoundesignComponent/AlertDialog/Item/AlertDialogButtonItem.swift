import FoundesignFoundation
import SwiftUI

public struct AlertDialogButtonItem<Style>: View where Style: ButtonStyle {
  private var isDisabled = false
  private let style: Style
  private let label: String
  private let action: () -> Void

  public init(_ style: Style, label: String, action: @escaping () -> Void) {
    self.style = style
    self.label = label
    self.action = action
  }

  public init(
    primary variant: AlertDialogButtonVariant,
    label: String,
    action: @escaping () -> Void
  ) where Style == FoundesignSolidButtonStyle {
    self.style = FoundesignSolidButtonStyle(.init(tone: variant.tone, size: .large))
    self.label = label
    self.action = action
  }

  public init(
    secondary variant: AlertDialogButtonVariant,
    label: String,
    action: @escaping () -> Void
  ) where Style == FoundesignWeakButtonStyle {
    self.style = FoundesignWeakButtonStyle(.init(tone: variant.tone, size: .large))
    self.label = label
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      Text(label)
        .frame(maxWidth: .infinity)
    }
    .buttonStyle(style)
    .disabled(isDisabled)
  }

  public func disabled(_ disabled: Bool) -> Self {
    var item = self
    item.isDisabled = disabled
    return item
  }
}
