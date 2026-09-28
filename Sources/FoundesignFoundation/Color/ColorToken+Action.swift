import SwiftUI

extension ColorToken {
  public struct Action: Hashable, Sendable {
    public var primary: State
    public var secondary: State
    public var neutral: State
    public var destructive: State

    public init(
      primary: State,
      secondary: State,
      neutral: State,
      destructive: State
    ) {
      self.primary = primary
      self.secondary = secondary
      self.neutral = neutral
      self.destructive = destructive
    }
  }
}

extension ColorToken.Action {
  public struct State: Hashable, Sendable {
    public var normal: Color
    public var pressed: Color
    public var focused: Color
    public var disabled: Color

    public init(
      normal: Color,
      pressed: Color,
      focused: Color,
      disabled: Color
    ) {
      self.normal = normal
      self.pressed = pressed
      self.focused = focused
      self.disabled = disabled
    }
  }
}
