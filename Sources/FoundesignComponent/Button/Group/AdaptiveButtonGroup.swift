import FoundesignFoundation
import SwiftUI

/// 내부 컨텐츠의 크기에 따라 레이아웃이 변경되는 버튼 그룹 컴포넌트입니다.
///
/// 내부 컨텐츠가 길어지면 Vertical로 표현되고
/// 내부 컨텐츠가 1줄로 표현되면 Horizontal로 표현됩니다.
///
/// 버튼을 추가할 때는 내부 영역을 infinite로 설정하여 컨텐츠를 꽉 채우는 것을 권장합니다.
///
/// ```swift
/// AdaptiveButtonGroup {
///   Button {
///
///   } label: {
///     Text("Primary Solid")
///       .frame(maxWidth: .infinity)
///   }
///   .buttonStyle(.solid)
/// } secondary: {
///   Button {
///
///   } label: {
///     Text("Secondary Outline")
///       .frame(maxWidth: .infinity)
///   }
///   .buttonStyle(.outline)
/// }
/// ```
public struct AdaptiveButtonGroup<Primary, Secondary>: View where Primary: View, Secondary: View {
  @Environment(\.theme) private var theme
  private let primary: Primary
  private let secondary: Secondary

  public init(
    @ViewBuilder primary: () -> Primary,
    @ViewBuilder secondary: () -> Secondary
  ) {
    self.primary = primary()
    self.secondary = secondary()
  }

  public var body: some View {
    AdaptiveButtonLayout(spacing: theme.spacing.medium) {
      primary
        .frame(maxWidth: .infinity)

      secondary
        .frame(maxWidth: .infinity)
    }
  }
}
