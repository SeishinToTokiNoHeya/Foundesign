import FoundesignFoundation
import SwiftUI

/// 고정 헤더·스크롤 가능한 본문·고정 footer를 조합하는 바텀 시트 콘텐츠입니다.
///
/// 표시와 핸들은 `bottomSheet` modifier가 담당합니다. 일반 Button은 표시 바인딩을 직접
/// 변경해 닫습니다. 본문에 ScrollView를 중첩하지 말고 콘텐츠를 직접 전달하세요.
/// Footer의 버튼은 별도 설정이 없으면 `.large`·`.neutral`을 사용합니다.
public struct FoundesignBottomSheetContainer<Content: View, Footer: View>: View {
  @Environment(\.theme) private var theme
  @Environment(\.bottomSheetHeaderAlignment) private var alignment
  @Environment(\.bottomSheetShowsCloseButton) private var showsCloseButton
  @Environment(\.bottomSheetIsPresented) private var isPresented
  private let title: String?
  private let description: String?
  private let content: Content
  private let footer: Footer

  /// 제목·설명과 사용자 정의 본문·footer를 구성합니다.
  /// - Parameters:
  ///   - title: 헤더 제목입니다. `nil`이면 설명도 표시하지 않습니다.
  ///   - description: 제목 아래에 표시할 선택적 설명입니다.
  ///   - content: 가용 높이를 넘으면 스크롤할 본문입니다.
  ///   - footer: 고정 하단 영역입니다. 버튼 그룹 등을 전달합니다.
  public init(
    title: String? = nil,
    description: String? = nil,
    @ViewBuilder content: () -> Content,
    @ViewBuilder footer: () -> Footer
  ) {
    self.title = title
    self.description = description
    self.content = content()
    self.footer = footer()
  }

  /// Footer 없이 본문을 구성합니다. 제목을 생략하면 설명도 표시하지 않습니다.
  public init(
    title: String? = nil,
    description: String? = nil,
    @ViewBuilder content: () -> Content
  ) where Footer == EmptyView {
    self.init(title: title, description: description, content: content, footer: { EmptyView() })
  }

  public var body: some View {
    VStack(spacing: theme.spacing.zero) {
      if title != nil || showsCloseButton {
        header
          .fixedSize(horizontal: false, vertical: true)
          .layoutPriority(1)
      }
      ViewThatFits(in: .vertical) {
        paddedContent.fixedSize(horizontal: false, vertical: true)
        ScrollView {
          paddedContent
        }
        // 짧은 스크롤 영역에서도 본문 대부분을 가리지 않는 하단 페이드입니다.
        .contentFog(.bottom, fraction: 0.08)
      }
      if Footer.self != EmptyView.self {
        footer
          .transformEnvironment(\.buttonTone) { $0 = $0 ?? .neutral }
          .transformEnvironment(\.buttonSize) { $0 = $0 ?? .large }
          .padding(.horizontal, theme.spacing.xLarge)
          .padding(.top, theme.spacing.medium)
          .padding(.bottom, theme.spacing.large)
          .fixedSize(horizontal: false, vertical: true)
          .layoutPriority(1)
      }
    }
  }

  private var paddedContent: some View {
    content
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, theme.spacing.xLarge)
      .padding(.vertical, theme.spacing.large)
  }

  private var header: some View {
    VStack(alignment: alignment == .center ? .center : .leading, spacing: theme.spacing.small) {
      if let title {
        Text(title)
          .typography(theme.typography.title.medium)
          .foregroundStyle(theme.color.foreground.primary)
          .padding(.trailing, showsCloseButton ? 40 : 0)
          .padding(.leading, showsCloseButton && alignment == .center ? 40 : 0)
        if let description {
          Text(description)
            .typography(theme.typography.body.large)
            .foregroundStyle(theme.color.foreground.secondary)
        }
      }
    }
    .multilineTextAlignment(alignment == .center ? .center : .leading)
    .frame(maxWidth: .infinity, alignment: alignment == .center ? .center : .leading)
    .frame(minHeight: showsCloseButton ? 40 : 0)
    .padding(.horizontal, theme.spacing.xLarge)
    .padding(.top, theme.spacing.large)
    .padding(.bottom, theme.spacing.large)
    .overlay(alignment: .topTrailing) {
      if showsCloseButton {
        Button {
          isPresented?.wrappedValue = false
        } label: {
          Image(systemName: "xmark")
            .frame(width: 40, height: 40)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .foregroundStyle(theme.color.foreground.primary)
        .padding(.trailing, theme.spacing.large)
        .padding(.top, theme.spacing.large)
      }
    }
  }
}
