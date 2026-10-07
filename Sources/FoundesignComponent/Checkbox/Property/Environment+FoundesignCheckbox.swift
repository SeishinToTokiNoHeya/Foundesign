import SwiftUI

extension EnvironmentValues {
  @Entry var checkboxSize: FoundesignCheckboxProperty.Size = .medium
  // 미지정 상태를 보존해 그룹 헤더가 기본 강조만 제공하게 합니다.
  @Entry var checkboxWeight: FoundesignCheckboxProperty.Weight? = nil
  @Entry var checkboxTone: FoundesignCheckboxProperty.Tone = .neutral
  @Entry var checkboxShape: FoundesignCheckboxProperty.Shape = .outlined
  @Entry var checkboxIsPressed = false

  var checkboxProperty: FoundesignCheckboxProperty {
    get {
      .init(
        size: checkboxSize,
        weight: checkboxWeight ?? .regular,
        tone: checkboxTone,
        shape: checkboxShape
      )
    }
    set {
      checkboxSize = newValue.size
      checkboxWeight = newValue.weight
      checkboxTone = newValue.tone
      checkboxShape = newValue.shape
    }
  }
}

extension View {
  /// 하위 체크박스가 상속할 속성 전체를 설정합니다.
  /// - Parameter property: 전체 속성을 교체하며, 하위 뷰에 더 가까운 설정이 우선합니다.
  /// - Returns: 공통 속성이 설정된 뷰입니다.
  public func checkboxProperty(_ property: FoundesignCheckboxProperty) -> some View {
    environment(\.checkboxProperty, property)
  }

  /// 다른 상속 속성을 유지하면서 체크박스 크기를 바꿉니다.
  /// - Parameter size: 하위 항목이 상속할 크기입니다.
  /// - Returns: 크기가 설정된 뷰입니다.
  public func checkboxSize(_ size: FoundesignCheckboxProperty.Size) -> some View {
    environment(\.checkboxSize, size)
  }

  /// 다른 상속 속성을 유지하면서 체크박스 글꼴의 강조 수준을 바꿉니다.
  /// - Parameter weight: 하위 항목이 상속할 강조 수준입니다. 미지정 시 일반 항목은 `.regular`, 그룹 헤더는 `.bold`입니다.
  /// - Returns: 강조 수준이 설정된 뷰입니다.
  public func checkboxWeight(_ weight: FoundesignCheckboxProperty.Weight) -> some View {
    environment(\.checkboxWeight, weight)
  }

  /// 다른 상속 속성을 유지하면서 체크박스 색상 톤을 바꿉니다.
  /// - Parameter tone: 하위 항목이 상속할 톤입니다.
  /// - Returns: 톤이 설정된 뷰입니다.
  public func checkboxTone(_ tone: FoundesignCheckboxProperty.Tone) -> some View {
    environment(\.checkboxTone, tone)
  }

  /// 다른 상속 속성을 유지하면서 체크마크 표현 방식을 바꿉니다.
  /// - Parameter shape: 하위 항목이 상속할 형태입니다.
  /// - Returns: 형태가 설정된 뷰입니다.
  public func checkboxShape(_ shape: FoundesignCheckboxProperty.Shape) -> some View {
    environment(\.checkboxShape, shape)
  }
}
