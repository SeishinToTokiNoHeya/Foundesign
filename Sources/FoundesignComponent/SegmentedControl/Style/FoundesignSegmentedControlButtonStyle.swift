import FoundesignFoundation
import SwiftUI

struct FoundesignSegmentedControlButtonStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.segmentedControlSelectionNamespace) private var selectionNamespace

  let isSelected: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .typography(theme.typography.label.medium)
      .fontWeight(isSelected ? .bold : .medium)
      .foregroundStyle(foregroundColor)
      .lineLimit(1)
      .truncationMode(.tail)
      .padding(.horizontal, theme.spacing.small)
      .padding(.vertical, theme.spacing.small)
      .frame(
        maxWidth: .infinity,
        maxHeight: selectionNamespace == nil ? nil : .infinity
      )
      .background {
        if isSelected {
          if let selectionNamespace {
            shape.fill(theme.color.background.elevated)
              .matchedGeometryEffect(id: "selection", in: selectionNamespace)
          } else {
            shape.fill(theme.color.background.elevated)
          }
        }
      }
      // 선택 배경의 이동만 짧게 보간하고, 외부 콘텐츠의 상태 변경에는 애니메이션을 전파하지 않습니다.
      .animation(.timingCurve(0.35, 0, 0.35, 1, duration: 0.2), value: isSelected)
      .overlay {
        if isEnabled && configuration.isPressed {
          shape.fill(theme.color.background.transparent.pressed)
        }
      }
      .contentShape(shape)
  }

  private var shape: RoundedRectangle {
    .rect(cornerRadius: theme.radius.medium)
  }

  private var foregroundColor: Color {
    guard isEnabled else {
      return theme.color.foreground.disabled
    }
    return isSelected ? theme.color.foreground.primary : theme.color.foreground.secondary
  }
}
