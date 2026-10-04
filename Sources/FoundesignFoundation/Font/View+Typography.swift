import SwiftUI

extension View {
  /// 지정한 타이포그래피의 글꼴을 뷰에 적용합니다.
  ///
  /// - Parameter typography: 적용할 글꼴을 담은 값입니다.
  /// - Returns: 글꼴이 설정된 뷰입니다. 색상·행간은 변경하지 않습니다.
  public func typography(_ typography: Typography) -> some View {
    modifier(TypographyModifier(typography: typography))
  }
}

private struct TypographyModifier: ViewModifier {
  let typography: Typography

  func body(content: Content) -> some View {
    content
      .font(typography.font)
  }
}
