# 버튼 스타일과 적응형 그룹

표준 SwiftUI Button에 시각적 역할과 크기를 적용합니다.

## Overview

채운 배경은 ``FoundesignSolidButtonStyle``, 테두리는 ``FoundesignOutlineButtonStyle``,
약한 배경 강조는 ``FoundesignWeakButtonStyle``을 사용합니다.

```swift
import Foundesign
import SwiftUI

struct ButtonExample: View {
  @State private var saved = false

  var body: some View {
    Button(saved ? "저장됨" : "저장") { saved = true }
      .buttonStyle(.solid(tone: .brand, size: .medium))
      .disabled(saved)
  }
}
```

톤과 크기는 ``FoundesignButtonProperty``로 묶어서 전달할 수도 있습니다.
비활성 상태는 표준 `.disabled`로 설정합니다.

## 두 버튼을 배치하기

``FoundesignAdaptiveButtonGroup``은 두 버튼의 이상적인 너비가 주어진 폭에 들어가면 가로로,
그렇지 않으면 세로로 배치합니다. 가로는 secondary → primary, 세로는 primary → secondary 순서입니다.
라벨을 `.frame(maxWidth: .infinity)`로 구성하면 버튼의 클릭 영역을 채우기 좋습니다.

실행 예제: `Example/Example/Pages/Component/ButtonStyleExamplePage.swift`.
