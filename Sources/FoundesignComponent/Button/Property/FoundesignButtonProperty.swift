import Foundation

/// 버튼 스타일에 전달하는 의미별 톤과 크기입니다.
public struct FoundesignButtonProperty: Hashable, Sendable {
  /// 버튼의 시각적 역할을 결정하는 톤입니다.
  public var tone: Tone
  /// 글꼴·여백·모서리 토큰을 선택하는 크기입니다.
  public var size: Size

  /// 지정한 톤과 크기로 버튼 속성을 만듭니다.
  /// - Parameters:
  ///   - tone: 버튼의 의미별 톤입니다.
  ///   - size: 버튼의 크기입니다.
  public init(
    tone: Tone,
    size: Size
  ) {
    self.tone = tone
    self.size = size
  }
}
