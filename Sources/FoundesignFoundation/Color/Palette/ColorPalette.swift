import SwiftUI

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
