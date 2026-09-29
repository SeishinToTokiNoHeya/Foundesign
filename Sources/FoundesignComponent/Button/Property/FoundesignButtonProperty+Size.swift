import Foundation

extension FoundesignButtonProperty {
  public enum Size: CaseIterable, Hashable, Sendable {
    case xsmall
    case small
    case medium
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
