import Foundation
import FoundesignFoundation

extension FoundesignAccordionProperty {
  public enum Size: CaseIterable, Hashable, Sendable {
    case medium
    case large
  }
}

extension FoundesignAccordionProperty.Size: CustomStringConvertible {
  public var description: String {
    switch self {
    case .medium: "Medium"
    case .large: "Large"
    }
  }
}

extension FoundesignAccordionProperty.Size {
  func description(_ token: TypographyToken) -> Typography {
    switch self {
    case .medium: token.body.small
    case .large: token.body.medium
    }
  }

  func horizontalPadding(_ token: SpacingToken) -> CGFloat {
    switch self {
    case .medium: token.medium
    case .large: token.medium
    }
  }

  func descriptionVerticalPadding(_ token: SpacingToken) -> CGFloat {
    switch self {
    case .medium: token.medium
    case .large: token.medium
    }
  }

  func descriptionHorizontalPadding(_ token: SpacingToken) -> CGFloat {
    switch self {
    case .medium: token.medium
    case .large: token.medium
    }
  }

  func radius(_ token: RadiusToken) -> CGFloat {
    switch self {
    case .medium: token.medium
    case .large: token.medium
    }
  }
}
