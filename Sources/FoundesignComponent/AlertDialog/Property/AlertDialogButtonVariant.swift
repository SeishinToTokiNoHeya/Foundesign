import Foundation
import FoundesignFoundation

public enum AlertDialogButtonVariant: Hashable, Sendable {
  case brand
  case critical
  case neutral
}

extension AlertDialogButtonVariant {
  var tone: FoundesignButtonProperty.Tone {
    switch self {
    case .brand: .brand
    case .critical: .critical
    case .neutral: .neutral
    }
  }
}
