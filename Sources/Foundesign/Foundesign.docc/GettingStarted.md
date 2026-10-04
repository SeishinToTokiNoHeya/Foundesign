# Foundesign 시작하기

버튼을 배치하고 테마를 주입하는 작은 화면을 만듭니다.

## Overview

앱 타깃에 `Foundesign` 패키지의 동명 라이브러리 제품을 추가합니다.
아래 예제는 외부 상태 없이 실행할 수 있으며 버튼을 누르면 횟수가 바뀝니다.

```swift
import Foundesign
import SwiftUI

struct CounterExample: View {
  @State private var count = 0

  var body: some View {
    VStack(spacing: 16) {
      Text("선택 횟수: \(count)")
      Button("추가") { count += 1 }
        .buttonStyle(.solid(tone: .brand, size: .medium))
    }
    .padding()
    .environment(\.theme, FoundesignTheme(brand: ColorPalette.default.green))
  }
}
```

테마를 따로 주입하지 않으면 기본 테마가 적용됩니다. 사용자 화면의 레이아웃도 테마에 맞추려면
`@Environment(\.theme)`으로 간격·색상·타이포그래피를 읽어 사용합니다.

## 다음으로 읽을 문서

- FoundesignFoundation의 Theming 안내: 토큰의 의미와 테마 교체.
- FoundesignComponent의 각 기능 안내: 상태 바인딩, 옵션, 사용 제약.
- 저장소의 `Example/Example.xcodeproj`: 실제 화면에서 조작할 수 있는 예제.

Example 앱의 목록은 `Example/Example/Pages/FoundationPages.swift`에서 등록합니다.
DatePicker 사용법은 Wheel Picker 페이지 안에 포함되어 있습니다.
