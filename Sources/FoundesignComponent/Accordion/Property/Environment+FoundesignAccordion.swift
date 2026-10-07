import SwiftUI

extension EnvironmentValues {
  @Entry var accordionSize: FoundesignAccordionSize = .medium
  @Entry var accordionStyle: FoundesignAccordionStyle = .inline
}

extension View {
  /// 하위 Accordion 항목에 공통 크기를 적용합니다.
  /// - Parameter size: 글꼴·여백·모서리에 사용할 크기입니다. 기본값은 `.medium`이며 가까운 설정이 우선합니다.
  /// - Returns: 크기가 설정된 뷰입니다.
  public func accordionSize(_ size: FoundesignAccordionSize) -> some View {
    environment(\.accordionSize, size)
  }

  /// 하위 Accordion 항목의 구분 스타일을 설정합니다.
  /// 그룹의 구분선에도 함께 적용하려면 컨테이너에 설정합니다.
  /// - Parameter style: 적용할 스타일입니다. 환경 기본값은 `.inline`입니다.
  /// - Returns: 스타일이 설정된 뷰입니다.
  public func accordionStyle(_ style: FoundesignAccordionStyle) -> some View {
    environment(\.accordionStyle, style)
  }
}
