import Foundation
import FoundesignFoundation

public enum FoundesignWheelPickerSize: CaseIterable, Hashable, Sendable {
  case small
  case medium
}

extension FoundesignWheelPickerSize {
  var minimumItemHeight: CGFloat {
    switch self {
    case .small: 36
    case .medium: 44
    }
  }

  func typography(_ token: TypographyToken) -> Typography {
    switch self {
    case .small: token.label.medium
    case .medium: token.label.large
    }
  }

  func verticalPadding(_ token: SpacingToken) -> CGFloat {
    switch self {
    case .small: token.small
    case .medium: token.medium
    }
  }
}
