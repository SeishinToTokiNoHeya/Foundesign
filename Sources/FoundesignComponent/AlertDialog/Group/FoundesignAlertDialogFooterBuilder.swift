import SwiftUI

/// Primary 하나 또는 primary·secondary 순서의 두 뷰로 footer를 구성합니다.
///
/// 첫 번째 뷰에 `.solid`, 두 번째 뷰에 `.weak` 버튼 스타일을 제공합니다.
/// 항목에 붙인 `.buttonStyle` 등 일반 View modifier는 그대로 유지되며 항목의 설정이 우선합니다.
/// 자동 닫힘이 필요한 버튼에는 ``FoundesignAlertDialogButtonItem``을 사용합니다.
@MainActor
@resultBuilder
public enum FoundesignAlertDialogFooterBuilder {
  public static func buildBlock<Primary: View>(_ primary: Primary) -> some View {
    primary.buttonStyle(.solid)
  }

  public static func buildBlock<Primary: View, Secondary: View>(
    _ primary: Primary,
    _ secondary: Secondary
  ) -> some View {
    FoundesignAdaptiveButtonGroup {
      primary.buttonStyle(.solid)
    } secondary: {
      secondary.buttonStyle(.weak)
    }
  }
}
