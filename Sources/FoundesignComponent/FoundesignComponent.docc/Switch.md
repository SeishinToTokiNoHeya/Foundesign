# 즉시 설정을 변경하는 Switch

바인딩으로 독립적인 설정의 켜짐 상태를 제어합니다.

## Overview

알림이나 자동 업데이트처럼 조작한 결과가 바로 반영되는 설정에 사용합니다.
``FoundesignSwitch``에 상태를 전달하고, 변경된 값을 앱의 설정에 연결합니다.

```swift
import Foundesign
import SwiftUI

struct SwitchExample: View {
  @State private var notifications = false
  @State private var automaticUpdates = true

  var body: some View {
    VStack {
      FoundesignSwitch(title: "푸시 알림", isOn: $notifications)
      FoundesignSwitch(
        title: "자동 업데이트",
        isOn: $automaticUpdates
      )
      .switchSize(.small)
    }
    .switchSize(.large)
    .switchTone(.brand)
  }
}
```

위 예제에서 알림 항목은 Large·Brand를 상속하고, 자동 업데이트 항목은 크기만 Small로 바꿉니다.
전체 속성을 교체하려면 `.switchProperty`에 ``FoundesignSwitchProperty``를 전달합니다.
비활성화할 때는 항목이나 상위 컨테이너에 `.disabled(true)`를 적용합니다.

설명이나 아이콘을 추가하려면 `label` 클로저에 뷰를 구성합니다.
다른 행의 끝에 상태 표시를 배치하려면 ``FoundesignSwitchmark``와 ``FoundesignSwitchLabel``을
조합하고, 감싸는 컨트롤에서 행 전체의 입력과 바인딩 변경을 처리합니다.

실행 예제: [전체 화면 코드](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Example/Example/Pages/Component/SwitchExamplePage.swift).
