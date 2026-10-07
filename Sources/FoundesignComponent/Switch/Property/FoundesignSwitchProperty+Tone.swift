import Foundation

extension FoundesignSwitchProperty {
  /// 켜진 상태에 적용하는 의미별 색상 톤입니다.
  public enum Tone: CaseIterable, Hashable, Sendable {
    /// 중립 색상을 사용합니다.
    case neutral
    /// 테마의 브랜드 색상을 사용합니다.
    case brand
  }
}

extension FoundesignSwitchProperty.Tone: CustomStringConvertible {
  public var description: String {
    switch self {
    case .neutral: "Neutral"
    case .brand: "Brand"
    }
  }
}
