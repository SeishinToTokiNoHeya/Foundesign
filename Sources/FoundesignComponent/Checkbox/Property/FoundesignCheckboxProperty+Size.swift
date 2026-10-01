import Foundation
import FoundesignFoundation

extension FoundesignCheckboxProperty {
  public enum Size: CaseIterable, Hashable, Sendable {
    case medium
    case large
  }
}

extension FoundesignCheckboxProperty.Size: CustomStringConvertible {
  public var description: String {
    switch self {
    case .medium: "Medium"
    case .large: "Large"
    }
  }
}

extension FoundesignCheckboxProperty.Size {
  func minimumHeight(_ token: SpacingToken) -> CGFloat {
    switch self {
    case .medium: token.xxLarge
    case .large: token.xxLarge + token.xSmall
    }
  }

  func typography(_ token: TypographyToken) -> Typography {
    switch self {
    case .medium: token.body.medium
    case .large: token.body.large
    }
  }
}
