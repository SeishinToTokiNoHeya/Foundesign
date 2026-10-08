# 메뉴 표시하기

버튼에 메뉴를 연결하고 화면의 남은 공간에 맞춰 선택지와 액션을 표시합니다.

## Overview

화면 전체를 채운 컨테이너에 `menuScope(selection:content:)`를 적용하고 버튼에 `menuAnchor(id:)`를 연결합니다.
선택된 앵커의 식별자로 위치를 찾고, 표시 영역이 메뉴 콘텐츠를 직접 구성합니다.
표시 영역은 List나 ScrollView 바깥에 두어 메뉴가 스크롤 콘텐츠에 잘리지 않게 합니다.
시트 안에서 메뉴를 사용한다면 시트의 루트에도 표시 영역을 연결합니다.

```swift
import Foundesign
import SwiftUI

struct SortMenu: View {
  private enum Anchor: Hashable { case sort }
  @State private var selectedMenu: Anchor?
  @State private var selection = "최신순"

  var body: some View {
    VStack {
      Button(selection) { selectedMenu = .sort }
        .menuAnchor(id: Anchor.sort)
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .menuScope(selection: $selectedMenu) { _ in
      FoundesignMenuGroup(title: "정렬") {
        ForEach(["최신순", "인기순"], id: \.self) { value in
          FoundesignMenuItem(title: value, isSelected: selection == value) {
            selection = value
          }
        }
      }
    }
  }
}
```

여러 그룹은 ``FoundesignMenuDivider``로 구분합니다. 위험 액션에는 항목의 `role: .destructive`를,
선택할 수 없는 항목에는 표준 `.disabled(true)`를 사용합니다. 액션에서 선택값을 갱신하면
다음에 열었을 때 `isSelected`가 체크 표시로 반영됩니다.

메뉴 버튼을 비활성화할 때는 `.menuAnchor(id: Anchor.sort).disabled(isDisabled)` 순서로
적용합니다. 공통 상위 컨테이너에 `.disabled(isDisabled)`를 적용해도 됩니다.
열린 메뉴에서 이 값이 `true`로 바뀌면 메뉴가 닫히고 `selectedMenu`가 `nil`로 정리됩니다.
반대 순서인 `.disabled(isDisabled).menuAnchor(id: Anchor.sort)`는 버튼만 비활성화하므로
메뉴 닫힘에 사용하지 않습니다. 앵커의 환경 상속 조건은 `menuAnchor(id:)`의 주석을 참고하세요.

## 여러 버튼과 콘텐츠 구성

하나의 표시 영역에서 여러 버튼을 사용하려면 같은 enum 타입의 서로 다른 식별자를 등록합니다.
`selection`에는 한 식별자만 들어가므로 메뉴도 하나만 표시합니다. 콘텐츠 클로저의 식별자를
`switch`나 `if`로 분기하면 서로 다른 메뉴를 구성할 수 있으며 ViewBuilder가 구체적인 뷰 타입을 유지합니다.
`FoundesignMenuItem`을 선택하거나 바깥을 클릭하면 `selection`이 `nil`로 바뀝니다.

콘텐츠는 표준 `@ViewBuilder`로 구성하므로 일반 `Button`이나 사용자 정의 뷰도 넣을 수 있습니다.
일반 `Button`에는 자동 닫힘이 적용되지 않습니다. 닫아야 하는 액션에서는 위 예제의
`selectedMenu = nil`처럼 표시 영역의 선택값을 직접 비웁니다.

## 외형과 위치 조정

컨테이너의 `.menuScope(...)` 뒤 또는 그 상위 뷰에 `.menuSize(.small)`, `.menuWidth(.trigger)`,
`.menuPlacement(.top)`, `.menuAlignment(.trailing)`을 지정합니다.
전체 설정을 전달할 때는 ``FoundesignMenuProperty``와 `.menuProperty(...)`를 사용합니다.
메뉴 콘텐츠 내부의 설정은 항목 외형에만 적용되므로 메뉴 폭이나 배치 설정은 표시 영역 쪽에 둡니다.
버튼에만 적용한 테마나 스타일은 메뉴에 전달되지 않습니다. 두 뷰에 같은 테마를 적용하려면 공통 상위 뷰에 지정합니다.

배치는 표시 영역 안에서 계산됩니다. 기본 방향에 공간이 부족하면 반대쪽으로 열고,
양쪽 모두 부족하면 넓은 쪽을 선택해 메뉴 내부를 스크롤합니다. 좌우 가장자리에서는
메뉴를 안쪽으로 이동시키고 창 크기가 바뀌면 다시 계산합니다.
시스템 팝오버가 아닌 화면 내 오버레이이므로 표시 영역 바깥의 내비게이션 바나 다른 창 위에는 표시하지 않습니다.

실행 예제의 Menu 화면에서 상단·하단 버튼, 오른쪽 경계, 긴 메뉴, 선택과 비활성 상태를 조작할 수 있습니다.

## Topics

- ``FoundesignMenuItem``
- ``FoundesignMenuGroup``
- ``FoundesignMenuDivider``
- ``FoundesignMenuProperty``
