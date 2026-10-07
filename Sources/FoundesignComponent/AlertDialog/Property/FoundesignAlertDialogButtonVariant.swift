import Foundation
import FoundesignFoundation

/// 다이얼로그 버튼의 의미별 색상 톤입니다.
public enum FoundesignAlertDialogButtonVariant: Hashable, Sendable {
  /// 브랜드 색상으로 강조합니다.
  case brand
  /// 위험하거나 파괴적인 동작을 강조합니다.
  case critical
  /// 중립적인 색상으로 표시합니다.
  case neutral
}

extension FoundesignAlertDialogButtonVariant {
  var tone: FoundesignButtonProperty.Tone {
    switch self {
    case .brand: .brand
    case .critical: .critical
    case .neutral: .neutral
    }
  }
}
