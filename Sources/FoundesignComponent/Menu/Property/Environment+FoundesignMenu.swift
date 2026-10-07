import SwiftUI

extension EnvironmentValues {
  @Entry var menuProperty = FoundesignMenuProperty()
  @Entry var dismissFoundesignMenu = FoundesignMenuDismissAction()
}

// 항목에는 닫힘 동작만 전달해 선택 식별자의 타입과 분리합니다.
struct FoundesignMenuDismissAction {
  var action: () -> Void = {}

  func callAsFunction() {
    action()
  }
}

extension View {
  /// 하위 메뉴의 외형 전체를 교체합니다. 가까운 환경 설정이 우선합니다.
  public func menuProperty(_ property: FoundesignMenuProperty) -> some View {
    environment(\.menuProperty, property)
  }

  /// 다른 속성을 유지하면서 메뉴 크기를 바꿉니다. 기본값은 `.medium`입니다.
  public func menuSize(_ size: FoundesignMenuProperty.Size) -> some View {
    transformEnvironment(\.menuProperty) { $0.size = size }
  }

  /// 다른 속성을 유지하면서 너비 결정 방식을 바꿉니다. 기본값은 `.fixed`입니다.
  public func menuWidth(_ width: FoundesignMenuProperty.Width) -> some View {
    transformEnvironment(\.menuProperty) { $0.width = width }
  }

  /// 우선 표시 방향을 바꿉니다. 기본값은 `.bottom`이며 공간에 따라 반전합니다.
  public func menuPlacement(_ placement: FoundesignMenuProperty.Placement) -> some View {
    transformEnvironment(\.menuProperty) { $0.placement = placement }
  }

  /// 메뉴의 수평 정렬을 바꿉니다. 기본값은 `.leading`입니다.
  public func menuAlignment(_ alignment: FoundesignMenuProperty.Alignment) -> some View {
    transformEnvironment(\.menuProperty) { $0.alignment = alignment }
  }
}
