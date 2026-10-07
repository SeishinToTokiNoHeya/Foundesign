import Foundation

/// 텍스트 필드의 크기·테두리·레이블 강조를 구성하는 값입니다.
public struct FoundesignTextFieldProperty: Hashable, Sendable {
  /// 입력 영역의 글꼴과 여백 크기입니다.
  public var size: Size
  /// 입력 영역의 테두리 표현 방식입니다.
  public var style: Style
  /// 레이블의 글꼴 강조 수준입니다.
  public var weight: Weight

  /// 텍스트 필드의 시각적 속성을 구성합니다.
  /// - Parameters:
  ///   - size: 기본값은 `.large`입니다.
  ///   - style: 기본값은 `.outline`입니다.
  ///   - weight: 레이블에만 적용하며 기본값은 `.medium`입니다.
  public init(size: Size = .large, style: Style = .outline, weight: Weight = .medium) {
    self.size = size
    self.style = style
    self.weight = weight
  }
}
