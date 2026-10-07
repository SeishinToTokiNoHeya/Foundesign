# 콘텐츠 가장자리의 Fog

테마의 기본 배경색으로 콘텐츠 가장자리를 덮는 그라디언트를 적용합니다.

## Overview

스크롤 콘텐츠의 위·아래 경계를 배경색으로 부드럽게 덮을 때 사용합니다. 뒤쪽 콘텐츠를 흐리게 만드는 효과와는 다릅니다.

``FoundesignContentFog``는 배경색에서 투명해지는 그라디언트이며 실제 blur 필터가 아닙니다.
`contentFog` modifier로 위·아래 가장자리에 배치할 수 있습니다.

```swift
import Foundesign
import SwiftUI

struct FogExample: View {
  var body: some View {
    ScrollView {
      VStack {
        ForEach(1...20, id: \.self) { index in
          Text("항목 \(index)")
        }
      }
      .frame(maxWidth: .infinity)
    }
    .frame(height: 200)
    .contentFog(.both, fraction: 0.2)
  }
}
```

`fraction`은 각 가장자리에서 전체 높이에 대한 비율입니다. `.both`이면 양쪽에 각각 적용합니다.
일반적으로 `0...1` 범위의 유한한 값을 전달합니다. 현재 구현은 범위를 자동으로 제한하지 않습니다.
겹치는 영역과 배경색이 의도대로 보이는지 확인합니다.

현재 별도 Example 페이지는 없으며 WheelPicker 구현 안에서 ``FoundesignContentFog``를 사용합니다.
직접 사용 예제는 향후 Fog 기능 변경 시 Example에 추가합니다.
