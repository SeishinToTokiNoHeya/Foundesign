# 테마 적용과 토큰 선택

용도에 맞는 토큰을 선택하고 화면 안의 뷰에 커스텀 테마를 적용합니다.

## Overview

``ColorPalette``는 색상 단계의 집합이고 ``ColorToken``은 전경·배경·테두리처럼
사용 목적에 맞는 색상입니다. 일반적인 컴포넌트는 용도에 맞는 토큰을 사용합니다.
앱의 화면도 전경·배경 같은 역할을 기준으로 토큰을 선택하면 테마를 교체할 때 함께 바뀝니다.

```swift
import Foundesign
import SwiftUI

struct ThemeExample: View {
  private var theme: FoundesignTheme {
    var theme = FoundesignTheme(brand: ColorPalette.default.green)
    theme.radius.large = 18
    return theme
  }

  var body: some View {
    ThemedMessage()
      .environment(\.theme, theme)
  }
}

private struct ThemedMessage: View {
  @Environment(\.theme) private var theme

  var body: some View {
    Text("테마가 적용된 화면")
      .typography(theme.typography.title.small)
      .foregroundStyle(theme.color.foreground.primary)
      .padding(theme.spacing.large)
      .background(theme.color.background.base)
      .clipShape(.rect(cornerRadius: theme.radius.large))
  }
}
```

환경을 주입하지 않으면 ``FoundesignTheme/default``를 사용합니다.
팔레트로 테마를 생성할 때 브랜드 스케일을 생략하면 팔레트의 파란색 스케일을 사용합니다.
색상 외 토큰까지 바꾸려면 테마의 프로퍼티를 수정하거나 토큰을 받는 initializer를 사용합니다.

## 기준색으로 Brand 생성하기

공통 HEX 하나로 두 모드의 Brand 테마를 생성할 수 있습니다.

```swift
import Foundesign
import SwiftUI

struct BrandThemeExample: View {
  private let theme = FoundesignTheme(brandHex: 0xFF6600)

  var body: some View {
    Button("계속") {}
      .buttonStyle(.solid)
      .environment(\.theme, theme)
  }
}
```

모드별 기준색이 있으면 `FoundesignTheme(lightHex: 0xFF6600, darkHex: 0xA78DF0)`를 사용합니다.
고정 `Color`나 Asset은 `FoundesignTheme(brandColor: Color("BrandSeed"))`로 전달합니다.
`BrandSeed`는 호출하는 앱의 Asset에 등록한 색상 이름입니다.
두 `Color`를 직접 지정하려면 `Color.adaptive(light:dark:)`로 조합해 전달합니다.

현재 뷰의 환경 조건을 반영하려면 환경을 함께 전달합니다.

```swift
import Foundesign
import SwiftUI

struct AssetBrandThemeExample: View {
  @Environment(\.self) private var environment

  var body: some View {
    Button("계속") {}
      .buttonStyle(.solid)
      .environment(
        \.theme,
        FoundesignTheme(brandColor: Color("BrandSeed"), environment: environment)
      )
  }
}
```

생성한 단계 일부를 조정할 때는 스케일을 먼저 만든 뒤 기존 테마 initializer에 전달합니다.

```swift
import Foundesign
import SwiftUI

func customizedBrandTheme() -> FoundesignTheme {
  var brand = ColorPalette.Scale(lightHex: 0xFF6600, darkHex: 0xA78DF0)
  brand[.`700`] = .adaptive(light: 0xE14D00, dark: 0xA78DF0)
  return FoundesignTheme(brand: brand)
}
```

입력 해석과 생성 규칙은 ``ColorPalette/Scale/init(seedHex:)``,
``ColorPalette/Scale/init(lightHex:darkHex:)``, ``ColorPalette/Scale/init(seed:environment:)``를 참고하세요.
색상 예제의 **Brand 생성**에서 입력 방식과 기준색을 바꾸며 두 모드의 팔레트와 버튼을 비교할 수 있습니다.

## 값을 바꿀 때

간격과 모서리 값은 포인트 단위입니다. 특정 컴포넌트의 픽셀 크기를 모든 토큰에 일괄 적용하기보다
토큰의 의미와 이를 사용하는 컴포넌트를 함께 확인합니다.
밝은·어두운 모드와 활성·비활성 상태를 확인하고, 타이포그래피의 글자 크기 반응은 실제 Font 구성에 따라 검증합니다.

## 관련 API와 실행 예제

- ``FoundesignTheme``: 테마 생성, 기본값과 환경 주입.
- ``ColorToken``과 ``TypographyToken``: 색상과 글꼴의 역할별 토큰.
- ``SpacingToken``과 ``RadiusToken``: 간격과 모서리 값.
- [색상·테마 전체 예제](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Example/Example/Pages/Foundation/ColorExamplePage.swift).
- [타이포그래피 전체 예제](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Example/Example/Pages/Foundation/FontExamplePage.swift).
