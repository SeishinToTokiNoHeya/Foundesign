# 날짜 범위를 지정하는 DatePicker

연·월·일을 선택하고 시간대에 맞는 날짜를 바인딩으로 받습니다.

## Overview

``FoundesignDatePicker``는 WheelPicker를 조합한 그레고리력 날짜 피커입니다.
연·월·일 라벨은 현재 한국어로 표시합니다.

```swift
import Foundesign
import SwiftUI

struct DateExample: View {
  @State private var date = Date.now

  var body: some View {
    VStack {
      Text(date, format: .dateTime.year().month().day())
      FoundesignDatePicker(selection: $date, years: 2000...2100)
    }
  }
}
```

## 날짜 보정

지원 연도 범위는 `1...9999` 안에 있어야 합니다. 범위 밖 선택 날짜는 지원 범위로 보정하고,
연도나 월 변경으로 존재하지 않는 일자가 되면 해당 월의 마지막 날로 보정합니다.
초기 표시와 외부 선택값·연도 범위·환경 시간대 변경 시에도 선택 바인딩을 보정할 수 있습니다.
선택값은 환경 시간대에서 해당 날짜의 시작 시각으로 저장됩니다.

현재 시각을 유지해야 하는 기능에는 날짜 선택값과 시간을 별도로 모델링하세요.
실행 예제: `Example/Example/Pages/Component/WheelPickerExamplePage.swift`의 날짜 영역.
