import SwiftUI

/// 모든 열에서 가장 높은 라벨을 기준으로 공통 행 높이를 정합니다.
struct FoundesignWheelPickerLabelHeight: PreferenceKey {
  static var defaultValue: CGFloat { 0 }

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = max(value, nextValue())
  }
}
