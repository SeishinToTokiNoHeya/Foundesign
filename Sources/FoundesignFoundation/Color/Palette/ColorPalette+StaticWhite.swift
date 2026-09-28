import SwiftUI

extension ColorPalette {
  public struct StaticWhite: Hashable, Sendable {
    public var `default`: Color
    public var alpha100: Color
    public var alpha200: Color
    public var alpha300: Color
    public var alpha400: Color
    public var alpha500: Color
    public var alpha600: Color
    public var alpha700: Color
    public var alpha800: Color
    public var alpha900: Color
    public var alpha1000: Color

    public init(
      `default`: Color,
      alpha100: Color,
      alpha200: Color,
      alpha300: Color,
      alpha400: Color,
      alpha500: Color,
      alpha600: Color,
      alpha700: Color,
      alpha800: Color,
      alpha900: Color,
      alpha1000: Color
    ) {
      self.`default` = `default`
      self.alpha100 = alpha100
      self.alpha200 = alpha200
      self.alpha300 = alpha300
      self.alpha400 = alpha400
      self.alpha500 = alpha500
      self.alpha600 = alpha600
      self.alpha700 = alpha700
      self.alpha800 = alpha800
      self.alpha900 = alpha900
      self.alpha1000 = alpha1000
    }
  }
}
