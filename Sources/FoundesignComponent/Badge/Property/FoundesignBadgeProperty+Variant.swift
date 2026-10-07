import Foundation

extension FoundesignBadgeProperty {
  /// 뱃지의 시각적 강조 방식입니다.
  public enum Variant: CaseIterable, Hashable, Sendable {
    /// 약한 배경으로 표시합니다.
    case weak
    /// 채운 배경으로 강조합니다.
    case solid
    /// 배경 없이 테두리로 표시합니다.
    case outline
  }
}

extension FoundesignBadgeProperty.Variant: CustomStringConvertible {
  public var description: String {
    switch self {
    case .weak: "Weak"
    case .solid: "Solid"
    case .outline: "Outline"
    }
  }
}
