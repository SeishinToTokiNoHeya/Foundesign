import FoundesignFoundation
import SwiftUI

public struct AlertDialogTitleItem: View {
  @Environment(\.theme) private var theme
  private let title: String

  public init(title: String) {
    self.title = title
  }

  public var body: some View {
    Text(title)
      .typography(theme.typography.title.medium)
      .foregroundStyle(theme.color.text.primary)
      .frame(maxWidth: .infinity, alignment: .leading)
      .multilineTextAlignment(.leading)
  }
}
