import Foundation

public struct FoundesignTheme: Hashable, Sendable {
  public var color: ColorToken

  public init(color: ColorToken) {
    self.color = color
  }
}
