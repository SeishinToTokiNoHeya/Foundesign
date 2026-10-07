import Foundation

/// 뱃지의 크기·의미별 톤·배경 표현을 구성하는 값입니다.
public struct FoundesignBadgeProperty: Hashable, Sendable {
  /// 글꼴·여백·모서리 크기입니다.
  public var size: Size
  /// 정보의 의미를 나타내는 색상 톤입니다.
  public var tone: Tone
  /// 배경과 테두리의 표현 방식입니다.
  public var variant: Variant

  /// 뱃지의 시각적 속성을 구성합니다.
  /// - Parameters:
  ///   - size: 크기입니다. 기본값은 `.medium`입니다.
  ///   - tone: 의미별 톤입니다. 기본값은 `.neutral`입니다.
  ///   - variant: 표현 방식입니다. 기본값은 `.weak`입니다.
  public init(
    size: Size = .medium,
    tone: Tone = .neutral,
    variant: Variant = .weak
  ) {
    self.size = size
    self.tone = tone
    self.variant = variant
  }
}
