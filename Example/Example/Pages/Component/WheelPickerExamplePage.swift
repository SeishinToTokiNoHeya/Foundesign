import Foundesign
import SwiftUI

struct WheelPickerExamplePage: View {
  @Environment(\.theme) private var theme
  @State private var date = Date.now
  @State private var quantity = 3
  @State private var isEnabled = true

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.xLarge) {
        Toggle("선택 가능", isOn: $isEnabled)
          .typography(theme.typography.label.medium)
          .foregroundStyle(theme.color.foreground.secondary)

        divider

        datePicker

        divider

        itemPicker
      }
      .padding()
    }
    .background(theme.color.background.base)
  }

  private var datePicker: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(date, format: .dateTime.year().month().day())
        .typography(theme.typography.title.small)
        .foregroundStyle(theme.color.foreground.primary)

      FoundesignDatePicker(selection: $date, years: 2000...2100)
        .disabled(!isEnabled)

      HStack(spacing: theme.spacing.medium) {
        Button("2025년 1월 31일") {
          selectDate(year: 2025, month: 1, day: 31)
        }
        .buttonStyle(.weak)
        .buttonTone(.brand)
        .buttonSize(.xsmall)

        Button("2024년 2월 29일") {
          selectDate(year: 2024, month: 2, day: 29)
        }
        .buttonStyle(.weak)
        .buttonTone(.brand)
        .buttonSize(.xsmall)
      }
    }
  }

  private var itemPicker: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text("Small Size, 노출 아이템 수 3개")
        .typography(theme.typography.label.medium)
        .foregroundStyle(theme.color.foreground.secondary)

      Text("선택: \(quantity)개")
        .typography(theme.typography.title.small)
        .foregroundStyle(theme.color.foreground.primary)

      FoundesignWheelPickerContainer(visibleItemCount: 3) {
        FoundesignWheelPickerColumn(1...10, selection: $quantity) { value in
          Text("\(value)개")
        }
      }
      .foundesignWheelPickerSize(.small)
      .disabled(!isEnabled)
    }
  }

  private var divider: some View {
    Rectangle()
      .fill(theme.color.border.base)
      .frame(height: 1)
  }

  private func selectDate(year: Int, month: Int, day: Int) {
    let calendar = Calendar(identifier: .gregorian)
    if let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) {
      self.date = date
    }
  }
}
