import SwiftUI

/// 바텀 시트가 드래그 후 머무를 높이입니다.
public enum FoundesignBottomSheetSnapPoint: Hashable, Sendable {
  /// 표시 영역 높이에 대한 비율입니다. 유한한 양수만 사용하며 최대 90%로 제한합니다.
  case fraction(CGFloat)
  /// 하단 안전 영역을 포함한 포인트 높이입니다. 유한한 양수만 사용합니다.
  case height(CGFloat)

  func resolved(in height: CGFloat, maximum: CGFloat) -> CGFloat? {
    let value: CGFloat
    switch self {
    case .fraction(let fraction): value = height * fraction
    case .height(let points): value = points
    }
    guard value.isFinite, value > 0 else { return nil }
    return min(value, maximum)
  }
}
