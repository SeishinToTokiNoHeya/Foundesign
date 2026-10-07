import Foundation

extension FoundesignBadgeProperty {
  /// 뱃지가 전달하는 정보의 의미입니다.
  public enum Tone: CaseIterable, Hashable, Sendable {
    /// 일반적인 분류와 상태입니다.
    case neutral
    /// 브랜드와 관련된 정보입니다.
    case brand
    /// 정보 안내입니다.
    case informative
    /// 완료나 성공 상태입니다.
    case positive
    /// 주의가 필요한 상태입니다.
    case warning
    /// 오류나 실패 상태입니다.
    case critical
  }
}

extension FoundesignBadgeProperty.Tone: CustomStringConvertible {
  public var description: String {
    switch self {
    case .neutral: "Neutral"
    case .brand: "Brand"
    case .informative: "Informative"
    case .positive: "Positive"
    case .warning: "Warning"
    case .critical: "Critical"
    }
  }
}
