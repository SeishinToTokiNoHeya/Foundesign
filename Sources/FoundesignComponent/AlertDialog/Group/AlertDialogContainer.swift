import FoundesignFoundation
import SwiftUI

public struct AlertDialogContainer<Header, Content, Footer>: View where Header: View, Content: View, Footer: View {
  @Environment(\.theme) private var theme

  private let header: Header
  private let content: Content
  private let footer: Footer

  public init(
    header: () -> Header,
    content: () -> Content,
    footer: () -> Footer
  ) {
    self.header = header()
    self.content = content()
    self.footer = footer()
  }

  public init(
    title: String,
    content: () -> Content,
    footer: () -> Footer
  ) where Header == AlertDialogTitleItem {
    self.header = AlertDialogTitleItem(title: title)
    self.content = content()
    self.footer = footer()
  }

  public init(
    title: String,
    description: String,
    footer: () -> Footer
  ) where Header == AlertDialogTitleItem, Content == AlertDialogDescriptionItem {
    self.header = AlertDialogTitleItem(title: title)
    self.content = AlertDialogDescriptionItem(description: description)
    self.footer = footer()
  }

  public var body: some View {
    VStack(spacing: theme.spacing.medium) {
      header
      content
      footer
        .padding(.top, theme.spacing.medium)
    }
    .padding(.vertical, theme.spacing.xLarge)
    .padding(.horizontal, theme.spacing.xLarge)
    .background {
      RoundedRectangle(cornerRadius: theme.radius.xLarge)
        .fill(theme.color.background.base)
    }
  }
}
