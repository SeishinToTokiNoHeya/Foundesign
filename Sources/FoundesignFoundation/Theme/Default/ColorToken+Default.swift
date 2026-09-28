import SwiftUI

extension ColorToken {
  public static let `default` = ColorToken(
    action: .default,
    background: .default,
    border: .default,
    text: .default
  )
}

extension ColorToken.Action {
  public static let `default` = ColorToken.Action(
    primary: .init(
      normal: .adaptive(light: 0x217CF9, dark: 0x41A2F9),
      pressed: .adaptive(light: 0x135FCD, dark: 0x83BCF9),
      focused: .adaptive(light: 0x217CF9, dark: 0x41A2F9),
      disabled: .adaptive(light: 0xF3F4F5, dark: 0x1D2025)
    ),
    secondary: .init(
      normal: .adaptive(light: 0xEFF6FF, dark: 0x202742),
      pressed: .adaptive(light: 0xE2EDFC, dark: 0x1E3352),
      focused: .adaptive(light: 0xEFF6FF, dark: 0x202742),
      disabled: .adaptive(light: 0xF3F4F5, dark: 0x1D2025)
    ),
    neutral: .init(
      normal: .adaptive(light: 0x1A1C20, dark: 0xF3F4F5),
      pressed: .adaptive(light: 0x2A3038, dark: 0xE9EAEC),
      focused: .adaptive(light: 0x1A1C20, dark: 0xF3F4F5),
      disabled: .adaptive(light: 0xF3F4F5, dark: 0x1D2025)
    ),
    destructive: .init(
      normal: .adaptive(light: 0xFA342C, dark: 0xFF6E60),
      pressed: .adaptive(light: 0xCA1D13, dark: 0xFFA299),
      focused: .adaptive(light: 0xFA342C, dark: 0xFF6E60),
      disabled: .adaptive(light: 0xF3F4F5, dark: 0x1D2025)
    )
  )
}

extension ColorToken.Background {
  public static let `default` = ColorToken.Background(
    base: .adaptive(light: 0xFFFFFF, dark: 0x16171B),
    subtle: .adaptive(light: 0xF3F4F5, dark: 0x000000),
    elevated: .adaptive(light: 0xFFFFFF, dark: 0x1D2025),
    overlay: .adaptive(
      light: 0x000000,
      dark: 0x000000,
      lightOpacity: 116.0 / 255.0
    ),
    inverse: .adaptive(light: 0x2A3038, dark: 0xE9EAEC)
  )
}

extension ColorToken.Border {
  public static let `default` = ColorToken.Border(
    base: .adaptive(light: 0xDCDEE3, dark: 0x393D46),
    subtle: .adaptive(
      light: 0x000000,
      dark: 0xFFFFFF,
      lightOpacity: 12.0 / 255.0,
      darkOpacity: 13.0 / 255.0
    ),
    strong: .adaptive(light: 0x555D6D, dark: 0xDCDEE3),
    focus: .adaptive(light: 0x5E98FE, dark: 0x1E82EB),
    disabled: .adaptive(
      light: 0x000000,
      dark: 0xFFFFFF,
      lightOpacity: 16.0 / 255.0,
      darkOpacity: 23.0 / 255.0
    ),
    destructive: .adaptive(light: 0xFA342C, dark: 0xFF6E60)
  )
}

extension ColorToken.Text {
  public static let `default` = ColorToken.Text(
    primary: .adaptive(light: 0x1A1C20, dark: 0xF3F4F5),
    secondary: .adaptive(light: 0x555D6D, dark: 0xDCDEE3),
    tertiary: .adaptive(light: 0x868B94, dark: 0xB0B3BA),
    disabled: .adaptive(light: 0xD1D3D8, dark: 0x5B606A),
    inverse: .adaptive(light: 0xFFFFFF, dark: 0x16171B),
    link: .adaptive(light: 0x217CF9, dark: 0x41A2F9),
    destructive: .adaptive(light: 0xFA342C, dark: 0xFF6E60)
  )
}
