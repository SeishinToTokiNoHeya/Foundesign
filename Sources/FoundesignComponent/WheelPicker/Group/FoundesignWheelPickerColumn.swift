import FoundesignFoundation
import SwiftUI

/// 중복되지 않는 값 목록에서 스크롤이 멈춘 뒤 선택을 확정하는 열입니다.
///
/// `selection`에는 `values`에 포함된 값을 전달합니다.
/// 포함되지 않은 값이면 첫 행을 표시하고, 사용자가 선택하기 전까지 바인딩을 변경하지 않습니다.
/// 목록이 비어 있으면 선택할 수 없습니다. `FoundesignWheelPickerContainer` 안에서 사용합니다.
public struct FoundesignWheelPickerColumn<Value, Label>: View where Value: Hashable, Label: View {
  @Environment(\.theme) private var theme
  @Environment(\.foundesignWheelPickerSize) private var size
  @Environment(\.foundesignWheelPickerVisibleItemCount) private var visibleItemCount
  @Environment(\.foundesignWheelPickerItemHeight) private var itemHeight
  @Environment(\.isEnabled) private var isEnabled

  @Binding private var selection: Value
  @State private var centeredValue: Value?

  private let values: [Value]
  private let label: (Value) -> Label

  public init(
    _ values: some RandomAccessCollection<Value>,
    selection: Binding<Value>,
    @ViewBuilder label: @escaping (Value) -> Label
  ) {
    self.values = Array(values)
    self._selection = selection
    self.label = label
  }

  public var body: some View {
    let metrics = FoundesignWheelPickerMetrics(
      count: values.count,
      itemHeight: itemHeight,
      viewportHeight: itemHeight * CGFloat(visibleItemCount)
    )

    ZStack {
      ForEach(values, id: \.self) { value in
        label(value)
      }
    }
    .typography(size.typography(theme.typography))
    .lineLimit(1)
    .fixedSize()
    .padding(.horizontal, theme.spacing.large)
    .background {
      GeometryReader { proxy in
        Color.clear.preference(
          key: FoundesignWheelPickerLabelHeight.self,
          value: proxy.size.height
        )
      }
    }
    .hidden()
    .frame(height: metrics.viewportHeight)
    .overlay {
      FoundesignWheelPickerScroll(
        content: rows(metrics: metrics),
        values: values.map { AnyHashable($0) },
        selectionIndex: values.firstIndex(of: selection),
        metrics: metrics,
        isEnabled: isEnabled && !values.isEmpty,
        onCenter: {
          centeredValue = values[$0]
        },
        onCommit: {
          selectionCommitted(at: $0)
        }
      )
    }
    .onChange(of: selection) {
      centeredValue = nil
    }
    .onChange(of: values) {
      centeredValue = nil
    }
    .onChange(of: isEnabled) {
      centeredValue = nil
    }
  }

  private func rows(metrics: FoundesignWheelPickerMetrics) -> some View {
    VStack(spacing: theme.spacing.zero) {
      ForEach(values, id: \.self) { value in
        label(value)
          .typography(size.typography(theme.typography))
          .lineLimit(1)
          .foregroundStyle(rowForegroundStyle(value))
          .padding(.horizontal, theme.spacing.large)
          .frame(maxWidth: .infinity)
          .frame(height: metrics.itemHeight)
      }
    }
    .padding(.vertical, metrics.inset)
    .frame(maxWidth: .infinity)
  }

  private var displayedSelection: Value? {
    values.contains(selection) ? selection : values.first
  }

  private func selectionCommitted(at index: Int) {
    guard isEnabled, values.indices.contains(index) else {
      return
    }
    centeredValue = nil
    selection = values[index]
  }

  private func rowForegroundStyle(_ value: Value) -> Color {
    if isEnabled && value == (centeredValue ?? displayedSelection) {
      theme.color.foreground.primary
    } else {
      theme.color.foreground.disabled
    }
  }
}
