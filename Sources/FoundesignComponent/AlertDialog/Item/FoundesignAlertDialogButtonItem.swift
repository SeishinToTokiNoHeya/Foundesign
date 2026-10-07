import SwiftUI

/// 다이얼로그의 닫힘 요청과 연결되는 액션 버튼입니다.
///
/// `alertDialog` 안에서는 닫힘 요청이 수락되면 액션을 실행합니다.
/// 닫힘 전환 중 중복 요청은 실행하지 않으며, 표시 컨텍스트 밖에서는 액션만 실행합니다.
/// 외형은 `.buttonStyle`·`.buttonTone`·`.buttonSize`로 설정하고 `.disabled`를 그대로 사용합니다.
/// Footer의 첫 번째 버튼은 기본적으로 `.solid`, 두 번째는 `.weak`를 상속합니다.
public struct FoundesignAlertDialogButtonItem: View {
  @Environment(\.alertDialogPresentation) private var presentation

  private let label: String
  private let action: () -> Void

  /// 문자열 라벨과 액션으로 다이얼로그 버튼을 만듭니다.
  /// - Parameters:
  ///   - label: 버튼 라벨입니다.
  ///   - action: 닫힘 요청 수락 직후 실행할 액션입니다. 전환 완료를 기다리지 않습니다.
  public init(label: String, action: @escaping () -> Void) {
    self.label = label
    self.action = action
  }

  public var body: some View {
    Button(action: buttonTapped) {
      Text(label)
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
  }

  private func buttonTapped() {
    if let presentation {
      presentation.performAction(action)
    } else {
      action()
    }
  }
}
