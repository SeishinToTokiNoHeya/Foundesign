import SwiftUI

extension EnvironmentValues {
  @Entry var foundesignWheelPickerSize: FoundesignWheelPickerSize = .medium
  @Entry var foundesignWheelPickerVisibleItemCount: Int = 5
  @Entry var foundesignWheelPickerItemHeight: CGFloat = 44
}

extension View {
  /// 하위 WheelPicker의 글꼴과 행 여백에 사용할 크기를 설정합니다.
  /// - Parameter size: 적용할 크기입니다. 환경 기본값은 `.medium`입니다.
  /// - Returns: 피커 크기가 설정된 뷰입니다.
  public func foundesignWheelPickerSize(_ size: FoundesignWheelPickerSize) -> some View {
    environment(\.foundesignWheelPickerSize, size)
  }
}
