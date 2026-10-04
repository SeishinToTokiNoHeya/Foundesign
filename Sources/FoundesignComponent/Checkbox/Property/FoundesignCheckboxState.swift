import Foundation

/// 체크마크의 미선택·선택·부분 선택 표시 상태입니다.
public enum FoundesignCheckboxState: CaseIterable, Hashable, Sendable {
  /// 선택된 항목이 없습니다.
  case unselected
  /// 항목이 선택되었거나 모든 하위 항목이 선택되었습니다.
  case selected
  /// 여러 하위 항목 중 일부만 선택되었습니다.
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
