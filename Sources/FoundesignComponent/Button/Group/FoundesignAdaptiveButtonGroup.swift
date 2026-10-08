import FoundesignFoundation
import SwiftUI

/// 내부 컨텐츠의 크기에 따라 레이아웃이 변경되는 버튼 그룹 컴포넌트입니다.
///
/// 두 버튼의 이상적인 너비가 주어진 폭에 들어가면 가로로, 그렇지 않으면 세로로 배치합니다.
/// 가로 배치는 secondary → primary, 세로 배치는 primary → secondary 순서입니다.
///
/// 버튼을 추가할 때는 내부 영역을 infinite로 설정하여 컨텐츠를 꽉 채우는 것을 권장합니다.
///
/// ```swift
/// FoundesignAdaptiveButtonGroup {
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
public struct FoundesignAdaptiveButtonGroup<Primary, Secondary>: View
where Primary: View, Secondary: View {
  @Environment(\.theme) private var theme
  private let primary: Primary
  private let secondary: Secondary

  /// 주 동작과 보조 동작을 수행하는 두 뷰로 그룹을 만듭니다.
  /// - Parameters:
  ///   - primary: 가로에서는 오른쪽, 세로에서는 위에 배치할 주 동작입니다.
  ///   - secondary: 가로에서는 왼쪽, 세로에서는 아래에 배치할 보조 동작입니다.
  public init(
    @ViewBuilder primary: () -> Primary,
    @ViewBuilder secondary: () -> Secondary
  ) {
    self.primary = primary()
    self.secondary = secondary()
  }

  public var body: some View {
    FoundesignAdaptiveButtonLayout(spacing: theme.spacing.medium) {
      primary
        .frame(maxWidth: .infinity)

      secondary
        .frame(maxWidth: .infinity)
    }
  }
}
