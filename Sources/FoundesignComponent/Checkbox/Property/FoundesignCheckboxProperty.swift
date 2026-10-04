import Foundation

/// 체크박스의 크기·강조·톤·형태를 구성하는 값입니다.
public struct FoundesignCheckboxProperty: Hashable, Sendable {
  /// 체크마크와 라벨의 크기입니다.
  public var size: Size
  /// 라벨의 글꼴 강조 수준입니다.
  public var weight: Weight
  /// 의미별 색상 톤입니다.
  public var tone: Tone
  /// 체크마크 배경과 경계의 표현 방식입니다.
  public var shape: Shape

  /// 체크박스의 시각적 속성을 구성합니다.
  /// - Parameters:
  ///   - size: 크기입니다. 기본값은 `.medium`입니다.
  ///   - weight: 글꼴 강조 수준입니다. 기본값은 `.regular`입니다.
  ///   - tone: 색상 톤입니다. 기본값은 `.neutral`입니다.
  ///   - shape: 표현 방식입니다. 기본값은 `.outlined`입니다.
  public init(
    size: Size = .medium,
    weight: Weight = .regular,
    tone: Tone = .neutral,
    shape: Shape = .outlined
  ) {
    self.size = size
    self.weight = weight
    self.tone = tone
    self.shape = shape
  }
}
