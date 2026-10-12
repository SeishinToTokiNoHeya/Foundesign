import FoundesignFoundation
import SwiftUI

/// 테두리 없이 투명한 배경으로 보조 동작을 표현하는 버튼 스타일입니다.
///
/// `.buttonStyle(.ghost)`로 적용하고, 톤과 크기는 `.buttonTone`·`.buttonSize`로 설정합니다.
/// 기본 배경은 투명하며, 누르면 배경과 크기 변화로 피드백을 제공합니다.
/// 비활성 상태에서는 라벨에 비활성 색상을 적용하고 배경은 투명하게 유지합니다.
/// 톤·크기·테마·비활성 상태를 환경에서 읽으며, 가까운 설정이 우선합니다. 사용 예제는 <doc:Buttons>를 참고하세요.
public struct FoundesignGhostButtonStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled

  @Environment(\.buttonProperty) private var property

  /// 환경에서 톤과 크기를 상속하는 Ghost 스타일을 만듭니다.
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .typography(typography)
      .foregroundStyle(foregroundColor)
      .padding(.vertical, verticalPadding)
      .padding(.horizontal, horizontalPadding)
      .background(backgroundColor(isPressed: configuration.isPressed), in: shape)
      .contentShape(shape)
      // 기존 버튼 스타일과 같은 눌림 비율과 스프링으로 피드백을 맞춥니다.
      .scaleEffect(configuration.isPressed ? 0.97 : 1)
      .animation(
        .interactiveSpring(
          response: 0.22,
          dampingFraction: 0.75,
          blendDuration: 0.1
        ),
        value: configuration.isPressed
      )
  }

  private var shape: RoundedRectangle {
    .rect(cornerRadius: radius)
  }

  private var typography: Typography {
    switch property.size {
    case .xsmall: theme.typography.body.small
    case .small: theme.typography.body.medium
    case .medium: theme.typography.body.large
    case .large: theme.typography.title.small
    }
  }

  private var foregroundColor: Color {
    guard isEnabled else {
      return theme.color.foreground.disabled
    }

    switch property.tone {
    case .brand: return theme.color.foreground.brand.normal
    case .neutral: return theme.color.foreground.primary
    case .critical: return theme.color.foreground.critical.normal
    }
  }

  private func backgroundColor(isPressed: Bool) -> Color {
    let state = theme.color.background.transparent

    guard isEnabled else {
      return state.disabled
    }

    return isPressed ? state.pressed : state.normal
  }

  private var horizontalPadding: CGFloat {
    switch property.size {
    case .xsmall: theme.spacing.small
    case .small: theme.spacing.medium
    case .medium: theme.spacing.large
    case .large: theme.spacing.xLarge
    }
  }

  private var verticalPadding: CGFloat {
    switch property.size {
    case .xsmall: theme.spacing.xSmall
    case .small: theme.spacing.small
    case .medium: theme.spacing.medium
    case .large: theme.spacing.large
    }
  }

  private var radius: CGFloat {
    switch property.size {
    case .xsmall: theme.radius.medium
    case .small: theme.radius.large
    case .medium: theme.radius.xLarge
    case .large: theme.radius.xLarge
    }
  }
}
