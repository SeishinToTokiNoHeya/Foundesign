import FoundesignFoundation
import SwiftUI

/// 제목, 본문과 primary 버튼 하나 또는 primary, secondary 버튼을 표시하는 다이얼로그입니다.
///
/// Footer에는 primary, secondary 순서로 버튼을 선언합니다.
/// Secondary 버튼을 생략하면 primary 버튼만 표시하고,
/// 두 버튼을 선언하면 `AdaptiveButtonGroup`으로 배치합니다.
///
/// ```swift
/// AlertDialogContainer(
///   title: "삭제할까요?",
///   description: "삭제한 항목은 복구할 수 없습니다."
/// ) {
///   AlertDialogButtonItem(primary: .critical, label: "삭제") {
///     deleteItem()
///   }
///   AlertDialogButtonItem(secondary: .neutral, label: "취소") {
///     dismiss()
///   }
/// }
/// ```
///
/// ```swift
/// AlertDialogContainer(
///   title: "버튼 하나도 가능",
///   description: "Primary 버튼 하나도 가능합니다."
/// ) {
///   AlertDialogButtonItem(primary: .neutral, label: "확인") {
///     confirm()
///   }
/// }
/// ```
public struct AlertDialogContainer<Header, Content, Footer>: View where Header: View, Content: View, Footer: View {
  @Environment(\.theme) private var theme

  private let header: Header
  private let content: Content
  private let footer: Footer

  public init(
    header: () -> Header,
    content: () -> Content,
    @AlertDialogFooterBuilder footer: () -> Footer
  ) {
    self.header = header()
    self.content = content()
    self.footer = footer()
  }

  public init(
    title: String,
    content: () -> Content,
    @AlertDialogFooterBuilder footer: () -> Footer
  ) where Header == AlertDialogTitleItem {
    self.header = AlertDialogTitleItem(title: title)
    self.content = content()
    self.footer = footer()
  }

  public init(
    description: String,
    header: () -> Header,
    @AlertDialogFooterBuilder footer: () -> Footer
  ) where Content == AlertDialogDescriptionItem {
    self.header = header()
    self.content = AlertDialogDescriptionItem(description: description)
    self.footer = footer()
  }

  public init(
    title: String,
    description: String,
    @AlertDialogFooterBuilder footer: () -> Footer
  ) where Header == AlertDialogTitleItem, Content == AlertDialogDescriptionItem {
    self.header = AlertDialogTitleItem(title: title)
    self.content = AlertDialogDescriptionItem(description: description)
    self.footer = footer()
  }

  public var body: some View {
    VStack(
      alignment: .leading,
      spacing: theme.spacing.medium
    ) {
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
