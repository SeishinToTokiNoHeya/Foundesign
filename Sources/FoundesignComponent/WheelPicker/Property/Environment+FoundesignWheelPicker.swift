import SwiftUI

extension EnvironmentValues {
  @Entry var foundesignWheelPickerSize: FoundesignWheelPickerSize = .medium
  @Entry var foundesignWheelPickerVisibleItemCount: Int = 5
  @Entry var foundesignWheelPickerItemHeight: CGFloat = 44
}

extension View {
  public func foundesignWheelPickerSize(_ size: FoundesignWheelPickerSize) -> some View {
    environment(\.foundesignWheelPickerSize, size)
  }
}
