import Foundation

extension FoundesignBadgeProperty {
  /// 뱃지의 글꼴·여백·모서리 크기 조합입니다.
  public enum Size: CaseIterable, Hashable, Sendable {
    /// 기본 크기입니다.
    case medium
    /// 더 큰 크기입니다.
    case large
  }
}

extension FoundesignBadgeProperty.Size: CustomStringConvertible {
  public var description: String {
    switch self {
    case .medium: "Medium"
    case .large: "Large"
    }
  }
}
