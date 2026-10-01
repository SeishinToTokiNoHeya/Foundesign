import Foundation

extension FoundesignCheckboxProperty {
  public enum Tone: CaseIterable, Hashable, Sendable {
    case neutral
    case brand
  }
}

extension FoundesignCheckboxProperty.Tone: CustomStringConvertible {
  public var description: String {
    switch self {
    case .neutral: "Neutral"
    case .brand: "Brand"
    }
  }
}
