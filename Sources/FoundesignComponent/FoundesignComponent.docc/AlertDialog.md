# AlertDialog 표시와 닫기

제목·설명과 한 개 또는 두 개의 버튼으로 확인 대화상자를 표시합니다.

## Overview

작업을 계속할지 사용자에게 확인할 때 사용합니다. 현재 화면 위에 표시하려면 `alertDialog` modifier를 사용합니다.

`alertDialog` modifier가 표시 상태와 닫힘 전환을 관리합니다.
``FoundesignAlertDialogContainer``만 배치하는 경우에는 컨테이너 레이아웃만 제공됩니다.

```swift
import Foundesign
import SwiftUI

struct AlertExample: View {
  @State private var presented = false
  @State private var confirmed = false

  var body: some View {
    Button(confirmed ? "확인 완료" : "확인 요청") { presented = true }
      .alertDialog(
        isPresented: $presented,
        title: "계속할까요?",
        description: "확인하면 다음 단계로 진행합니다."
      ) {
        FoundesignAlertDialogButtonItem(label: "확인") {
          confirmed = true
        }
        FoundesignAlertDialogButtonItem(label: "취소") {}
      }
  }
}
```

## 버튼과 전환

``FoundesignAlertDialogFooterBuilder``는 primary 하나 또는 primary·secondary 순서의 두 버튼을 받습니다.
첫 번째 버튼에는 `.solid`, 두 번째에는 `.weak` 스타일을 제공하며, 톤·크기를 지정하지 않으면
Neutral·Large를 사용합니다. 각 버튼에 `.buttonTone`·`.buttonSize`·`.buttonStyle`을 적용할 수 있습니다.
컨테이너에 지정하거나 상위에서 상속한 톤·크기도 그대로 반영합니다.
표시 중 ``FoundesignAlertDialogButtonItem``을 누르면 닫힘을 요청한 뒤 액션을 실행하며,
`onDismiss`는 닫힘 전환 완료 후 호출됩니다. 배경을 클릭해도 닫히지 않으며, Escape를 누르면 버튼 액션을 실행하지 않고 닫힙니다.
컨테이너를 단독 배치하면 버튼 액션에서 필요한 표시 상태를 직접 처리해야 합니다.

실행 예제: [전체 화면 코드](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Example/Example/Pages/Component/AlertDialogExamplePage.swift).
