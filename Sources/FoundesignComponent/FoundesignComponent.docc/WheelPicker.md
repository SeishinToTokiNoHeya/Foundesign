# 여러 열의 WheelPicker

목록을 스크롤해 값을 선택하는 열을 컨테이너 안에 배치합니다.

## Overview

``FoundesignWheelPickerContainer``는 열의 높이와 선택 강조 영역을 맞추고,
``FoundesignWheelPickerColumn``은 값 목록과 선택 바인딩을 연결합니다.

```swift
import Foundesign
import SwiftUI

struct QuantityExample: View {
  @State private var quantity = 3

  var body: some View {
    FoundesignWheelPickerContainer(visibleItemCount: 3) {
      FoundesignWheelPickerColumn(1...10, selection: $quantity) { value in
        Text("\(value)개")
      }
    }
    .foundesignWheelPickerSize(.small)
  }
}
```

## 입력과 선택

`visibleItemCount`는 양수여야 합니다. 열에 전달하는 값은 서로 중복되지 않아야 합니다.
스크롤 중 중앙 강조와 확정된 `selection`은 구분되며 스크롤이 멈춘 뒤 선택을 확정합니다.
목록 밖 선택값은 첫 행으로 표시하지만 사용자가 선택하기 전에는 바인딩을 바꾸지 않습니다.
빈 목록과 비활성 상태에서는 선택할 수 없습니다.

실행 예제: `Example/Example/Pages/Component/WheelPickerExamplePage.swift`.
