import Foundation

extension FoundesignButtonProperty {
  public enum Tone: CaseIterable, Hashable, Sendable {
    case brand
    case neutral
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
