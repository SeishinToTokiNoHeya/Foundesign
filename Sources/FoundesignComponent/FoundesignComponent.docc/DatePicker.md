# 날짜 범위를 지정하는 DatePicker

연·월·일을 선택하고 시간대에 맞는 날짜를 바인딩으로 받습니다.

## Overview

그레고리력의 날짜만 선택할 때 사용합니다. 임의의 값 목록이나 여러 열을 구성하려면 <doc:WheelPicker>를 참고하세요.

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

입력 범위와 기본값은 ``FoundesignDatePicker/init(selection:years:)``에서 확인합니다.

## 날짜 보정

지원 연도 범위는 `1...9999` 안에 있어야 합니다. 범위 밖 선택 날짜는 지원 범위로 보정하고,
연도나 월 변경으로 존재하지 않는 일자가 되면 해당 월의 마지막 날로 보정합니다.
초기 표시와 외부 선택값·연도 범위·환경 시간대 변경 시에도 선택 바인딩을 보정할 수 있습니다.
선택값은 환경 시간대에서 해당 날짜의 시작 시각으로 저장됩니다.

현재 시각을 유지해야 하는 기능에는 선택한 날짜와 시간 값을 따로 관리하세요.
실행 예제: [전체 화면 코드](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Example/Example/Pages/Component/WheelPickerExamplePage.swift)의 날짜 영역.
