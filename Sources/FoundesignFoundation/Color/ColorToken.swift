import Foundation

public struct ColorToken: Hashable, Sendable {
  public var action: Action
  public var background: Background
  public var text: Text

  public init(
    action: Action,
    background: Background,
    text: Text
  ) {
    self.action = action
    self.background = background
    self.text = text
  }
}
