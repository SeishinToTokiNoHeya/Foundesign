import SwiftUI

/// 하나의 값을 선택하는 SegmentedControl 버튼입니다.
///
/// 누르면 `selection`을 `value`로 변경합니다. 이미 선택된 항목을 다시 누르면 변경하지 않습니다.
/// 선택값에 대응하는 항목이 없으면 모든 항목이 선택되지 않은 상태로 표시됩니다.
/// 선택된 항목을 제거하거나 비활성화해도 바인딩은 유지합니다.
/// `.disabled`는 개별 항목과 상위 컨테이너 모두에 적용할 수 있습니다.
public struct FoundesignSegmentedControlItem<Value: Equatable, Label: View>: View {
  @Binding private var selection: Value

  private let value: Value
  private let label: Label

  /// 사용자 정의 라벨을 사용하는 선택 항목을 만듭니다.
  /// - Parameters:
  ///   - value: 이 항목이 선택되었을 때 저장할 값입니다. 그룹 안에서 고유해야 합니다.
  ///   - selection: 그룹의 모든 항목이 공유하는 선택 바인딩입니다.
  ///   - label: 텍스트, 아이콘, 뱃지 등을 조합한 라벨입니다. 별도 조작 요소는 넣지 마세요.
  public init(
    value: Value,
    selection: Binding<Value>,
    @ViewBuilder label: () -> Label
  ) {
    self.value = value
    self._selection = selection
    self.label = label()
  }

  /// 짧은 문자열을 라벨로 사용하는 선택 항목을 만듭니다.
  /// - Parameters:
  ///   - title: 한 줄로 표시하며 폭이 부족하면 끝을 말줄임하는 문자열입니다.
  ///   - value: 이 항목이 선택되었을 때 저장할 값입니다. 그룹 안에서 고유해야 합니다.
  ///   - selection: 그룹의 모든 항목이 공유하는 선택 바인딩입니다.
  public init(title: String, value: Value, selection: Binding<Value>) where Label == Text {
    self.init(value: value, selection: selection) {
      Text(title)
    }
  }

  public var body: some View {
    Button {
      guard selection != value else {
        return
      }
      selection = value
    } label: {
      label
    }
    .buttonStyle(FoundesignSegmentedControlButtonStyle(isSelected: selection == value))
  }
}
