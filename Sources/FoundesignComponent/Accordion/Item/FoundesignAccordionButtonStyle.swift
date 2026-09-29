import FoundesignFoundation
import SwiftUI

struct FoundesignAccordionButtonStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled

  private let property: FoundesignAccordionProperty

  init(_ property: FoundesignAccordionProperty) {
    self.property = property
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .typography(typography)
      .foregroundStyle(foregroundColor)
      .padding(.vertical, verticalPadding)
      .padding(.horizontal, horizontalPadding)
      .background(backgroundColor(isPressed: configuration.isPressed), in: shape)
      .contentShape(shape)
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
    .rect(cornerRadius: property.size.radius(theme.radius))
  }

  private var typography: Typography {
    switch property.size {
    case .medium: theme.typography.body.medium
    case .large: theme.typography.body.large
    }
  }

  private var foregroundColor: Color {
    guard isEnabled else {
      return theme.color.text.disabled
    }
    return theme.color.text.primary
  }

  private var verticalPadding: CGFloat {
    switch property.size {
    case .medium: theme.spacing.medium
    case .large: theme.spacing.medium
    }
  }

  private var horizontalPadding: CGFloat {
    switch property.size {
    case .medium: theme.spacing.medium
    case .large: theme.spacing.medium
    }
  }

  private func backgroundColor(isPressed: Bool) -> Color {
    if isPressed {
      return theme.color.action.neutral.pressed.opacity(0.08)
    } else {
      return .clear
    }
  }
}
