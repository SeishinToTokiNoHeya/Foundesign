import SwiftUI

extension EnvironmentValues {
  @Entry var checkboxProperty = FoundesignCheckboxProperty()
  @Entry var checkboxIsPressed = false
}

extension View {
  /// 하위 체크박스가 상속할 속성 전체를 설정합니다.
  /// - Parameter property: 상속할 속성입니다. 항목에 명시한 속성이 있으면 그 값이 우선합니다.
  /// - Returns: 공통 속성이 설정된 뷰입니다.
  public func checkboxProperty(_ property: FoundesignCheckboxProperty) -> some View {
    environment(\.checkboxProperty, property)
  }

  /// 다른 상속 속성을 유지하면서 체크박스 크기를 바꿉니다.
  /// - Parameter size: 하위 항목이 상속할 크기입니다.
  /// - Returns: 크기가 설정된 뷰입니다.
  public func checkboxSize(_ size: FoundesignCheckboxProperty.Size) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.size = size }
  }

  /// 다른 상속 속성을 유지하면서 체크박스 글꼴의 강조 수준을 바꿉니다.
  /// - Parameter weight: 하위 항목이 상속할 강조 수준입니다.
  /// - Returns: 강조 수준이 설정된 뷰입니다.
  public func checkboxWeight(_ weight: FoundesignCheckboxProperty.Weight) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.weight = weight }
  }

  /// 다른 상속 속성을 유지하면서 체크박스 색상 톤을 바꿉니다.
  /// - Parameter tone: 하위 항목이 상속할 톤입니다.
  /// - Returns: 톤이 설정된 뷰입니다.
  public func checkboxTone(_ tone: FoundesignCheckboxProperty.Tone) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.tone = tone }
  }

  /// 다른 상속 속성을 유지하면서 체크마크 표현 방식을 바꿉니다.
  /// - Parameter shape: 하위 항목이 상속할 형태입니다.
  /// - Returns: 형태가 설정된 뷰입니다.
  public func checkboxShape(_ shape: FoundesignCheckboxProperty.Shape) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.shape = shape }
  }
}
