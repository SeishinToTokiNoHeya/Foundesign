# 뱃지 사용하기

짧은 분류와 상태를 콘텐츠 옆에 표시합니다.

## Overview

``FoundesignBadge``에 문자열과 ``FoundesignBadgeProperty``를 전달합니다.
완료 상태처럼 의미가 있는 정보에는 톤을 선택하고, 필요한 경우 SF Symbol을 함께 표시합니다.

```swift
import Foundesign
import SwiftUI

struct OrderStatus: View {
  var body: some View {
    HStack {
      Text("주문 내역")
      FoundesignBadge(
        title: "배송 완료",
        systemImage: "checkmark",
        property: .init(tone: .positive)
      )
    }
  }
}
```

반복되는 목록의 보조 정보에는 `.weak`, 강한 강조에는 `.solid`, 테두리 표현에는 `.outline`을
선택합니다. 화면의 정보 밀도에 맞춰 `.medium` 또는 `.large` 크기를 사용합니다.
상호작용이 필요한 경우에는 <doc:Buttons>의 버튼을 사용합니다.

라벨은 짧게 작성하고, 제한된 영역에서는 부모의 폭을 지정해 말줄임을 적용할 수 있습니다.
환경의 테마를 바꾸면 색상·글꼴·간격·모서리에 함께 반영됩니다.

실행 가능한 예제는 저장소의 `Example/Example/Pages/Component/BadgeExamplePage.swift`에서
크기·톤·스타일·아이콘·비활성 상태와 긴 라벨을 변경하며 확인할 수 있습니다.

## Topics

### 구성

- ``FoundesignBadge``
- ``FoundesignBadgeProperty``
- ``FoundesignBadgeProperty/Size``
- ``FoundesignBadgeProperty/Tone``
- ``FoundesignBadgeProperty/Variant``
