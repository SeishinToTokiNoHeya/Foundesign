import SwiftUI

extension FoundesignTheme {
  /// 공통 HEX 기준색으로 두 모드의 Brand 스케일을 생성하여 테마를 구성합니다.
  ///
  /// 생성 규칙은 ``ColorPalette/Scale/init(seedHex:)``를 참고하세요.
  /// 모서리·간격·타이포그래피는 기본값을 사용합니다.
  /// - Parameters:
  ///   - palette: Brand 이외 역할에 사용할 팔레트입니다.
  ///   - brandHex: 하위 24비트를 sRGB로 해석하는 공통 기준색입니다.
  public init(palette: ColorPalette = .default, brandHex: UInt) {
    self.init(palette: palette, brand: .init(seedHex: brandHex))
  }

  /// 모드별 HEX 기준색으로 Brand 스케일을 생성하여 테마를 구성합니다.
  ///
  /// 생성 규칙은 ``ColorPalette/Scale/init(lightHex:darkHex:)``를 참고하세요.
  /// 모서리·간격·타이포그래피는 기본값을 사용합니다.
  /// - Parameters:
  ///   - palette: Brand 이외 역할에 사용할 팔레트입니다.
  ///   - lightHex: 밝은 모드의 기준색입니다. 하위 24비트를 sRGB로 해석합니다.
  ///   - darkHex: 어두운 모드의 기준색입니다. 하위 24비트를 sRGB로 해석합니다.
  public init(palette: ColorPalette = .default, lightHex: UInt, darkHex: UInt) {
    self.init(palette: palette, brand: .init(lightHex: lightHex, darkHex: darkHex))
  }

  /// Color를 두 모드에서 해석하여 Brand 테마를 구성합니다.
  ///
  /// 생성 시점에 색상을 해석하며 투명도는 무시합니다. 다른 환경 조건이 바뀌면 다시 생성합니다.
  /// 생성 규칙은 ``ColorPalette/Scale/init(seed:environment:)``를 참고하세요.
  /// 모서리·간격·타이포그래피는 기본값을 사용합니다.
  /// - Parameters:
  ///   - palette: Brand 이외 역할에 사용할 팔레트입니다.
  ///   - brandColor: 고정 색상 또는 Asset·동적 색상인 기준색입니다.
  ///   - environment: 색상 모드 이외의 해석 조건을 제공하는 환경입니다. 생략하면 기본 환경입니다.
  public init(
    palette: ColorPalette = .default,
    brandColor: Color,
    environment: EnvironmentValues = .init()
  ) {
    self.init(palette: palette, brand: .init(seed: brandColor, environment: environment))
  }
}
