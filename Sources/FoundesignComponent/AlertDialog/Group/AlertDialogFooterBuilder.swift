import SwiftUI

/// Primary 버튼 하나 또는 primary, secondary 순서의 두 버튼으로 footer를 구성합니다.
///
/// Primary는 `FoundesignSolidButtonStyle`, secondary는 `FoundesignWeakButtonStyle`을 사용합니다.
@MainActor
@resultBuilder
public enum AlertDialogFooterBuilder {
  public static func buildBlock(
    _ primary: AlertDialogButtonItem<FoundesignSolidButtonStyle>
  ) -> AlertDialogButtonItem<FoundesignSolidButtonStyle> {
    primary
  }

  public static func buildBlock(
    _ primary: AlertDialogButtonItem<FoundesignSolidButtonStyle>,
    _ secondary: AlertDialogButtonItem<FoundesignWeakButtonStyle>
  ) -> AdaptiveButtonGroup<
    AlertDialogButtonItem<FoundesignSolidButtonStyle>,
    AlertDialogButtonItem<FoundesignWeakButtonStyle>
  > {
    AdaptiveButtonGroup {
      primary
    } secondary: {
      secondary
    }
  }
}
