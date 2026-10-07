import FoundesignFoundation
import SwiftUI

/// Checkbox를 세로로 배치합니다. 헤더가 있으면 강조해서 표시하고 하위 항목을 들여씁니다.
/// 그룹의 Property는 내부 Item에 함께 적용되며, 그룹을 중첩해서 하위 항목을 구성할 수 있습니다.
/// 글꼴 강조를 지정하지 않은 헤더는 `.bold`를 사용하며, 상위 또는 항목의 설정이 우선합니다.
///
/// ```swift
/// FoundesignCheckboxGroup {
///   FoundesignCheckbox(title: "이용약관 동의", isOn: $terms)
///   FoundesignCheckbox(title: "개인정보 처리방침 동의", isOn: $privacy)
/// } header: {
///   FoundesignCheckbox(title: "전체 동의", sources: [$terms, $privacy])
/// }
/// .checkboxTone(.brand)
/// ```
public struct FoundesignCheckboxGroup<Content, Header>: View where Content: View, Header: View {
  @Environment(\.theme) private var theme

  private let content: Content
  private let header: Header?

  /// 헤더와 들여쓴 하위 항목으로 그룹을 만듭니다.
  /// - Parameters:
  ///   - content: 그룹 안에 배치할 항목입니다.
  ///   - header: 강조할 헤더입니다. 전체 선택을 사용하려면 별도의 바인딩을 연결합니다.
  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder header: () -> Header
  ) {
    self.content = content()
    self.header = header()
  }

  /// 헤더 없이 항목을 세로로 배치하는 그룹을 만듭니다.
  /// - Parameter content: 그룹 안에 배치할 항목입니다.
  public init(@ViewBuilder content: () -> Content) where Header == EmptyView {
    self.content = content()
    self.header = nil
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
      if let header {
        header
          .transformEnvironment(\.checkboxWeight) { $0 = $0 ?? .bold }

        HStack(alignment: .top, spacing: theme.spacing.small) {
          FoundesignCheckmark()
            .transformEnvironment(\.checkboxWeight) { $0 = $0 ?? .bold }
            .hidden()
            .frame(height: theme.spacing.zero)

          items
        }
      } else {
        items
      }
    }
  }

  private var items: some View {
    VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
      content
    }
  }
}
