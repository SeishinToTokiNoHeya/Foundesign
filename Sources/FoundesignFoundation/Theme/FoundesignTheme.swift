import Foundation

public struct FoundesignTheme: Hashable, Sendable {
  public var color: ColorToken
  public var typography: TypographyToken

  public init(
    color: ColorToken,
    typography: TypographyToken
  ) {
    self.color = color
    self.typography = typography
  }
}
