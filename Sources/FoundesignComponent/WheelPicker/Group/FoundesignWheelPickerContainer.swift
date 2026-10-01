import FoundesignFoundation
import SwiftUI

public struct FoundesignWheelPickerContainer<Content>: View where Content: View {
  @Environment(\.theme) private var theme
  @Environment(\.foundesignWheelPickerSize) private var size

  @State private var labelHeight: CGFloat = 0

  private let content: Content
  private let visibleItemCount: Int

  /// `visibleItemCount`는 0 보다 커야 하며, 기본값은 5행입니다.
  public init(
    visibleItemCount: Int = 5,
    @ViewBuilder _ content: () -> Content
  ) {
    precondition(visibleItemCount > 0)
    self.visibleItemCount = visibleItemCount
    self.content = content()
  }

  public var body: some View {
    let itemHeight = max(size.minimumItemHeight, labelHeight + size.verticalPadding(theme.spacing) * 2)
    let height = itemHeight * CGFloat(visibleItemCount)
    let metrics = FoundesignWheelPickerMetrics(
      count: 0,
      itemHeight: itemHeight,
      viewportHeight: height
    )

    GeometryReader { proxy in
      ScrollView(.horizontal) {
        HStack(spacing: theme.spacing.zero) {
          content
        }
        .padding(.horizontal, theme.spacing.xLarge)
        .frame(minWidth: proxy.size.width)
      }
      .scrollIndicators(.hidden)
      .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
    }
    .frame(height: height)
    .environment(\.foundesignWheelPickerVisibleItemCount, visibleItemCount)
    .environment(\.foundesignWheelPickerItemHeight, itemHeight)
    .onPreferenceChange(FoundesignWheelPickerLabelHeight.self) {
      labelHeight = $0
    }
    .background {
      RoundedRectangle(cornerRadius: theme.radius.small)
        .fill(theme.color.background.neutral.weak.normal)
        .frame(height: itemHeight)
        .padding(.horizontal, theme.spacing.large)
    }
    .overlay(alignment: .top) {
      ContentFog(direction: .down)
        .frame(height: metrics.fogHeight)
    }
    .overlay(alignment: .bottom) {
      ContentFog(direction: .up)
        .frame(height: metrics.fogHeight)
    }
    .background(theme.color.background.base)
    .clipShape(.rect(cornerRadius: theme.radius.xLarge))
  }
}
