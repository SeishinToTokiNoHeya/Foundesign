import FoundesignFoundation
import SwiftUI

/// Checkbox를 세로로 배치합니다. 헤더가 있으면 강조해서 표시하고 하위 항목을 들여씁니다.
/// 그룹의 Property는 내부 Item에 함께 적용되며, 그룹을 중첩해서 하위 항목을 구성할 수 있습니다.
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

  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder header: () -> Header
  ) {
    self.content = content()
    self.header = header()
  }

  public init(@ViewBuilder content: () -> Content) where Header == EmptyView {
    self.content = content()
    self.header = nil
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
      if let header {
        header
          .checkboxWeight(.bold)

        HStack(alignment: .top, spacing: theme.spacing.small) {
          FoundedCheckmark()
            .checkboxWeight(.bold)
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
