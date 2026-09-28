import SwiftUI

public struct ColorPalette: Hashable, Sendable {
  public var blue: Blue
  public var brand: Brand
  public var gray: Gray
  public var green: Green
  public var red: Red
  public var staticBlack: StaticBlack
  public var staticWhite: StaticWhite
  public var yellow: Yellow

  public init(
    blue: Blue,
    brand: Brand,
    gray: Gray,
    green: Green,
    red: Red,
    staticBlack: StaticBlack,
    staticWhite: StaticWhite,
    yellow: Yellow
  ) {
    self.blue = blue
    self.brand = brand
    self.gray = gray
    self.green = green
    self.red = red
    self.staticBlack = staticBlack
    self.staticWhite = staticWhite
    self.yellow = yellow
  }
}
