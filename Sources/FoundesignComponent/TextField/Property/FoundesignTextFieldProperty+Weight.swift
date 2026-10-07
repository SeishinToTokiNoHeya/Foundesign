import Foundation

extension FoundesignTextFieldProperty {
  /// 레이블의 글꼴 강조 수준입니다.
  public enum Weight: CaseIterable, Hashable, Sendable {
    /// 보통 강조로 표시합니다.
    case medium
    /// 굵게 표시합니다.
    case bold
  }
}

extension FoundesignTextFieldProperty.Weight: CustomStringConvertible {
  public var description: String {
    switch self {
    case .medium: "Medium"
    case .bold: "Bold"
    }
  }
}
