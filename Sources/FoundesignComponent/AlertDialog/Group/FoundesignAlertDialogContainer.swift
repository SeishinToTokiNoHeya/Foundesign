import FoundesignFoundation
import SwiftUI

/// 제목, 본문과 primary 버튼 하나 또는 primary, secondary 버튼을 표시하는 다이얼로그입니다.
///
/// Footer에는 primary, secondary 순서로 버튼을 선언합니다.
/// Secondary 버튼을 생략하면 primary 버튼만 표시하고,
/// 두 버튼을 선언하면 `FoundesignAdaptiveButtonGroup`으로 배치합니다.
/// 주어진 높이보다 내용이 길면 제목과 본문만 스크롤되고, footer는 하단에 고정됩니다.
/// 컨테이너는 배치와 기본 외형을 제공합니다. 표시·닫힘 전환은 `alertDialog` modifier로 연결합니다.
/// 버튼 톤·크기를 지정하지 않으면 `.neutral`·`.large`를 사용합니다. 상위 또는 항목의 설정이 우선합니다.
///
/// ```swift
/// FoundesignAlertDialogContainer(
///   title: "삭제할까요?",
///   description: "삭제한 항목은 복구할 수 없습니다."
/// ) {
///   FoundesignAlertDialogButtonItem(label: "삭제") {
///     deleteItem()
///   }
///   .buttonTone(.critical)
///   FoundesignAlertDialogButtonItem(label: "취소") {
///     dismiss()
///   }
/// }
/// ```
///
/// ```swift
/// FoundesignAlertDialogContainer(
///   title: "버튼 하나도 가능",
///   description: "Primary 버튼 하나도 가능합니다."
/// ) {
///   FoundesignAlertDialogButtonItem(label: "확인") {
///     confirm()
///   }
/// }
/// ```
public struct FoundesignAlertDialogContainer<Header, Content, Footer>: View
where Header: View, Content: View, Footer: View {
  @Environment(\.theme) private var theme

  private let header: Header
  private let content: Content
  private let footer: Footer

  /// 사용자 정의 헤더·본문·버튼 영역으로 컨테이너를 만듭니다.
  /// - Parameters:
  ///   - header: 상단 제목 영역입니다.
  ///   - content: 본문 영역입니다.
  ///   - footer: primary 하나 또는 primary·secondary 순서의 버튼 두 개입니다.
  public init(
    header: () -> Header,
    content: () -> Content,
    @FoundesignAlertDialogFooterBuilder footer: () -> Footer
  ) {
    self.header = header()
    self.content = content()
    self.footer = footer()
  }

  /// 문자열 제목과 사용자 정의 본문으로 컨테이너를 만듭니다.
  /// - Parameters:
  ///   - title: 상단 제목입니다.
  ///   - content: 본문 영역입니다.
  ///   - footer: primary 하나 또는 primary·secondary 순서의 버튼 두 개입니다.
  public init(
    title: String,
    content: () -> Content,
    @FoundesignAlertDialogFooterBuilder footer: () -> Footer
  ) where Header == FoundesignAlertDialogTitleItem {
    self.header = FoundesignAlertDialogTitleItem(title: title)
    self.content = content()
    self.footer = footer()
  }

  /// 사용자 정의 헤더와 문자열 설명으로 컨테이너를 만듭니다.
  /// - Parameters:
  ///   - description: 본문 설명입니다.
  ///   - header: 상단 제목 영역입니다.
  ///   - footer: primary 하나 또는 primary·secondary 순서의 버튼 두 개입니다.
  public init(
    description: String,
    header: () -> Header,
    @FoundesignAlertDialogFooterBuilder footer: () -> Footer
  ) where Content == FoundesignAlertDialogDescriptionItem {
    self.header = header()
    self.content = FoundesignAlertDialogDescriptionItem(description: description)
    self.footer = footer()
  }

  /// 문자열 제목과 설명으로 컨테이너를 만듭니다.
  /// - Parameters:
  ///   - title: 상단 제목입니다.
  ///   - description: 본문 설명입니다.
  ///   - footer: primary 하나 또는 primary·secondary 순서의 버튼 두 개입니다.
  public init(
    title: String,
    description: String,
    @FoundesignAlertDialogFooterBuilder footer: () -> Footer
  )
  where Header == FoundesignAlertDialogTitleItem, Content == FoundesignAlertDialogDescriptionItem {
    self.header = FoundesignAlertDialogTitleItem(title: title)
    self.content = FoundesignAlertDialogDescriptionItem(description: description)
    self.footer = footer()
  }

  public var body: some View {
    VStack(
      alignment: .leading,
      spacing: theme.spacing.medium
    ) {
      ViewThatFits(in: .vertical) {
        headerAndContent
          .fixedSize(horizontal: false, vertical: true)
        ScrollView {
          headerAndContent
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      footer
        .transformEnvironment(\.buttonTone) { $0 = $0 ?? .neutral }
        .transformEnvironment(\.buttonSize) { $0 = $0 ?? .large }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.top, theme.spacing.medium)
        .padding(.horizontal, theme.spacing.xLarge)
        .padding(.bottom, theme.spacing.xLarge)
        .layoutPriority(1)
    }
    .background {
      RoundedRectangle(cornerRadius: theme.radius.xLarge)
        .fill(theme.color.background.base)
    }
  }

  private var headerAndContent: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      header
      content
    }
    .padding(.top, theme.spacing.xLarge)
    .padding(.horizontal, theme.spacing.xLarge)
  }
}
