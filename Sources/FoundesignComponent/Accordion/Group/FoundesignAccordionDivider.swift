import FoundesignFoundation
import SwiftUI

public struct FoundesignAccordionDivider: View {
  @Environment(\.theme) private var theme

  public init() {}

  public var body: some View {
    Rectangle()
      .fill(theme.color.border.base)
      .frame(height: 1)
      .frame(maxWidth: .infinity)
  }
}
