# 텍스트 필드

레이블과 입력, 도움말을 묶어 폼을 구성합니다.

## Overview

``FoundesignTextField``는 Foundesign 테마를 사용하는 SwiftUI 한 줄 텍스트 입력입니다.
화면이 입력값과 검증 시점을 소유하고, 컴포넌트에 오류 메시지를 전달합니다.

### 입력과 제출 시 검증

```swift
import Foundesign
import SwiftUI

struct NicknameForm: View {
  @State private var nickname = ""
  @State private var hasSubmitted = false
  @FocusState private var isFocused: Bool

  var body: some View {
    VStack {
      FoundesignTextField(
        title: "닉네임",
        text: $nickname,
        placeholder: "닉네임을 입력해 주세요"
      )
      .helperText("10자 이내로 입력해 주세요")
      .errorMessage(errorMessage)
      .requirement(.required)
      .maximumLength(10)
      .textFieldFocused($isFocused)
      .onSubmit { submit() }

      Button("제출") { submit() }
    }
    .textFieldClearButton(true)
  }

  private var errorMessage: String? {
    guard hasSubmitted else { return nil }
    if nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      return "닉네임을 입력해 주세요"
    }
    return nickname.count > 10 ? "닉네임을 10자 이내로 줄여 주세요" : nil
  }

  private func submit() {
    hasSubmitted = true
    isFocused = errorMessage != nil
    // 오류가 없으면 화면의 저장 동작을 수행합니다.
  }
}
```

`.textFieldFocused`로 포커스를 연결하면 외부 버튼에서 입력을 시작하거나 제출 후 오류 필드로 돌아갈 수 있습니다.
최대 글자 수는 초과 여부를 알려 주므로, 위 예제처럼 제출 조건도 화면에서 검사합니다.
입력을 자르지 않는 계약과 메시지 우선순위는 ``FoundesignTextField``의 주석을 참고하세요.

### 스타일과 보조 콘텐츠

공통 스타일은 컨테이너에 `.textFieldSize`, `.textFieldStyle`, `.textFieldWeight`로 설정합니다.
전체 속성을 한 번에 지정할 때는 ``FoundesignTextFieldProperty``를 `.textFieldProperty`에 전달합니다.
레이블 옆 보조 액션은 `headerTrailing`, 입력 앞뒤 콘텐츠는 `leading`과 `trailing`에 전달합니다.

```swift
import Foundesign
import SwiftUI

struct PriceForm: View {
  @State private var price = ""

  var body: some View {
    FoundesignTextField(
      title: "가격",
      text: $price,
      placeholder: "가격 입력"
    ) {
      Button("초기화") { price = "" }
    } leading: {
      Image(systemName: "wonsign")
    } trailing: {
      Text("원")
    }
    .textFieldStyle(.underline)
    .textFieldWeight(.bold)
  }
}
```

### 환경 상속과 개별 설정

```swift
import Foundesign
import SwiftUI

struct ProfileForm: View {
  @State private var nickname = ""
  @State private var introduction = ""

  var body: some View {
    VStack {
      FoundesignTextField(title: "닉네임", text: $nickname)
        .helperText("프로필에 표시할 이름을 입력해 주세요")
        .maximumLength(10)

      FoundesignTextField(title: "한 줄 소개", text: $introduction)
        .textFieldSize(.medium)
        .textFieldClearButton(false)
    }
    .textFieldProperty(.init(size: .large, style: .outline, weight: .bold))
    .textFieldClearButton(true)
  }
}
```

개별 크기 modifier는 상속한 스타일과 굵기를 유지합니다. 위 예제에서 한 줄 소개는 Medium 크기이며,
Outline과 Bold 레이블은 상위 설정을 따릅니다. 도움말과 글자 수 기준은 닉네임에만 적용됩니다.
도움말·오류·필수 표시·글자 수·포커스 modifier는 구체적인 필드 타입에 정의되어 있으므로
`.padding`, `.disabled`, 환경 modifier 등 일반 `View` modifier보다 먼저 적용합니다.

읽기 전용은 `.textFieldReadOnly`, 전체 비활성화는 표준 `.disabled`로 설정합니다.
읽기 전용에서는 입력 대신 선택 가능한 텍스트를 표시하며, 보조 슬롯의 액션 정책은 호출자가 정합니다.
상위 `.disabled(true)`는 보조 액션에도 적용됩니다.

전체 예제는 [TextFieldExamplePage.swift](https://github.com/SeishinToTokiNoHeya/Foundesign/blob/develop/Example/Example/Pages/Component/TextFieldExamplePage.swift)에서
스타일·입력 상태·긴 문구·커스텀 테마를 직접 조작할 수 있습니다.

## Topics

- ``FoundesignTextField``
- ``FoundesignTextFieldProperty``
- ``FoundesignTextFieldRequirement``
