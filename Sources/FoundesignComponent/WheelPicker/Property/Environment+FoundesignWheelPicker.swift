import SwiftUI

extension EnvironmentValues {
  @Entry var wheelPickerSize: FoundesignWheelPickerSize = .medium
  @Entry var foundesignWheelPickerVisibleItemCount: Int = 5
  @Entry var foundesignWheelPickerItemHeight: CGFloat = 44
}

extension View {
  /// 하위 WheelPicker의 글꼴과 행 여백에 사용할 크기를 설정합니다.
  /// DatePicker에도 적용됩니다. 여러 열의 높이를 맞추려면 컨테이너에 설정합니다.
  /// - Parameter size: 적용할 크기입니다. 기본값은 `.medium`이며 가까운 설정이 우선합니다.
  /// - Returns: 피커 크기가 설정된 뷰입니다.
  public func wheelPickerSize(_ size: FoundesignWheelPickerSize) -> some View {
    environment(\.wheelPickerSize, size)
  }
}
