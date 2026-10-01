import SwiftUI

/// 환경에 설정된 시간대를 사용하는 그레고리력 연·월·일 피커입니다.
///
/// 연도나 월을 변경하면 일자를 해당 월의 마지막 날 이내로 보정합니다.
/// 사용자가 선택한 날짜는 해당 날짜의 시작 시각으로 저장합니다.
/// 외부에서 전달한 날짜가 `years` 범위를 벗어나면 지원하는 연도 범위로 보정합니다.
public struct FoundesignDatePicker: View {
  @Environment(\.timeZone) private var timeZone

  @Binding private var selection: Date
  private let years: ClosedRange<Int>

  public init(
    selection: Binding<Date>,
    years: ClosedRange<Int> = 1900...2100
  ) {
    precondition(years.lowerBound >= 1 && years.upperBound <= 9999)
    self._selection = selection
    self.years = years
  }

  public var body: some View {
    let calendar = self.calendar
    let date = FoundesignDatePickerDate.normalized(selection, calendar: calendar, years: years)
    let days = calendar.range(of: .day, in: .month, for: date) ?? 1..<2

    FoundesignWheelPickerContainer {
      FoundesignWheelPickerColumn(
        years,
        selection: $selection[foundesign: .year, calendar: calendar, years: years]
      ) {
        Text(verbatim: "\($0)년")
      }

      FoundesignWheelPickerColumn(
        1...12,
        selection: $selection[foundesign: .month, calendar: calendar, years: years]
      ) {
        Text(verbatim: "\($0)월")
      }

      FoundesignWheelPickerColumn(
        days,
        selection: $selection[foundesign: .day, calendar: calendar, years: years]
      ) {
        Text(verbatim: "\($0)일")
      }
    }
    .onChange(of: selection, initial: true) {
      normalizeSelection()
    }
    .onChange(of: years) {
      normalizeSelection()
    }
    .onChange(of: timeZone) {
      normalizeSelection()
    }
  }

  private var calendar: Calendar {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    return calendar
  }

  private func normalizeSelection() {
    let date = FoundesignDatePickerDate.normalized(selection, calendar: calendar, years: years)
    if selection != date {
      selection = date
    }
  }
}
