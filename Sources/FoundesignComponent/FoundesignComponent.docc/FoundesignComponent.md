# ``FoundesignComponent``

Foundesign의 테마를 사용하는 SwiftUI 컴포넌트입니다.

## Overview

앱에서는 `import Foundesign`으로 사용할 수 있습니다.
컴포넌트는 환경의 테마와 설정을 읽으며, 선택값은 공개 API의 Binding으로 전달합니다.
타입과 initializer의 주석에서 입력 제약과 상태 변경 시점을 확인하세요.

콘텐츠·바인딩·액션은 initializer로 전달하고, 외형은 컴포넌트별 View modifier로 설정합니다.
예를 들어 `.switchSize`는 크기만, `.switchProperty`는 외형 전체를 설정합니다.
항목과 상위 컨테이너에 같은 modifier를 사용할 수 있으며, 항목에 가까운 설정이 우선합니다.
같은 뷰에서는 코드에 먼저 붙인 환경 modifier가 뷰에 더 가깝습니다.
Button은 표준 `.buttonStyle`로 표현 방식을 선택하고 `.buttonTone`·`.buttonSize`로 외형을 조정합니다.

## Topics

### 버튼

- <doc:Buttons>
- ``FoundesignSolidButtonStyle``
- ``FoundesignOutlineButtonStyle``
- ``FoundesignWeakButtonStyle``
- ``FoundesignButtonProperty``
- ``FoundesignAdaptiveButtonGroup``

### 정보 표시

- <doc:Badge>
- ``FoundesignBadge``
- ``FoundesignBadgeProperty``

### 펼침과 선택

- <doc:Menu>
- ``FoundesignMenuItem``
- ``FoundesignMenuGroup``
- ``FoundesignMenuDivider``
- ``FoundesignMenuProperty``
- <doc:Accordion>
- ``FoundesignAccordion``
- ``FoundesignAccordionItem``
- <doc:Checkbox>
- ``FoundesignCheckbox``
- ``FoundesignCheckboxGroup``
- ``FoundesignCheckboxProperty``
- ``FoundesignCheckboxState``
- <doc:Switch>
- ``FoundesignSwitch``
- ``FoundesignSwitchmark``
- ``FoundesignSwitchLabel``
- ``FoundesignSwitchProperty``

### 텍스트 입력

- <doc:TextField>
- ``FoundesignTextField``
- ``FoundesignTextFieldProperty``
- ``FoundesignTextFieldRequirement``

### 다이얼로그

- <doc:BottomSheet>
- ``FoundesignBottomSheetContainer``
- ``FoundesignBottomSheetSnapPoint``

- <doc:AlertDialog>
- ``FoundesignAlertDialogContainer``
- ``FoundesignAlertDialogButtonItem``
- ``FoundesignAlertDialogFooterBuilder``

### 피커

- <doc:WheelPicker>
- ``FoundesignWheelPickerContainer``
- ``FoundesignWheelPickerColumn``
- <doc:DatePicker>
- ``FoundesignDatePicker``

### 가장자리 효과

- <doc:Fog>
- ``FoundesignContentFog``
- ``FoundesignContentFogVariant``
