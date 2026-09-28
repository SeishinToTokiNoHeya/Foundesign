import Foundation

public struct ColorToken: Hashable, Sendable {
  public var action: Action
  public var background: Background
  public var border: Border
  public var text: Text

  public init(
    action: Action,
    background: Background,
    border: Border,
    text: Text
  ) {
    self.action = action
    self.background = background
    self.border = border
    self.text = text
  }
}
