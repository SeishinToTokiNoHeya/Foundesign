import Foundation

/// 버튼 스타일이 환경에서 상속하는 의미별 톤과 크기입니다.
public struct FoundesignButtonProperty: Hashable, Sendable {
  /// 버튼의 시각적 역할을 결정하는 톤입니다.
  public var tone: Tone
  /// 글꼴·여백·모서리 토큰을 선택하는 크기입니다.
  public var size: Size

  /// 지정한 톤과 크기로 버튼 속성을 만듭니다.
  /// - Parameters:
  ///   - tone: 버튼의 의미별 톤입니다. 기본값은 `.brand`입니다.
  ///   - size: 버튼의 크기입니다. 기본값은 `.medium`입니다.
  public init(
    tone: Tone = .brand,
    size: Size = .medium
  ) {
    self.tone = tone
    self.size = size
  }
}
