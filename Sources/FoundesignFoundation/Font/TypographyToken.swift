import Foundation

/// 본문·디스플레이·라벨·제목의 역할별 타이포그래피 토큰입니다.
public struct TypographyToken: Hashable, Sendable {
  /// 본문에 사용하는 글꼴입니다.
  public var body: Body
  /// 크게 강조하는 문구에 사용하는 글꼴입니다.
  public var display: Display
  /// 컨트롤 라벨에 사용하는 글꼴입니다.
  public var label: Label
  /// 제목에 사용하는 글꼴입니다.
  public var title: Title

  /// 역할별 글꼴 묶음으로 토큰을 구성합니다.
  /// - Parameters:
  ///   - body: 본문 글꼴입니다.
  ///   - display: 강조 문구 글꼴입니다.
  ///   - label: 라벨 글꼴입니다.
  ///   - title: 제목 글꼴입니다.
  public init(
    body: Body,
    display: Display,
    label: Label,
    title: Title
  ) {
    self.body = body
    self.display = display
    self.label = label
    self.title = title
  }
}
