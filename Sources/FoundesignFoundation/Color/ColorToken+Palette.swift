import SwiftUI

extension ColorToken {
  /// 팔레트의 색상 단계로 의미별 색상과 상태별 색상을 생성합니다.
  ///
  /// - Parameters:
  ///   - palette: 원시 색상 팔레트입니다. 기본값은 ``ColorPalette/default``입니다.
  ///   - brand: 브랜드 스케일입니다. 생략하면 `palette.blue`를 사용합니다.
  public init(
    palette: ColorPalette = .default,
    brand: ColorPalette.Scale? = nil
  ) {
    let brand = brand ?? palette.blue
    let disabled = Color.adaptive(light: palette.gray[.`200`], dark: palette.gray[.`300`])
    let inverse = Color.adaptive(light: palette.gray[.`900`], dark: palette.gray[.`1000`])

    self.init(
      foreground: .init(
        primary: palette.gray[.`1000`],
        secondary: palette.gray[.`800`],
        tertiary: palette.gray[.`700`],
        inverse: .adaptive(light: palette.gray[.`0`], dark: palette.gray[.`100`]),
        disabled: palette.gray[.`500`],
        placeholder: palette.gray[.`600`],
        link: brand[.`700`],
        brand: ColorToken.foregroundRole(brand, solid: palette.white),
        informative: ColorToken.foregroundRole(palette.blue, solid: palette.white),
        positive: ColorToken.foregroundRole(palette.green, solid: palette.white),
        warning: ColorToken.foregroundRole(palette.yellow, solid: palette.blackAlpha[.`900`]),
        critical: ColorToken.foregroundRole(palette.red, solid: palette.white)
      ),
      background: .init(
        base: .adaptive(light: palette.gray[.`0`], dark: palette.gray[.`100`]),
        subtle: .adaptive(light: palette.gray[.`200`], dark: palette.gray[.`0`]),
        elevated: .adaptive(light: palette.gray[.`0`], dark: palette.gray[.`200`]),
        overlay: palette.blackAlpha[.`700`],
        inverse: inverse,
        disabled: disabled,
        transparent: ColorToken.state(
          normal: .clear,
          pressed: .adaptive(light: palette.blackAlpha[.`100`], dark: palette.whiteAlpha[.`50`]),
          disabled: .clear
        ),
        neutral: .init(
          solid: ColorToken.state(
            normal: inverse, pressed: palette.gray[.`800`], disabled: disabled),
          weak: ColorToken.state(
            normal: .adaptive(light: palette.gray[.`200`], dark: palette.gray[.`300`]),
            pressed: .adaptive(light: palette.gray[.`300`], dark: palette.gray[.`400`]),
            disabled: disabled
          )
        ),
        brand: ColorToken.backgroundRole(brand, disabled: disabled),
        informative: ColorToken.backgroundRole(palette.blue, disabled: disabled),
        positive: ColorToken.backgroundRole(
          palette.green,
          solid: (.`700`, .`500`),
          pressed: (.`800`, .`600`),
          disabled: disabled
        ),
        warning: ColorToken.backgroundRole(
          palette.yellow,
          solid: (.`300`, .`800`),
          pressed: (.`400`, .`900`),
          disabled: disabled
        ),
        critical: ColorToken.backgroundRole(palette.red, disabled: disabled)
      ),
      border: .init(
        base: palette.gray[.`400`],
        subtle: .adaptive(light: palette.blackAlpha[.`200`], dark: palette.whiteAlpha[.`50`]),
        strong: palette.gray[.`800`],
        focus: brand[.`600`],
        disabled: .adaptive(light: palette.blackAlpha[.`300`], dark: palette.whiteAlpha[.`100`]),
        brand: ColorToken.borderRole(brand),
        informative: ColorToken.borderRole(palette.blue),
        positive: ColorToken.borderRole(palette.green),
        warning: ColorToken.borderRole(palette.yellow),
        critical: ColorToken.borderRole(palette.red)
      )
    )
  }

  private static func foregroundRole(
    _ scale: ColorPalette.Scale,
    solid: Color
  ) -> Foreground.Role {
    .init(normal: scale[.`700`], strong: scale[.`900`], solid: solid)
  }

  private static func backgroundRole(
    _ scale: ColorPalette.Scale,
    solid: (light: ColorPalette.Scale.Step, dark: ColorPalette.Scale.Step) = (.`700`, .`600`),
    pressed: (light: ColorPalette.Scale.Step, dark: ColorPalette.Scale.Step) = (.`800`, .`700`),
    disabled: Color
  ) -> Background.Role {
    .init(
      solid: state(
        normal: .adaptive(light: scale[solid.light], dark: scale[solid.dark]),
        pressed: .adaptive(light: scale[pressed.light], dark: scale[pressed.dark]),
        disabled: disabled
      ),
      weak: state(normal: scale[.`100`], pressed: scale[.`200`], disabled: disabled)
    )
  }

  private static func state(normal: Color, pressed: Color, disabled: Color) -> State {
    .init(normal: normal, pressed: pressed, focused: normal, disabled: disabled)
  }

  private static func borderRole(_ scale: ColorPalette.Scale) -> Border.Role {
    .init(weak: scale[.`300`], solid: scale[.`700`])
  }
}
