import Foundation

extension FoundesignButtonProperty {
  /// 브랜드 강조·일반 동작·위험 동작을 구분하는 버튼 톤입니다.
  public enum Tone: CaseIterable, Hashable, Sendable {
    /// 브랜드 색상으로 강조합니다.
    case brand
    /// 중립적인 색상으로 표시합니다.
    case neutral
    /// 위험하거나 파괴적인 동작을 강조합니다.
    case critical
  }
}

extension FoundesignButtonProperty.Tone: CustomStringConvertible {
  public var description: String {
    switch self {
    case .brand: "Brand"
    case .neutral: "Neutral"
    case .critical: "Critical"
    }
  }
}
