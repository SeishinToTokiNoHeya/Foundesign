import FoundesignFoundation
import SwiftUI

/// 선택적인 제목과 관련 메뉴 항목을 묶습니다.
/// 그룹 사이는 ``FoundesignMenuDivider``로 구분합니다. 일반 View modifier를 붙인 항목도 사용할 수 있습니다.
public struct FoundesignMenuGroup<Content: View>: View {
  @Environment(\.theme) private var theme
  private let title: String?
  private let content: Content

  /// 메뉴 그룹을 만듭니다.
  /// - Parameters:
  ///   - title: 동작 없이 표시할 그룹 제목입니다. `nil`이면 생략합니다.
  ///   - content: 그룹에 속한 항목입니다. 빈 콘텐츠는 제목만 표시합니다.
  public init(title: String? = nil, @ViewBuilder content: () -> Content) {
    self.title = title
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.zero) {
      if let title {
        Text(title)
          .typography(theme.typography.label.small)
          .foregroundStyle(theme.color.foreground.secondary)
          .padding(.horizontal, theme.spacing.large)
          .padding(.vertical, theme.spacing.small)
      }
      content
    }
  }
}

/// 메뉴 그룹 사이의 구분선입니다. 개별 항목 사이에는 사용하지 않습니다.
public struct FoundesignMenuDivider: View {
  @Environment(\.theme) private var theme

  /// 그룹 구분선을 만듭니다.
  public init() {}

  public var body: some View {
    Rectangle()
      .fill(theme.color.border.base)
      // 그룹 경계는 크기와 관계없이 얇은 선으로 표시합니다.
      .frame(height: 1)
      .padding(.horizontal, theme.spacing.large)
      .padding(.vertical, theme.spacing.small)
  }
}
