import SwiftUI

extension EnvironmentValues {
  @Entry var switchProperty = FoundesignSwitchProperty()
  @Entry var switchIsPressed = false
}

extension View {
  /// 하위 스위치, Switchmark와 라벨이 상속할 속성 전체를 설정합니다.
  /// - Parameter property: 전체 속성을 교체하며, 하위 뷰에 더 가까운 설정이 우선합니다.
  public func switchProperty(_ property: FoundesignSwitchProperty) -> some View {
    environment(\.switchProperty, property)
  }

  /// 다른 상속 속성을 유지하면서 하위 스위치의 크기를 바꿉니다.
  /// - Parameter size: 하위 항목이 상속할 크기입니다.
  public func switchSize(_ size: FoundesignSwitchProperty.Size) -> some View {
    transformEnvironment(\.switchProperty) { $0.size = size }
  }

  /// 다른 상속 속성을 유지하면서 하위 스위치의 색상 톤을 바꿉니다.
  /// - Parameter tone: 하위 항목이 상속할 톤입니다.
  public func switchTone(_ tone: FoundesignSwitchProperty.Tone) -> some View {
    transformEnvironment(\.switchProperty) { $0.tone = tone }
  }
}
