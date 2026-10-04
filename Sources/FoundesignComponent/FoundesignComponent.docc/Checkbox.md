# 단일 선택과 전체 선택 Checkbox

개별 바인딩과 여러 바인딩의 부분 선택 상태를 표현합니다.

## Overview

``FoundesignCheckbox``는 라벨을 포함한 행에서 선택을 변경합니다.
여러 바인딩을 `sources`로 전달하면 전체 선택과 부분 선택을 표현할 수 있습니다.

```swift
import Foundesign
import SwiftUI

struct CheckboxExample: View {
  @State private var terms = false
  @State private var privacy = false

  var body: some View {
    FoundesignCheckboxGroup {
      FoundesignCheckbox(title: "이용약관", isOn: $terms)
      FoundesignCheckbox(title: "개인정보 처리방침", isOn: $privacy)
    } header: {
      FoundesignCheckbox(title: "전체 동의", sources: [$terms, $privacy])
    }
    .checkboxTone(.brand)
  }
}
```

``FoundesignCheckboxGroup``은 배치와 공통 속성을 제공합니다. 그룹 자체가 선택값을 저장하지 않습니다.
개별 항목에 명시한 `property`는 환경에서 상속한 속성보다 우선합니다.
빈 `sources`는 미선택 상태로 비활성화됩니다.

실행 예제: `Example/Example/Pages/Component/CheckboxExamplePage.swift`.
