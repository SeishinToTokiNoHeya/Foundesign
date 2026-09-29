import FoundesignFoundation
import SwiftUI

public struct FoundesignAccordionItem<Icon>: View where Icon: View {
  @Environment(\.theme) private var theme
  @Environment(\.accordionSize) private var size
  @Environment(\.accordionStyle) private var style
  @Environment(\.isEnabled) private var isEnabled

  @Binding private var isExpanded: Bool
  private let title: String
  private let description: String
  private let action: () -> Void
  private let icon: Icon?
  private var isDisabled = false

  public init(
    isExpanded: Binding<Bool>,
    title: String,
    description: String,
    action: @escaping () -> Void,
    icon: (() -> Icon)?
  ) {
    self._isExpanded = isExpanded
    self.title = title
    self.description = description
    self.action = action
    self.icon = icon?()
  }

  public init(
    isExpanded: Binding<Bool>,
    title: String,
    description: String,
    action: @escaping () -> Void
  ) where Icon == EmptyView {
    self._isExpanded = isExpanded
    self.title = title
    self.description = description
    self.action = action
    self.icon = nil
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.zero) {
      Button {
        withAnimation(expansionAnimation) {
          action()
        }
      } label: {
        HStack(
          spacing: size.horizontalPadding(theme.spacing)
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
      .buttonStyle(FoundesignAccordionButtonStyle(size))

      if isExpanded {
        Text(description)
          .typography(size.description(theme.typography))
          .foregroundStyle(
            isItemEnabled ? theme.color.text.secondary : theme.color.text.disabled
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .padding(.vertical, size.descriptionVerticalPadding(theme.spacing))
          .padding(.horizontal, size.descriptionHorizontalPadding(theme.spacing))
          .transition(.opacity)
      }
    }
    .clipped()
    .overlay {
      if style == .separated {
        RoundedRectangle(cornerRadius: size.radius(theme.radius))
          .strokeBorder(borderColor, lineWidth: 1)
      }
    }
    .animation(expansionAnimation, value: isExpanded)
    .disabled(isDisabled)
  }

  public func disabled(_ disabled: Bool) -> Self {
    var item = self
    item.isDisabled = disabled
    return item
  }

  private var isItemEnabled: Bool {
    isEnabled && !isDisabled
  }

  private var borderColor: Color {
    isItemEnabled ? theme.color.border.base : theme.color.border.disabled
  }

  private var expansionAnimation: Animation {
    .easeInOut(duration: 0.28)
  }
}
