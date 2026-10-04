# 펼침 상태를 관리하는 Accordion

호출자가 상태를 소유하는 설명 항목을 구성합니다.

## Overview

``FoundesignAccordion``은 전용 builder로 항목 사이 구분을 구성합니다.
``FoundesignAccordionItem``의 액션에서 호출자가 바인딩 값을 변경합니다.

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

실행 예제: `Example/Example/Pages/Component/AccordionExamplePage.swift`.
