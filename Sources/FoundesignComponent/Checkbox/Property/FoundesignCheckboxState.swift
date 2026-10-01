import Foundation

public enum FoundesignCheckboxState: CaseIterable, Hashable, Sendable {
  case unselected
  case selected
  case indeterminate
}

extension FoundesignCheckboxState: CustomStringConvertible {
  public var description: String {
    switch self {
    case .unselected: "Unselected"
    case .selected: "Selected"
    case .indeterminate: "Indeterminate"
    }
  }
}
