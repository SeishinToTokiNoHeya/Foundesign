import FoundesignFoundation
import SwiftUI

/// 다이얼로그의 닫힘 요청과 연결되는 액션 버튼입니다.
///
/// `alertDialog`로 표시한 안에서는 닫힘 요청이 수락되면 액션을 실행합니다.
/// 닫힘 전환이 진행 중일 때의 중복 요청은 실행하지 않습니다.
/// 표시 컨텍스트 밖에서는 자동 닫기 없이 액션만 실행합니다.
public struct FoundesignAlertDialogButtonItem<Style>: View where Style: ButtonStyle {
  @Environment(\.alertDialogPresentation) private var presentation
  private var isDisabled = false
  private let style: Style
  private let label: String
  private let action: () -> Void

  /// 지정한 스타일로 다이얼로그 버튼을 만듭니다.
  /// - Parameters:
  ///   - style: 적용할 버튼 스타일입니다. footer builder에서는 허용하는 구체 스타일을 사용합니다.
  ///   - label: 버튼 라벨입니다.
  ///   - action: 닫힘 요청 수락 직후 실행할 액션입니다. 전환 완료를 기다리지 않습니다.
  public init(_ style: Style, label: String, action: @escaping () -> Void) {
    self.style = style
    self.label = label
    self.action = action
  }

  /// 큰 크기의 채운 배경을 사용하는 주 동작 버튼을 만듭니다.
  /// - Parameters:
  ///   - variant: 주 동작의 색상 톤입니다.
  ///   - label: 버튼 라벨입니다.
  ///   - action: 닫힘 요청 수락 직후 실행할 액션입니다.
  public init(
    primary variant: FoundesignAlertDialogButtonVariant,
    label: String,
    action: @escaping () -> Void
  ) where Style == FoundesignSolidButtonStyle {
    self.style = FoundesignSolidButtonStyle(.init(tone: variant.tone, size: .large))
    self.label = label
    self.action = action
  }

  /// 큰 크기의 약한 배경을 사용하는 보조 동작 버튼을 만듭니다.
  /// - Parameters:
  ///   - variant: 보조 동작의 색상 톤입니다.
  ///   - label: 버튼 라벨입니다.
  ///   - action: 닫힘 요청 수락 직후 실행할 액션입니다.
  public init(
    secondary variant: FoundesignAlertDialogButtonVariant,
    label: String,
    action: @escaping () -> Void
  ) where Style == FoundesignWeakButtonStyle {
    self.style = FoundesignWeakButtonStyle(.init(tone: variant.tone, size: .large))
    self.label = label
    self.action = action
  }

  public var body: some View {
    Button(action: buttonTapped) {
      Text(label)
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
    .buttonStyle(style)
    .disabled(isDisabled)
  }

  /// 버튼의 상호작용을 비활성화합니다.
  /// - Parameter disabled: `true`이면 버튼을 누를 수 없습니다. 상위 비활성 상태도 적용됩니다.
  /// - Returns: 설정이 반영된 버튼입니다.
  public func disabled(_ disabled: Bool) -> Self {
    var item = self
    item.isDisabled = disabled
    return item
  }

  private func buttonTapped() {
    if let presentation {
      presentation.performAction(action)
    } else {
      action()
    }
  }
}
