import Foundation

extension FoundesignCheckboxProperty {
  public enum Shape: CaseIterable, Hashable, Sendable {
    case outlined
    case ghost
  }
}

extension FoundesignCheckboxProperty.Shape: CustomStringConvertible {
  public var description: String {
    switch self {
    case .outlined: "Outlined"
    case .ghost: "Ghost"
    }
  }
}
