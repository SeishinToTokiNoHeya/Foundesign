import SwiftUI

extension FoundesignTheme {
  public static let `default` = FoundesignTheme(
    color: .default
  )
}

extension ColorToken {
  public static let `default` = ColorToken(
    action: .default,
    background: .default,
    text: .default
  )
}

extension ColorToken.Action {
  public static let `default` = ColorToken.Action(
    primary: .init(normal: .wip, pressed: .wip, focused: .wip, disabled: .wip),
    secondary: .init(normal: .wip, pressed: .wip, focused: .wip, disabled: .wip),
    neutral: .init(normal: .wip, pressed: .wip, focused: .wip, disabled: .wip),
    destructive: .init(normal: .wip, pressed: .wip, focused: .wip, disabled: .wip)
  )
}

extension ColorToken.Background {
  public static let `default` = ColorToken.Background(
    base: .wip,
    subtle: .wip,
    elevated: .wip,
    overlay: .wip,
    inverse: .wip
  )
}

extension ColorToken.Text {
  public static let `default` = ColorToken.Text(
    primary: .wip,
    secondary: .wip,
    tertiary: .wip,
    disabled: .wip,
    inverse: .wip,
    link: .wip,
    destructive: .wip
  )
}

extension Color {
  static let wip = Color.clear
}
