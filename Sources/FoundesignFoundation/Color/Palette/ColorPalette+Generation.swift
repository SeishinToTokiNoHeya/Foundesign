import SwiftUI

extension ColorPalette.Scale {
  /// 두 모드에 공통 기준색을 사용하여 100~1000 스케일을 생성합니다.
  ///
  /// 기준색의 색조·채도를 사용하고 단계별 밝기를 조정하므로 원본 색상의 포함은 보장하지 않습니다.
  /// 생성 결과는 불투명 sRGB이며, 사용 흐름은 <doc:Theming>을 참고하세요.
  /// - Parameter seedHex: 하위 24비트를 RGB로 해석하는 공통 기준색입니다.
  public init(seedHex: UInt) {
    self.init(lightHex: seedHex, darkHex: seedHex)
  }

  /// 모드별 기준색으로 밝은 모드와 어두운 모드의 100~1000 스케일을 생성합니다.
  ///
  /// 각 기준색의 색조·채도를 사용하고 밝기는 단계에 맞게 조정합니다.
  /// 원본 색상의 포함은 보장하지 않으며 결과는 불투명 sRGB입니다.
  /// - Parameters:
  ///   - lightHex: 하위 24비트를 RGB로 해석하는 밝은 모드 기준색입니다.
  ///   - darkHex: 하위 24비트를 RGB로 해석하는 어두운 모드 기준색입니다.
  public init(lightHex: UInt, darkHex: UInt) {
    self.init(light: PaletteSeed(hex: lightHex), dark: PaletteSeed(hex: darkHex))
  }

  /// 색상을 두 모드에서 해석하여 100~1000 스케일을 생성합니다.
  ///
  /// 전달한 환경의 색상 모드만 바꿔 생성 시점에 각각 해석합니다.
  /// Asset·동적 색상의 다른 환경 조건이 바뀌면 스케일을 다시 생성해야 합니다.
  /// 투명도는 무시하며 배경과 합성하지 않습니다. 넓은 색역 입력도 최종 결과는 sRGB로 제한합니다.
  /// 기준색의 색조·채도를 사용하고 밝기를 조정하므로 원본 색상의 포함은 보장하지 않습니다.
  /// - Parameters:
  ///   - seed: 고정 색상 또는 모드별 값이 있는 동적 색상입니다.
  ///   - environment: 색상 해석에 사용할 환경입니다. 생략하면 기본 환경을 사용합니다.
  public init(seed: Color, environment: EnvironmentValues = .init()) {
    // 뷰에서 받은 환경은 모드 설정 직후 해석해 Asset의 모드별 결과가 섞이지 않게 합니다.
    var resolvedEnvironment = environment
    resolvedEnvironment.colorScheme = .light
    let light = PaletteSeed(resolved: seed.resolve(in: resolvedEnvironment))
    resolvedEnvironment.colorScheme = .dark
    let dark = PaletteSeed(resolved: seed.resolve(in: resolvedEnvironment))
    self.init(light: light, dark: dark)
  }

  private init(light: PaletteSeed, dark: PaletteSeed) {
    let lightness = [0.97, 0.94, 0.89, 0.82, 0.74, 0.65, 0.56, 0.47, 0.37, 0.25]
    let darkLightness = [0.26, 0.32, 0.39, 0.46, 0.53, 0.60, 0.69, 0.78, 0.87, 0.95]
    let chroma = [0.15, 0.30, 0.50, 0.70, 0.90, 1.00, 1.00, 0.80, 0.50, 0.20]
    let colors = lightness.indices.map { index in
      Color.adaptive(
        light: light.hex(lightness: lightness[index], chromaScale: chroma[index]),
        dark: dark.hex(lightness: darkLightness[index], chromaScale: chroma[index])
      )
    }
    self.init(
      `100`: colors[0], `200`: colors[1], `300`: colors[2], `400`: colors[3],
      `500`: colors[4], `600`: colors[5], `700`: colors[6], `800`: colors[7],
      `900`: colors[8], `1000`: colors[9]
    )
  }
}

/// OKLab의 a/b 방향을 유지하고 밝기·채도만 바꿔 OKLCH 단계를 생성합니다.
private struct PaletteSeed {
  private let a: Double
  private let b: Double

  init(hex: UInt) {
    func linear(_ shift: Int) -> Double {
      let value = Double((hex >> shift) & 0xFF) / 255
      return value <= 0.04045 ? value / 12.92 : pow((value + 0.055) / 1.055, 2.4)
    }
    self.init(red: linear(16), green: linear(8), blue: linear(0))
  }

  init(resolved: Color.Resolved) {
    self.init(
      red: Double(resolved.linearRed),
      green: Double(resolved.linearGreen),
      blue: Double(resolved.linearBlue)
    )
  }

  // Björn Ottosson의 공개 OKLab 변환 행렬을 사용합니다.
  // https://bottosson.github.io/posts/oklab/
  private init(red: Double, green: Double, blue: Double) {
    let l = cbrt(0.4122214708 * red + 0.5363325363 * green + 0.0514459929 * blue)
    let m = cbrt(0.2119034982 * red + 0.6806995451 * green + 0.1073969566 * blue)
    let s = cbrt(0.0883024619 * red + 0.2817188376 * green + 0.6299787005 * blue)
    let a = 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s
    let b = 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
    let isNeutral = hypot(a, b) < 0.00001
    self.a = isNeutral ? 0 : a
    self.b = isNeutral ? 0 : b
  }

  func hex(lightness: Double, chromaScale: Double) -> UInt {
    func rgb(_ scale: Double) -> (Double, Double, Double) {
      let a = a * scale
      let b = b * scale
      let l = pow(lightness + 0.3963377774 * a + 0.2158037573 * b, 3)
      let m = pow(lightness - 0.1055613458 * a - 0.0638541728 * b, 3)
      let s = pow(lightness - 0.0894841775 * a - 1.2914855480 * b, 3)
      return (
        4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
        -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
        -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
      )
    }

    func inGamut(_ value: (Double, Double, Double)) -> Bool {
      (0...1).contains(value.0) && (0...1).contains(value.1) && (0...1).contains(value.2)
    }

    var value = rgb(chromaScale)

    if !inGamut(value) {
      var lower = 0.0
      var upper = chromaScale

      // 색조와 밝기를 보존하면서 sRGB 경계 안의 최대 채도를 찾습니다.
      for _ in 0..<24 {
        let middle = (lower + upper) / 2

        if inGamut(rgb(middle)) {
          lower = middle
        } else {
          upper = middle
        }
      }
      value = rgb(lower)
    }

    func channel(_ linear: Double) -> UInt {
      let value = min(1, max(0, linear))
      let encoded = value <= 0.0031308 ? 12.92 * value : 1.055 * pow(value, 1 / 2.4) - 0.055
      return UInt((encoded * 255).rounded())
    }
    return channel(value.0) << 16 | channel(value.1) << 8 | channel(value.2)
  }
}
