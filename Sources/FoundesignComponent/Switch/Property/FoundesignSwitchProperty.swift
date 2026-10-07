import Foundation

/// 스위치의 크기와 색상 톤을 구성하는 값입니다.
public struct FoundesignSwitchProperty: Hashable, Sendable {
  /// 트랙과 라벨의 크기입니다.
  public var size: Size
  /// 켜진 트랙과 썸의 색상 톤입니다.
  public var tone: Tone

  /// 스위치의 시각적 속성을 구성합니다.
  /// - Parameters:
  ///   - size: 크기입니다. 기본값은 `.medium`입니다.
  ///   - tone: 색상 톤입니다. 기본값은 `.neutral`입니다.
  public init(size: Size = .medium, tone: Tone = .neutral) {
    self.size = size
    self.tone = tone
  }
}
