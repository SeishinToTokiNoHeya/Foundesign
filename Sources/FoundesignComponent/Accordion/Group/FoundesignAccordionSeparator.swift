import FoundesignFoundation
import SwiftUI

public struct FoundesignAccordionSeparator: View {
  @Environment(\.theme) private var theme
  @Environment(\.accordionStyle) private var style

  public init() {}

  public var body: some View {
    Group {
      switch style {
      case .inline:
        FoundesignAccordionDivider()

      case .separated:
        Spacer()
          .frame(height: theme.spacing.medium)
      }
    }
    .accessibilityHidden(true)
  }
}
