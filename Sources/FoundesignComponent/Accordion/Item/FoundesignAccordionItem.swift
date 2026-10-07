import FoundesignFoundation
import SwiftUI

/// 펼침 상태에 따라 제목 아래에 설명을 표시하는 항목입니다.
///
/// 제목을 누르면 `action`을 호출합니다. 항목 자체는 `isExpanded`를 변경하지 않으므로
/// 호출자가 액션에서 값을 토글하거나 다른 항목과의 펼침 정책을 적용해야 합니다.
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

  /// 선택적인 아이콘과 펼침 상태를 사용하는 항목을 만듭니다.
  /// - Parameters:
  ///   - isExpanded: 설명을 표시할지 결정하는 바인딩입니다.
  ///   - title: 항상 표시할 제목입니다.
  ///   - description: 펼쳤을 때 표시할 설명입니다.
  ///   - action: 제목을 눌렀을 때 호출하며, 필요한 펼침 상태 변경을 수행하는 액션입니다.
  ///   - icon: 제목 앞의 아이콘입니다. `nil`이면 생략합니다.
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

  /// 아이콘 없이 펼침 상태를 사용하는 항목을 만듭니다.
  /// - Parameters:
  ///   - isExpanded: 설명을 표시할지 결정하는 바인딩입니다.
  ///   - title: 항상 표시할 제목입니다.
  ///   - description: 펼쳤을 때 표시할 설명입니다.
  ///   - action: 제목을 눌렀을 때 호출하며, 필요한 펼침 상태 변경을 수행하는 액션입니다.
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
            .foregroundStyle(
              isEnabled ? theme.color.foreground.secondary : theme.color.foreground.disabled
            )
            .scaleEffect(0.8)
            .rotationEffect(isExpanded ? .radians(.pi) : .zero)
        }
      }
      .buttonStyle(FoundesignAccordionButtonStyle(size))

      if isExpanded {
        Text(description)
          .typography(size.description(theme.typography))
          .foregroundStyle(
            isEnabled ? theme.color.foreground.secondary : theme.color.foreground.disabled
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
  }

  private var borderColor: Color {
    isEnabled ? theme.color.border.base : theme.color.border.disabled
  }

  private var expansionAnimation: Animation {
    .easeInOut(duration: 0.28)
  }
}
