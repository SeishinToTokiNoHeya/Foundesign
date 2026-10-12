import FoundesignFoundation
import SwiftUI

/// WheelPicker 열의 높이와 선택 강조 영역을 맞추는 컨테이너입니다.
///
/// 내용에는 ``FoundesignWheelPickerColumn``을 배치합니다.
/// 열의 전체 너비가 화면보다 크면 가로로 스크롤할 수 있습니다. 사용 예제는 <doc:WheelPicker>를 참고하세요.
public struct FoundesignWheelPickerContainer<Content>: View where Content: View {
  @Environment(\.theme) private var theme
  @Environment(\.wheelPickerSize) private var size

  @State private var labelHeight: CGFloat = 0

  private let content: Content
  private let visibleItemCount: Int

  /// 표시할 행 수와 열 목록으로 컨테이너를 만듭니다.
  ///
  /// - Parameters:
  ///   - visibleItemCount: 한 번에 보일 행 수입니다. 기본값은 `5`입니다.
  ///   - content: 나란히 배치할 피커 열입니다.
  /// - Precondition: `visibleItemCount`는 `0`보다 커야 합니다.
  public init(
    visibleItemCount: Int = 5,
    @ViewBuilder _ content: () -> Content
  ) {
    precondition(visibleItemCount > 0)
    self.visibleItemCount = visibleItemCount
    self.content = content()
  }

  public var body: some View {
    let itemHeight = max(
      size.minimumItemHeight, labelHeight + size.verticalPadding(theme.spacing) * 2)
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
      FoundesignContentFog(direction: .down)
        .frame(height: metrics.fogHeight)
    }
    .overlay(alignment: .bottom) {
      FoundesignContentFog(direction: .up)
        .frame(height: metrics.fogHeight)
    }
    .background(theme.color.background.base)
    .clipShape(.rect(cornerRadius: theme.radius.xLarge))
  }
}
