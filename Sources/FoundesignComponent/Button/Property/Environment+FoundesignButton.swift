import SwiftUI

extension EnvironmentValues {
  // 미지정 상태를 보존해 다이얼로그가 호출자의 설정을 덮어쓰지 않고 기본값만 제공하게 합니다.
  @Entry var buttonTone: FoundesignButtonProperty.Tone? = nil
  @Entry var buttonSize: FoundesignButtonProperty.Size? = nil

  var buttonProperty: FoundesignButtonProperty {
    get { .init(tone: buttonTone ?? .brand, size: buttonSize ?? .medium) }
    set {
      buttonTone = newValue.tone
      buttonSize = newValue.size
    }
  }
}

extension View {
  /// 하위 Foundesign 버튼 스타일이 상속할 톤과 크기 전체를 교체합니다.
  /// - Parameter property: 적용할 속성입니다. 가까운 설정이 우선하며 시스템 버튼 스타일에는 적용하지 않습니다.
  public func buttonProperty(_ property: FoundesignButtonProperty) -> some View {
    environment(\.buttonProperty, property)
  }

  /// 다른 상속 속성을 유지하면서 하위 Foundesign 버튼의 톤을 바꿉니다.
  /// - Parameter tone: 가까운 설정이 우선합니다. 미지정 시 일반 버튼은 `.brand`, 다이얼로그는 `.neutral`입니다.
  public func buttonTone(_ tone: FoundesignButtonProperty.Tone) -> some View {
    environment(\.buttonTone, tone)
  }

  /// 다른 상속 속성을 유지하면서 하위 Foundesign 버튼의 크기를 바꿉니다.
  /// - Parameter size: 가까운 설정이 우선합니다. 미지정 시 일반 버튼은 `.medium`, 다이얼로그는 `.large`입니다.
  public func buttonSize(_ size: FoundesignButtonProperty.Size) -> some View {
    environment(\.buttonSize, size)
  }
}
