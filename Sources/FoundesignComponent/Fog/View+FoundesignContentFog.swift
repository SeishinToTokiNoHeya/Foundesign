import FoundesignFoundation
import SwiftUI

extension View {
  /// 콘텐츠의 지정된 가장자리에 Fog 효과를 적용합니다.
  ///
  /// 테마의 기본 배경색 그라디언트로 가장자리를 덮습니다. 실제 blur 필터는 적용하지 않습니다.
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
  ///   - variant: Fog 효과를 적용할 위치입니다. 기본값은 ``FoundesignContentFogVariant/bottom``입니다.
  ///   - fraction: 선택된 각 가장자리에서 Fog 효과가 차지하는 영역의 비율입니다.
  ///     기본값은 `0.2`이며, 이는 각 가장자리 기준으로 전체 높이의 20%를 의미합니다.
  ///     일반적으로 `0...1` 범위의 유한한 값을 전달하며 구현은 범위를 자동 제한하지 않습니다.
  ///
  /// - Returns: 지정된 가장자리에 Fog 효과가 적용된 뷰입니다.
  public func contentFog(
    _ variant: FoundesignContentFogVariant = .bottom,
    fraction: CGFloat = 0.2
  ) -> some View {
    modifier(FoundesignContentFogModifier(variant: variant, fraction: fraction))
  }
}

/// 콘텐츠에 Fog를 배치할 가장자리입니다.
public enum FoundesignContentFogVariant: CaseIterable, Hashable, Sendable {
  /// 위쪽 가장자리에 적용합니다.
  case top
  /// 아래쪽 가장자리에 적용합니다.
  case bottom
  /// 위·아래 가장자리에 각각 적용합니다.
  case both
}

private struct FoundesignContentFogModifier: ViewModifier {
  @Environment(\.theme) private var theme

  private let variant: FoundesignContentFogVariant
  private let fraction: CGFloat

  public init(variant: FoundesignContentFogVariant, fraction: CGFloat) {
    self.variant = variant
    self.fraction = fraction
  }

  func body(content: Content) -> some View {
    content
      .overlay {
        GeometryReader { proxy in
          VStack(spacing: theme.spacing.zero) {
            if variant != .bottom {
              FoundesignContentFog(direction: .down)
                .frame(height: proxy.size.height * fraction)
            }

            Spacer()

            if variant != .top {
              FoundesignContentFog(direction: .up)
                .frame(height: proxy.size.height * fraction)
            }
          }
        }
      }
  }
}
