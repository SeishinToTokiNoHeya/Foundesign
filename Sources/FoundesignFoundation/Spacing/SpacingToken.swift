import Foundation

/// 컴포넌트 배치와 여백에 사용하는 포인트 단위의 간격 토큰입니다.
public struct SpacingToken: Hashable, Sendable {
  /// 간격이 필요 없는 구성에 사용하는 값입니다.
  public var zero: CGFloat
  /// 가장 작은 간격입니다.
  public var xSmall: CGFloat
  /// 작은 간격입니다.
  public var small: CGFloat
  /// 중간 간격입니다.
  public var medium: CGFloat
  /// 큰 간격입니다.
  public var large: CGFloat
  /// 더 큰 간격입니다.
  public var xLarge: CGFloat
  /// 가장 큰 간격입니다.
  public var xxLarge: CGFloat

  /// 각 크기에 대응하는 간격을 구성합니다.
  /// - Parameters:
  ///   - zero: 간격이 필요 없는 구성의 값입니다.
  ///   - xSmall: 가장 작은 간격입니다.
  ///   - small: 작은 간격입니다.
  ///   - medium: 중간 간격입니다.
  ///   - large: 큰 간격입니다.
  ///   - xLarge: 더 큰 간격입니다.
  ///   - xxLarge: 가장 큰 간격입니다.
  public init(
    zero: CGFloat,
    xSmall: CGFloat,
    small: CGFloat,
    medium: CGFloat,
    large: CGFloat,
    xLarge: CGFloat,
    xxLarge: CGFloat
  ) {
    self.zero = zero
    self.xSmall = xSmall
    self.small = small
    self.medium = medium
    self.large = large
    self.xLarge = xLarge
    self.xxLarge = xxLarge
  }
}
