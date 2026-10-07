import FoundesignFoundation
import SwiftUI

/// 트랙과 썸으로 켜짐 상태를 표시합니다. 선택 동작은 감싸는 컨트롤에서 처리합니다.
///
/// 자체 입력 동작이나 트랙 크기 밖의 추가 클릭 영역은 없습니다.
/// `.disabled(true)`에서는 썸 위치를 유지하면서 비활성 색상으로 표시합니다.
public struct FoundesignSwitchmark: View {
  @Environment(\.theme) private var theme
  @Environment(\.switchProperty) private var property
  @Environment(\.switchIsPressed) private var isPressed
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.layoutDirection) private var layoutDirection

  private let isOn: Bool

  /// 켜짐 상태를 시각적으로 표시하는 Switchmark를 만듭니다.
  /// - Parameters:
  ///   - isOn: 표시할 켜짐 상태입니다. 기본값은 `false`입니다.
  public init(isOn: Bool = false) {
    self.isOn = isOn
  }

  public var body: some View {
    Circle()
      .fill(thumbColor)
      .frame(width: thumbSize, height: thumbSize)
      // 꺼진 썸은 80% 크기로 표시해 위치와 함께 상태 차이를 드러냅니다.
      .scaleEffect(isOn ? 1 : 0.8)
      .offset(x: thumbOffset)
      .frame(width: size.width(theme.spacing), height: size.height(theme.spacing))
      // 트랙 양 끝은 테마의 크기가 바뀌어도 반원 형태를 유지합니다.
      .background(trackColor, in: Capsule())
      .scaleEffect(isEnabled && isPressed ? 0.9 : 1)
      // 상태 전환은 0.2초, 눌림은 인접 선택 컴포넌트와 같은 스프링을 사용합니다.
      .animation(.easeInOut(duration: 0.2), value: isOn)
      .animation(.easeInOut(duration: 0.15), value: isEnabled)
      .animation(.interactiveSpring(response: 0.22, dampingFraction: 0.75, blendDuration: 0.1), value: isPressed)
  }

  private var size: FoundesignSwitchProperty.Size {
    property.size
  }

  private var inset: CGFloat {
    size.inset(theme.spacing)
  }

  private var thumbSize: CGFloat {
    size.height(theme.spacing) - inset * 2
  }

  private var thumbOffset: CGFloat {
    let travel = (size.width(theme.spacing) - size.height(theme.spacing)) / 2
    let direction: CGFloat = layoutDirection == .leftToRight ? 1 : -1
    return (isOn ? travel : -travel) * direction
  }

  private var trackColor: Color {
    let colors: ColorToken.State
    if isOn {
      colors = switch property.tone {
      case .neutral: theme.color.background.neutral.solid
      case .brand: theme.color.background.brand.solid
      }
    } else {
      colors = theme.color.background.neutral.weak
    }
    guard isEnabled else { return colors.disabled }
    return isPressed ? colors.pressed : colors.normal
  }

  private var thumbColor: Color {
    guard isEnabled else { return theme.color.foreground.disabled }
    switch property.tone {
    case .neutral: return theme.color.foreground.inverse
    case .brand: return theme.color.foreground.brand.solid
    }
  }
}
