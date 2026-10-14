# SegmentedControl 사용하기

현재 화면의 콘텐츠를 필터링하거나 보기 방식을 전환합니다.

## 선택값 공유하기

``FoundesignSegmentedControl`` 안의 항목에 같은 바인딩을 전달합니다.
짧은 라벨을 사용하고, 선택한 값에 따라 컨트롤 아래의 콘텐츠를 갱신합니다.
클릭하거나 외부에서 선택 바인딩을 변경하면 선택 배경이 새 항목으로 이동합니다.

```swift
import Foundesign
import SwiftUI

struct FilterExample: View {
  @State private var selection = "전체"

  var body: some View {
    VStack {
      FoundesignSegmentedControl {
        FoundesignSegmentedControlItem(title: "전체", value: "전체", selection: $selection)

        FoundesignSegmentedControlItem(title: "완료", value: "완료", selection: $selection)
      }

      Text("현재 필터: \(selection)")
    }
  }
}
```

## 라벨과 비활성 상태 조합하기

``FoundesignSegmentedControlItem``의 `label` 클로저에 텍스트와
``FoundesignBadge``를 함께 배치할 수 있습니다. 개별 항목에 `.disabled(true)`를
붙이면 해당 항목만, 컨테이너에 붙이면 모든 항목의 조작을 막습니다.

실행 예제의 Segmented Control 페이지에서 항목 수, 외부 선택값 변경, 긴 라벨,
좁은 폭, 비활성 상태와 커스텀 테마를 확인할 수 있습니다.

## Topics

- ``FoundesignSegmentedControl``
- ``FoundesignSegmentedControlItem``
