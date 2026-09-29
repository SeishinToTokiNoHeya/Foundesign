import FoundesignFoundation
import SwiftUI

public struct AlertDialogDescriptionItem: View {
  @Environment(\.theme) private var theme
  private let description: String

  public init(description: String) {
    self.description = description
  }

  public var body: some View {
    Text(description)
      .typography(theme.typography.body.large)
      .foregroundStyle(theme.color.text.primary)
      .frame(maxWidth: .infinity, alignment: .leading)
      .multilineTextAlignment(.leading)
  }
}
