import FoundesignFoundation
import SwiftUI

/// 현재 콘텐츠의 보기나 필터를 전환하는 선택 항목을 가로로 배치합니다.
///
/// 같은 선택 바인딩과 서로 다른 값을 사용하는 항목 2~4개를 권장합니다.
/// 항목 수를 제한하거나 선택값을 보정하지 않습니다. 빈 콘텐츠는 배경 여백만 남습니다.
/// 각 항목은 주어진 폭을 균등하게 사용하며, 테마와 `.disabled`를 환경에서 상속합니다.
/// 항목 높이는 가장 높은 라벨에 맞춰 통일합니다.
/// 선택값이 바뀌면 선택 배경이 새 항목으로 이동합니다.
/// 사용 흐름은 <doc:SegmentedControl>을 참고하세요.
public struct FoundesignSegmentedControl<Content: View>: View {
  @Environment(\.theme) private var theme
  @Namespace private var selectionNamespace

  private let content: Content

  /// 선택 항목을 감싸는 컨테이너를 만듭니다.
  /// - Parameter content: 같은 선택 바인딩을 공유하는 `FoundesignSegmentedControlItem`입니다.
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    HStack(spacing: theme.spacing.zero) {
      content
    }
    // 부모의 남는 높이로 늘어나지 않고 가장 높은 항목의 자연 높이를 사용합니다.
    .fixedSize(horizontal: false, vertical: true)
    .environment(\.segmentedControlSelectionNamespace, selectionNamespace)
    .padding(theme.spacing.xSmall)
    .background(
      theme.color.background.subtle,
      in: RoundedRectangle(cornerRadius: theme.radius.large)
    )
  }
}

extension EnvironmentValues {
  @Entry var segmentedControlSelectionNamespace: Namespace.ID?
}
