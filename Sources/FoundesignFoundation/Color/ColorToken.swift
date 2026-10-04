import Foundation

/// 전경·배경·테두리의 사용 목적에 따라 선택하는 의미별 색상입니다.
///
/// 원시 색상 단계는 ``ColorPalette``에서 정의하고, 컴포넌트는 이 토큰으로 색상을 선택합니다.
public struct ColorToken: Hashable, Sendable {
  /// 텍스트와 아이콘 등 전경의 색상입니다.
  public var foreground: Foreground
  /// 화면과 컨트롤 배경의 색상입니다.
  public var background: Background
  /// 경계와 포커스 표시의 색상입니다.
  public var border: Border

  /// 용도별 색상 묶음으로 토큰을 구성합니다.
  ///
  /// - Parameters:
  ///   - foreground: 전경 색상입니다.
  ///   - background: 배경 색상입니다.
  ///   - border: 테두리 색상입니다.
  public init(
    foreground: Foreground,
    background: Background,
    border: Border
  ) {
    self.foreground = foreground
    self.background = background
    self.border = border
  }
}
