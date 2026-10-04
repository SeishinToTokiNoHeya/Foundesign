import Foundation

extension FoundesignButtonProperty {
  /// 버튼의 글꼴·여백·모서리 크기 조합입니다.
  public enum Size: CaseIterable, Hashable, Sendable {
    /// 가장 작은 버튼입니다.
    case xsmall
    /// 작은 버튼입니다.
    case small
    /// 기본 버튼 크기입니다.
    case medium
    /// 큰 버튼입니다.
    case large
  }
}

extension FoundesignButtonProperty.Size: CustomStringConvertible {
  public var description: String {
    switch self {
    case .xsmall: "XSmall"
    case .small: "Small"
    case .medium: "Medium"
    case .large: "Large"
    }
  }
}
