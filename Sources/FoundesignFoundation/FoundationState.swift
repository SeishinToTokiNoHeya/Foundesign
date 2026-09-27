import Foundation

public enum FoundationState: Hashable, Sendable {
  /// 기본 상태
  case enabled
  /// 누르고 있는 상태
  case pressed
  /// 선택되거나 Focus 된 상태
  case selected
  /// 비활성화된 상태
  case disabled
}
