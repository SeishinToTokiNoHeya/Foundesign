import FoundesignFoundation
import SwiftUI

extension View {
  /// 콘텐츠의 지정된 가장자리에 Fog 효과를 적용합니다.
  ///
  /// 콘텐츠가 위쪽 또는 아래쪽 가장자리로 갈수록 자연스럽게 흐려지는
  /// 시각적 효과를 추가합니다.
  ///
  /// `fraction`은 선택된 각 가장자리에서 Fog 효과가 차지하는 영역의 비율을 나타냅니다.
  /// 예를 들어 `fraction`이 `0.2`인 경우, 해당 가장자리부터 전체 높이의 20% 영역에
  /// Fog 효과가 적용됩니다.
  ///
  /// `.both`를 사용하는 경우 위쪽과 아래쪽 각각 20%씩 적용됩니다.
  ///
  /// ```swift
  /// ScrollView {
  ///   ContentView()
  /// }
  /// .contentFog(.bottom, fraction: 0.2)
  /// ```
  ///
  /// - Parameters:
  ///   - variant: Fog 효과를 적용할 위치입니다. 기본값은 ``ContentFogVariant/bottom``입니다.
  ///   - fraction: 선택된 각 가장자리에서 Fog 효과가 차지하는 영역의 비율입니다.
  ///     기본값은 `0.2`이며, 이는 각 가장자리 기준으로 전체 높이의 20%를 의미합니다.
  ///
  /// - Returns: 지정된 가장자리에 Fog 효과가 적용된 뷰입니다.
  public func contentFog(
    _ variant: ContentFogVariant = .bottom,
    fraction: CGFloat = 0.2
  ) -> some View {
    modifier(ContentFogModifier(variant: variant, fraction: fraction))
  }
}

public enum ContentFogVariant: CaseIterable, Hashable, Sendable {
  case top
  case bottom
  case both
}

private struct ContentFogModifier: ViewModifier {
  @Environment(\.theme) private var theme

  private let variant: ContentFogVariant
  private let fraction: CGFloat

  public init(variant: ContentFogVariant, fraction: CGFloat) {
    self.variant = variant
    self.fraction = fraction
  }

  func body(content: Content) -> some View {
    content
      .overlay {
        GeometryReader { proxy in
          VStack(spacing: theme.spacing.zero) {
            if variant != .bottom {
              ContentFog(direction: .down)
                .frame(height: proxy.size.height * fraction)
            }

            Spacer()

            if variant != .top {
              ContentFog(direction: .up)
                .frame(height: proxy.size.height * fraction)
            }
          }
        }
      }
  }
}
