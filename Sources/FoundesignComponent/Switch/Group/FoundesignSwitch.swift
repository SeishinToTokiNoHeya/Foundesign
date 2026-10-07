import SwiftUI

/// 트랙과 라벨을 조합하고, 라벨을 포함한 행 전체에서 켜짐 상태를 변경합니다.
///
/// 행을 누르면 `isOn`이 즉시 반전되며, `.disabled(true)`에서는 값을 변경하지 않습니다.
/// 외형은 환경에서 상속하며, 항목에 가까운 스타일 modifier가 우선합니다.
/// 기본 테마에서 작은 크기의 행도 최소 24pt 높이를 유지하며, 긴 라벨에 맞춰 높이가 늘어납니다.
/// 독립적인 설정을 켜고 끄는 사용 흐름은 <doc:Switch>를 참고하세요.
public struct FoundesignSwitch<Label>: View where Label: View {
  private let toggle: Toggle<Label>

  /// 켜짐 상태 바인딩과 사용자 정의 라벨로 스위치를 만듭니다.
  /// - Parameters:
  ///   - isOn: 행을 누르면 변경되는 켜짐 상태입니다. 상태는 호출자가 소유합니다.
  ///   - label: 트랙 옆에 표시할 라벨입니다. 별도 입력 컨트롤은 포함하지 않습니다.
  public init(
    isOn: Binding<Bool>,
    @ViewBuilder label: () -> Label
  ) {
    self.toggle = Toggle(isOn: isOn, label: label)
  }

  public var body: some View {
    toggle
      .toggleStyle(FoundesignSwitchToggleStyle())
  }
}

extension FoundesignSwitch where Label == FoundesignSwitchLabel {
  /// 문자열 라벨을 사용하는 스위치를 만듭니다.
  /// - Parameters:
  ///   - title: 표시할 라벨입니다. 긴 문자열은 여러 줄로 표시합니다.
  ///   - isOn: 행을 누르면 변경되는 켜짐 상태입니다.
  public init(
    title: String,
    isOn: Binding<Bool>
  ) {
    self.init(isOn: isOn) {
      FoundesignSwitchLabel(title: title)
    }
  }
}
