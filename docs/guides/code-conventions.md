# 코드 컨벤션

Swift 소스와 Markdown·DocC의 Swift 예제에 같은 규칙을 적용합니다.
자동 포맷은 루트 [`.swiftformat`](../../.swiftformat)을 기준으로 하며, 적용·검사 명령은
[검증 가이드](validation.md#코드-컨벤션-검증)를 따릅니다.

## 기본 배치

- 인접 코드의 네이밍과 구조를 따르되, 기존 공백 배치가 아래 규칙과 다르면 변경한 코드에는 아래 규칙을 적용합니다.
- 들여쓰기는 공백 2칸을 사용합니다. `switch`와 `case`는 같은 깊이에 두고 case 본문은 한 단계 들여씁니다.

## 뷰와 제어문 사이 빈 줄

- SwiftUI builder의 형제 뷰는 빈 줄 하나로 구분합니다. 뷰와 그 뷰의 modifier 체인은 붙여 씁니다.
- 앞선 코드가 있는 `if`, `if let`, `guard`, `switch`, 반복문 앞에는 논리적 구분을 위한 빈 줄 하나를 둡니다.
  블록의 첫 구문 앞에는 빈 줄을 넣지 않고, `else`는 앞선 분기와 연결합니다.

```swift
VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
  Text(title)
    .fixedSize(horizontal: false, vertical: true)

  if let description {
    Text(description)
      .typography(theme.typography.label.small)
      .foregroundStyle(
        isEnabled ? theme.color.foreground.secondary : theme.color.foreground.disabled
      )
      .fixedSize(horizontal: false, vertical: true)
  }
}
.frame(maxWidth: .infinity, alignment: .leading)
```

## switch case 배치

- 대입·함수 호출 등 작업을 수행하는 `switch` case는 콜론 다음 줄에 본문을 쓰고 case 사이에 빈 줄 하나를 둡니다.
- 짧은 값 하나를 반환하는 `switch` 표현식은 `case .leading: "Leading"`처럼 한 줄로 써도 됩니다.
  이 경우 case 사이의 빈 줄은 생략할 수 있습니다. 길거나 여러 줄이 필요한 분기는 본문을 내려 씁니다.

```swift
switch property.alignment {
case .leading:
  proposedX = isRTL ? anchor.maxX - width : anchor.minX

case .center:
  proposedX = anchor.midX - width / 2

case .trailing:
  proposedX = isRTL ? anchor.minX : anchor.maxX - width
}
```

```swift
var name: String {
  switch self {
  case .leading: "Leading"
  case .center: "Center"
  case .trailing: "Trailing"
  }
}
```

## 자동 포맷과 수동 확인

SwiftFormat은 들여쓰기·공백·줄 끝과 이미 구분한 case 간격을 정리합니다.
형제 뷰·제어문 앞의 빈 줄, case 본문 줄바꿈과 짧은 반환 표현식의 구분은 작성자가 직접 확인합니다.
포맷 검사 통과만으로 이 수동 항목까지 검증되었다고 판단하지 않습니다.
