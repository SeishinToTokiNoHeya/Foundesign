# 펼침 상태를 관리하는 Accordion

항목의 펼침 상태를 앱에서 관리하는 설명 목록을 만듭니다.

## Overview

설명을 접었다 펼치는 목록에 사용합니다. 여러 항목을 동시에 펼칠지는 앱에서 결정합니다.

``FoundesignAccordion``은 전용 builder를 사용해 항목과 구분선을 배치합니다.
``FoundesignAccordionItem``의 액션에서 앱이 바인딩 값을 변경해야 합니다.

```swift
import Foundesign
import SwiftUI

struct AccordionExample: View {
  @State private var expanded = false

  var body: some View {
    FoundesignAccordion {
      FoundesignAccordionItem(
        isExpanded: $expanded,
        title: "배송 안내",
        description: "주문 후 배송 상태를 확인할 수 있습니다.",
        action: { expanded.toggle() }
      )
    }
    .accordionSize(.medium)
    .accordionStyle(.inline)
  }
}
```

여러 항목을 동시에 펼칠지 하나만 펼칠지는 호출자가 상태 모델로 결정합니다.
액션이 상태를 바꾸지 않으면 항목을 눌러도 펼침 상태는 바뀌지 않습니다.
그룹의 builder가 허용하는 구성은 ``FoundesignAccordionBuilder``에서 확인합니다.
항목에 `.accordionSize`나 `.padding` 등 일반 modifier를 붙일 수 있습니다.
상위 스타일을 상속하면서 일부 항목의 크기만 바꾸려면 그 항목에 `.accordionSize`를 적용합니다.
구분선은 그룹의 스타일을 따르므로 구분 방식은 컨테이너의 `.accordionStyle`로 지정합니다.

실행 예제: [전체 화면 코드](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Example/Example/Pages/Component/AccordionExamplePage.swift).
