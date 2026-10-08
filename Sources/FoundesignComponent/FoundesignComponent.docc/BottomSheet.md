# 바텀 시트

화면 아래에서 추가 정보와 입력·선택 동작을 제공합니다.

## 표시 영역과 콘텐츠 구성

`bottomSheet`는 호출 뷰가 속한 window를 찾아 그 위에 표시합니다.
TabView나 NavigationStack의 자식 화면에 붙여도 탭바와 상위 콘텐츠를 덮습니다.
표시 상태를 TabView 바깥으로 옮기거나 루트에 별도 표시 영역을 설치할 필요가 없습니다.
시스템 sheet 안에서 호출하면 같은 window의 해당 화면 위에 표시합니다.

iOS는 현재 window의 최상위 화면 위에 전체 화면 모달을 표시합니다.
macOS는 해당 window의 콘텐츠 영역에 맞춘 패널을 연결하고 창 이동·크기 변경을 따라갑니다.
다른 문서 window는 가리지 않습니다. 호출 뷰가 제거되면 바인딩을 해제하고 함께 닫습니다.

```swift
import Foundesign
import SwiftUI

struct ProfilePage: View {
  @State private var isPresented = false

  var body: some View {
    Button("추가 정보") { isPresented = true }
    .bottomSheet(isPresented: $isPresented) {
      FoundesignBottomSheetContainer(
        title: "추가 정보",
        description: "내용을 확인하고 계속 진행하세요."
      ) {
        Text("현재 화면을 유지하면서 필요한 정보를 표시합니다.")
      } footer: {
        Button { isPresented = false } label: {
          Text("확인").frame(maxWidth: .infinity)
        }
        .buttonStyle(.solid)
      }
    }
    .bottomSheetShowsCloseButton(true)
  }
}
```

``FoundesignBottomSheetContainer``는 제목과 하단 영역을 고정하고 공간이 부족할 때 본문만
스크롤합니다. 본문에 별도의 ScrollView를 넣을 필요가 없습니다. Footer를 생략할 수도 있고,
두 액션이 필요하면 ``FoundesignAdaptiveButtonGroup``을 넣습니다.
일반 버튼은 액션에서 표시 바인딩을 직접 바꿔 닫습니다.

## 높이와 닫기 동작 조합

위 예제의 표시 modifier에 `snapPoints: [.fraction(0.5), .fraction(0.9)]`를 전달하면
핸들을 드래그해 두 높이 사이를 이동할 수 있습니다. 포인트 단위 높이는
``FoundesignBottomSheetSnapPoint/height(_:)``로 지정합니다.
스냅 포인트가 없으면 본문 양에 맞는 높이로 표시합니다.

실수로 닫히면 안 되는 입력 화면에서는 `isDismissible: false`와
`.bottomSheetShowsHandle(false)`를 함께 사용하고 닫기 버튼이나 footer에 명시적인 닫기 동작을
제공합니다. 스냅 포인트를 지정하면 핸들은 항상 표시되며, 닫기를 금지해도 높이 조절은 가능합니다.

외형 설정은 `bottomSheet` 뒤에 붙이면 표시 영역으로 상속됩니다.
`.bottomSheetHeaderAlignment(.center)`로 제목과 설명을 가운데 정렬할 수 있습니다.
색상·간격·모서리·글꼴은 상위 Foundesign 테마를 사용합니다.

iOS와 macOS 모두 동일한 표시 영역·바인딩·드래그 계약을 사용합니다.
실행 예제의 Bottom Sheet 페이지에서 TabView 자식 화면·시스템 시트 내부의 표시,
긴 본문, 입력, 스냅 높이와 전환 중 재표시를 확인할 수 있습니다.

## Topics

- ``FoundesignBottomSheetContainer``
- ``FoundesignBottomSheetSnapPoint``
