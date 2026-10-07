import SwiftUI

/// Primary 버튼 하나 또는 primary, secondary 순서의 두 버튼으로 footer를 구성합니다.
///
/// Primary는 `FoundesignSolidButtonStyle`, secondary는 `FoundesignWeakButtonStyle`을 사용합니다.
@MainActor
@resultBuilder
public enum FoundesignAlertDialogFooterBuilder {
  public static func buildBlock(
    _ primary: FoundesignAlertDialogButtonItem<FoundesignSolidButtonStyle>
  ) -> FoundesignAlertDialogButtonItem<FoundesignSolidButtonStyle> {
    primary
  }

  public static func buildBlock(
    _ primary: FoundesignAlertDialogButtonItem<FoundesignSolidButtonStyle>,
    _ secondary: FoundesignAlertDialogButtonItem<FoundesignWeakButtonStyle>
  ) -> FoundesignAdaptiveButtonGroup<
    FoundesignAlertDialogButtonItem<FoundesignSolidButtonStyle>,
    FoundesignAlertDialogButtonItem<FoundesignWeakButtonStyle>
  > {
    FoundesignAdaptiveButtonGroup {
      primary
    } secondary: {
      secondary
    }
  }
}
