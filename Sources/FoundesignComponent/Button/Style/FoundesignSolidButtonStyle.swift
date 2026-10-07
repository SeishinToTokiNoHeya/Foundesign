import FoundesignFoundation
import SwiftUI

/// 의미별 톤의 채운 배경으로 버튼을 강조하는 스타일입니다.
///
/// `.buttonStyle(.solid)`로 적용하고, 톤과 크기는 `.buttonTone`·`.buttonSize`로 설정합니다.
/// 톤·크기·테마·비활성 상태를 환경에서 읽으며, 가까운 설정이 우선합니다. 사용 예제는 <doc:Buttons>를 참고하세요.
public struct FoundesignSolidButtonStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled

  @Environment(\.buttonProperty) private var property

  /// 환경에서 톤과 크기를 상속하는 채운 배경 스타일을 만듭니다.
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .typography(typography)
      .foregroundStyle(foregroundColor)
      .padding(.vertical, verticalPadding)
      .padding(.horizontal, horizontalPadding)
      .background(backgroundColor(isPressed: configuration.isPressed), in: shape)
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
    case .brand: return theme.color.foreground.brand.solid
    case .neutral: return theme.color.foreground.inverse
    case .critical: return theme.color.foreground.critical.solid
    }
  }

  private func backgroundColor(isPressed: Bool) -> Color {
    let state: ColorToken.State = switch property.tone {
    case .brand: theme.color.background.brand.solid
    case .neutral: theme.color.background.neutral.solid
    case .critical: theme.color.background.critical.solid
    }
    guard isEnabled else { return state.disabled }
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
