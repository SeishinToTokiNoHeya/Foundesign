import Foundation

/// 색상·모서리·간격·타이포그래피 토큰을 묶어 컴포넌트에 제공하는 테마입니다.
///
/// SwiftUI의 `.environment(\.theme, theme)`으로 하위 뷰에 적용합니다.
/// 주입하지 않으면 ``default``를 사용합니다. 조합 예제는 <doc:Theming>을 참고하세요.
public struct FoundesignTheme: Hashable, Sendable {
  /// 전경·배경·테두리의 의미별 색상입니다.
  public var color: ColorToken
  /// 모서리 반경을 포인트 단위로 제공하는 토큰입니다.
  public var radius: RadiusToken
  /// 배치 간격과 여백을 포인트 단위로 제공하는 토큰입니다.
  public var spacing: SpacingToken
  /// 텍스트 역할별 글꼴 토큰입니다.
  public var typography: TypographyToken

  /// 의미별 토큰으로 테마를 구성합니다.
  ///
  /// - Parameters:
  ///   - color: 컴포넌트에 적용할 의미별 색상입니다.
  ///   - radius: 모서리 토큰입니다. 기본값은 ``RadiusToken/default``입니다.
  ///   - spacing: 간격 토큰입니다. 기본값은 ``SpacingToken/default``입니다.
  ///   - typography: 글꼴 토큰입니다. 기본값은 ``TypographyToken/default``입니다.
  public init(
    color: ColorToken,
    radius: RadiusToken = .default,
    spacing: SpacingToken = .default,
    typography: TypographyToken = .default
  ) {
    self.color = color
    self.radius = radius
    self.spacing = spacing
    self.typography = typography
  }

  /// 팔레트와 선택적인 브랜드 색상으로 테마를 구성합니다.
  ///
  /// 모서리·간격·타이포그래피는 각 토큰의 기본값을 사용합니다.
  /// - Parameters:
  ///   - palette: 의미별 색상을 생성할 팔레트입니다. 기본값은 ``ColorPalette/default``입니다.
  ///   - brand: 브랜드 색상 스케일입니다. `nil`이면 `palette.blue`를 사용합니다.
  public init(
    palette: ColorPalette = .default,
    brand: ColorPalette.Scale? = nil
  ) {
    self.init(
      color: ColorToken(palette: palette, brand: brand),
      radius: .default,
      spacing: .default,
      typography: .default
    )
  }
}
