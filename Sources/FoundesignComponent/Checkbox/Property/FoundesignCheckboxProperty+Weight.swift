import SwiftUI

extension FoundesignCheckboxProperty {
  public enum Weight: CaseIterable, Hashable, Sendable {
    case regular
    case bold
  }
}

extension FoundesignCheckboxProperty.Weight: CustomStringConvertible {
  public var description: String {
    switch self {
    case .regular: "Regular"
    case .bold: "Bold"
    }
  }
}

extension FoundesignCheckboxProperty.Weight {
  var fontWeight: Font.Weight {
    switch self {
    case .regular: .regular
    case .bold: .bold
    }
  }
}
