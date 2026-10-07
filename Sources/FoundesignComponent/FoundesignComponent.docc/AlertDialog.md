# AlertDialog 표시와 닫기

제목·설명과 한 개 또는 두 개의 액션으로 확인 화면을 표시합니다.

## Overview

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
        FoundesignAlertDialogButtonItem(primary: .neutral, label: "확인") {
          confirmed = true
        }
        FoundesignAlertDialogButtonItem(secondary: .neutral, label: "취소") {}
      }
  }
}
```

## 버튼과 전환

``FoundesignAlertDialogFooterBuilder``는 primary 하나 또는 primary·secondary 순서의 두 버튼을 받습니다.
표시 중 ``FoundesignAlertDialogButtonItem``을 누르면 닫힘을 요청한 뒤 액션을 실행하며,
`onDismiss`는 닫힘 전환 완료 후 호출됩니다. 배경 클릭은 닫지 않고 Escape는 버튼 액션 없이 닫습니다.
컨테이너를 단독 배치하면 버튼 액션에서 필요한 표시 상태를 직접 처리해야 합니다.

실행 예제: `Example/Example/Pages/Component/AlertDialogExamplePage.swift`.
