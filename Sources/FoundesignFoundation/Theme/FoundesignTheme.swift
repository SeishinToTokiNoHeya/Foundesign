import Foundation

public struct FoundesignTheme: Hashable, Sendable {
  public var color: ColorToken
  public var radius: RadiusToken
  public var spacing: SpacingToken
  public var typography: TypographyToken

  public init(
    color: ColorToken,
    radius: RadiusToken,
    spacing: SpacingToken,
    typography: TypographyToken
  ) {
    self.color = color
    self.radius = radius
    self.spacing = spacing
    self.typography = typography
  }
}
