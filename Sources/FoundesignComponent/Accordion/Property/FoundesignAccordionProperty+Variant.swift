import Foundation

extension FoundesignAccordionProperty {
  public enum Variant: CaseIterable, Hashable, Sendable {
    case inline
    case separated
  }
}

extension FoundesignAccordionProperty.Variant: CustomStringConvertible {
  public var description: String {
    switch self {
    case .inline: "Inline"
    case .separated: "Separated"
    }
  }
}
