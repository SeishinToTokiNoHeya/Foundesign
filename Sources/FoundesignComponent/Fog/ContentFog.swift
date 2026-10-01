import FoundesignFoundation
import SwiftUI

/// 컨텐츠 영역의 위/아래 경계를 자연스럽게 노출시키기 위한 Gradient입니다.
///
/// 테마의 background base 색상을 사용합니다.
///
/// Direction에는 up, down 값이 존재합니다.
/// up은 위로 가면서 점차 옅어집니다.
/// down은 아래로 가면서 점차 옅어집니다.
///
/// ```swift
/// Rectangle()
///   .fill(.pink)
///   .frame(height: 100)
///   .frame(maxWidth: .infinity)
///   .overlay(alignment: .top) {
///     ContentFog(direction: .down)
///       .frame(height: 40)
///   }
///   .overlay(alignment: .bottom) {
///     ContentFog(direction: .up)
///       .frame(height: 40)
///   }
/// ```
public struct ContentFog: View {
  public enum Direction: Hashable, Sendable {
    case up
    case down
  }

  @Environment(\.theme) private var theme

  private let direction: Direction

  public init(direction: Direction = .up) {
    self.direction = direction
  }

  public var body: some View {
    LinearGradient(
      colors: colors,
      startPoint: .top,
      endPoint: .bottom
    )
    .allowsHitTesting(false)
  }

  private var colors: [Color] {
    switch direction {
    case .up:
      return [
        theme.color.background.base.opacity(0),
        theme.color.background.base
      ]

    case .down:
      return [
        theme.color.background.base,
        theme.color.background.base.opacity(0)
      ]
    }
  }
}
