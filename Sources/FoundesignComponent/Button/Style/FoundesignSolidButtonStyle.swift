import FoundesignFoundation
import SwiftUI

public struct FoundesignSolidButtonStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled

  private let property: FoundesignButtonProperty

  public init(_ property: FoundesignButtonProperty) {
    self.property = property
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .typography(typography)
      .foregroundStyle(foregroundColor(isPressed: configuration.isPressed))
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
    case .xsmall: theme.typography.label.small
    case .small: theme.typography.body.small
    case .medium: theme.typography.body.medium
    case .large: theme.typography.body.large
    }
  }

  private func foregroundColor(isPressed: Bool) -> Color {
    guard isEnabled else {
      return theme.color.text.disabled
    }
    switch property.tone {
    case .brand:
      return theme.color.text.inverse

    case .neutral:
      return theme.color.text.inverse

    case .critical:
      return theme.color.text.inverse
    }
  }

  private func backgroundColor(isPressed: Bool) -> Color {
    return theme.color.backgroundColor(
      property,
      isEnabled: isEnabled,
      isPressed: isPressed
    )
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
    case .large: theme.spacing.medium
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

fileprivate extension ColorToken {
  func backgroundColor(
    _ property: FoundesignButtonProperty,
    isEnabled: Bool,
    isPressed: Bool
  ) -> Color {
    if !isEnabled {
      switch property.tone {
      case .brand: return action.primary.disabled
      case .neutral: return action.neutral.disabled
      case .critical: return action.destructive.disabled
      }
    }

    if isPressed {
      switch property.tone {
      case .brand: return action.primary.pressed
      case .neutral: return action.neutral.pressed
      case .critical: return action.destructive.pressed
      }
    }

    switch property.tone {
    case .brand: return action.primary.normal
    case .neutral: return action.neutral.normal
    case .critical: return action.destructive.normal
    }
  }
}
