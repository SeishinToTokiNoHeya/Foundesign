# Foundesign 시작하기

버튼을 배치하고 테마를 적용하는 작은 화면을 만듭니다.

## Overview

앱에 패키지를 연결하고 기본 버튼을 만든 뒤 테마를 적용합니다.

## 패키지 연결

Xcode의 Add Package Dependencies에서
`https://github.com/SeishinToTokiNoHeya/Foundesign.git`를 추가하고 사용할 버전 또는 커밋을 선택합니다.
라이브러리 목록에서 `Foundesign`을 선택해 앱 타깃에 연결합니다.
Swift tools 6.4, iOS 17 이상 또는 macOS 14 이상이 필요합니다.

## 첫 컴포넌트

`import Foundesign`으로 컴포넌트와 토큰을 함께 사용합니다.
아래 예제는 필요한 상태를 뷰 안에서 관리하며 버튼을 누르면 횟수가 바뀝니다.

```swift
import Foundesign
import SwiftUI

struct CounterExample: View {
  @State private var count = 0

  var body: some View {
    VStack(spacing: 16) {
      Text("선택 횟수: \(count)")
      Button("추가") { count += 1 }
        .buttonStyle(.solid)
        .buttonTone(.brand)
        .buttonSize(.medium)
    }
    .padding()
  }
}
```

## 테마 적용

위 예제의 `VStack`에 다음 modifier를 붙이면 하위 Foundesign 컴포넌트가 같은 브랜드 색상을 사용합니다.

```swift
// CounterExample.body의 VStack에 적용합니다.
.environment(\.theme, FoundesignTheme(brand: ColorPalette.default.green))
```

테마를 따로 주입하지 않으면 기본 테마가 적용됩니다. 앱 화면의 레이아웃도 테마에 맞추려면
`@Environment(\.theme)`으로 간격·색상·타이포그래피를 읽어 사용합니다.

## 다음으로 읽을 문서

- [테마와 토큰 원문](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Sources/FoundesignFoundation/FoundesignFoundation.docc/Theming.md): 토큰 선택과 테마 교체.
- [컴포넌트 안내 원문](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Sources/FoundesignComponent/FoundesignComponent.docc/FoundesignComponent.md): 기능별 상태 바인딩과 사용 제약.
- [README의 문서 안내](https://github.com/SeishinToTokiNoHeya/Foundesign#문서-읽기): 모듈별 웹 DocC 링크.
- [실행 예제](https://github.com/SeishinToTokiNoHeya/Foundesign/tree/develop/Example): Xcode에서 열어 조작하는 전체 화면.

위 링크는 최신 개발 버전의 문서로 연결됩니다. 앱에서 다른 커밋의 패키지를 사용한다면
그 커밋에서 같은 경로의 문서를 읽으세요. DatePicker 사용 예제는 Wheel Picker 페이지에 포함되어 있습니다.
