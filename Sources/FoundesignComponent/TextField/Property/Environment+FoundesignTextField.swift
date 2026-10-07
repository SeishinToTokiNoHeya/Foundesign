import SwiftUI

extension EnvironmentValues {
  @Entry var textFieldProperty = FoundesignTextFieldProperty()
  @Entry var textFieldIsReadOnly = false
  @Entry var textFieldShowsClearButton = false
}

extension View {
  /// 하위 텍스트 필드가 상속할 시각적 속성 전체를 설정합니다.
  /// - Parameter property: 상속할 속성입니다. 기본값은 Large·Outline·Medium 레이블입니다.
  ///   더 가까운 뷰의 설정이 우선하며, 전체 속성을 교체합니다.
  /// - Returns: 공통 속성이 설정된 뷰입니다.
  public func textFieldProperty(_ property: FoundesignTextFieldProperty) -> some View {
    environment(\.textFieldProperty, property)
  }

  /// 다른 상속 속성을 유지하면서 텍스트 필드 크기를 바꿉니다.
  /// - Parameter size: 하위 필드가 상속할 크기입니다. 기본값은 `.large`이며 더 가까운 설정이 우선합니다.
  /// - Returns: 크기가 설정된 뷰입니다.
  public func textFieldSize(_ size: FoundesignTextFieldProperty.Size) -> some View {
    transformEnvironment(\.textFieldProperty) { $0.size = size }
  }

  /// 다른 상속 속성을 유지하면서 Foundesign 텍스트 필드의 테두리를 바꿉니다.
  /// - Parameter style: 하위 필드가 상속할 스타일입니다. 기본값은 `.outline`이며 더 가까운 설정이 우선합니다.
  /// - Returns: 스타일이 설정된 뷰입니다. SwiftUI 기본 `TextField`의 스타일에는 영향을 주지 않습니다.
  public func textFieldStyle(_ style: FoundesignTextFieldProperty.Style) -> some View {
    transformEnvironment(\.textFieldProperty) { $0.style = style }
  }

  /// 다른 상속 속성을 유지하면서 텍스트 필드 레이블의 강조 수준을 바꿉니다.
  /// - Parameter weight: 하위 필드가 상속할 강조 수준입니다. 기본값은 `.medium`이며 더 가까운 설정이 우선합니다.
  /// - Returns: 레이블 강조가 설정된 뷰입니다.
  public func textFieldWeight(_ weight: FoundesignTextFieldProperty.Weight) -> some View {
    transformEnvironment(\.textFieldProperty) { $0.weight = weight }
  }

  /// 하위 텍스트 필드를 읽기 전용으로 표시합니다.
  /// - Parameter isReadOnly: 기본값은 `false`입니다. `true`이면 입력·지우기를 막고 선택 가능한 텍스트를 표시합니다.
  ///   더 가까운 설정이 우선하며, 보조 슬롯의 액션은 호출자가 별도로 제어합니다. 상위 `.disabled`는 유지됩니다.
  /// - Returns: 읽기 전용 정책이 설정된 뷰입니다.
  public func textFieldReadOnly(_ isReadOnly: Bool) -> some View {
    environment(\.textFieldIsReadOnly, isReadOnly)
  }

  /// 하위 텍스트 필드의 지우기 버튼 표시 정책을 설정합니다.
  /// - Parameter showsClearButton: 기본값은 `false`입니다. `true`이면 편집 가능하고 포커스된,
  ///   비어 있지 않은 입력에 지우기 버튼을 표시합니다. 더 가까운 설정이 우선합니다.
  /// - Returns: 지우기 정책이 설정된 뷰입니다.
  public func textFieldClearButton(_ showsClearButton: Bool) -> some View {
    environment(\.textFieldShowsClearButton, showsClearButton)
  }
}
