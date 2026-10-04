import Foundation

/// 컴포넌트의 모서리 반경을 포인트 단위로 제공하는 토큰입니다.
public struct RadiusToken: Hashable, Sendable {
  /// 모서리 반경이 필요 없는 구성에 사용하는 값입니다.
  public var zero: CGFloat
  /// 작은 모서리 반경입니다.
  public var small: CGFloat
  /// 중간 모서리 반경입니다.
  public var medium: CGFloat
  /// 큰 모서리 반경입니다.
  public var large: CGFloat
  /// 가장 큰 모서리 반경입니다.
  public var xLarge: CGFloat

  /// 각 크기에 대응하는 모서리 반경을 구성합니다.
  /// - Parameters:
  ///   - zero: 반경이 필요 없는 구성의 값입니다.
  ///   - small: 작은 반경입니다.
  ///   - medium: 중간 반경입니다.
  ///   - large: 큰 반경입니다.
  ///   - xLarge: 가장 큰 반경입니다.
  public init(
    zero: CGFloat,
    small: CGFloat,
    medium: CGFloat,
    large: CGFloat,
    xLarge: CGFloat
  ) {
    self.zero = zero
    self.small = small
    self.medium = medium
    self.large = large
    self.xLarge = xLarge
  }
}
