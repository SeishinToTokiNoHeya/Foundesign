import FoundesignFoundation
import SwiftUI

public struct FoundesignAccordionSeparatedItem<Icon>: View where Icon: View {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled

  @Binding private var isExpanded: Bool
  private let property: FoundesignAccordionProperty
  private let title: String
  private let description: String
  private let action: () -> Void
  private let icon: Icon?

  public init(
    isExpanded: Binding<Bool>,
    property: FoundesignAccordionProperty,
    title: String,
    description: String,
    action: @escaping () -> Void,
    icon: (() -> Icon)?
  ) {
    self._isExpanded = isExpanded
    self.property = property
    self.title = title
    self.description = description
    self.action = action
    self.icon = icon?()
  }

  public init(
    isExpanded: Binding<Bool>,
    property: FoundesignAccordionProperty,
    title: String,
    description: String,
    action: @escaping () -> Void
  ) where Icon == EmptyView {
    self._isExpanded = isExpanded
    self.property = property
    self.title = title
    self.description = description
    self.action = action
    self.icon = nil
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.zero) {
      Button(action: action) {
        HStack(
          spacing: property.size.horizontalPadding(theme.spacing)
        ) {
          if let icon {
            icon
          }

          Text(title)

          Spacer()

          Image(systemName: "chevron.down")
            .renderingMode(.template)
            .opacity(0.5)
            .scaleEffect(0.8)
            .rotationEffect(isExpanded ? .radians(.pi) : .zero)
        }
      }
      .buttonStyle(FoundesignAccordionButtonStyle(property))
      .disabled(!isEnabled)

      if isExpanded {
        Text(description)
          .typography(property.size.description(theme.typography))
          .foregroundStyle(
            isEnabled ? theme.color.text.secondary : theme.color.text.disabled
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .padding(.vertical, property.size.descriptionVerticalPadding(theme.spacing))
          .padding(.horizontal, property.size.descriptionHorizontalPadding(theme.spacing))
          .transition(.opacity.combined(with: .move(edge: .top)))
      }
    }
    .overlay {
      shape.strokeBorder(borderColor, lineWidth: 1)
    }
    .animation(.easeInOut(duration: 0.25), value: isExpanded)
  }

  private var shape: RoundedRectangle {
    .rect(cornerRadius: property.size.radius(theme.radius))
  }

  private var borderColor: Color {
    if isEnabled {
      return theme.color.border.base
    } else {
      return theme.color.border.disabled
    }
  }
}
