import SwiftUI

/// 의미별 색상 토큰을 만드는 데 사용하는 원시 색상 스케일의 집합입니다.
///
/// 앱의 브랜드 스케일이나 색상 단계를 바꿀 때 사용합니다.
/// 컴포넌트에서 사용할 색상은 ``ColorToken``으로 변환해 역할에 맞게 선택합니다.
public struct ColorPalette: Hashable, Sendable {
  public var gray: GrayScale
  public var orange: Scale
  public var blue: Scale
  public var green: Scale
  public var yellow: Scale
  public var red: Scale
  public var purple: Scale
  public var black: Color
  public var white: Color
  public var blackAlpha: Scale
  public var whiteAlpha: WhiteAlphaScale

  public init(
    gray: GrayScale,
    orange: Scale,
    blue: Scale,
    green: Scale,
    yellow: Scale,
    red: Scale,
    purple: Scale,
    black: Color,
    white: Color,
    blackAlpha: Scale,
    whiteAlpha: WhiteAlphaScale
  ) {
    self.gray = gray
    self.orange = orange
    self.blue = blue
    self.green = green
    self.yellow = yellow
    self.red = red
    self.purple = purple
    self.black = black
    self.white = white
    self.blackAlpha = blackAlpha
    self.whiteAlpha = whiteAlpha
  }
}
