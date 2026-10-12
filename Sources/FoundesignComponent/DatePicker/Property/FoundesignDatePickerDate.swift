import Foundation

enum FoundesignDatePickerDate {
  static func normalized(_ date: Date, calendar: Calendar, years: ClosedRange<Int>) -> Date {
    setting(
      .year,
      to: calendar.component(.year, from: date),
      in: date,
      calendar: calendar,
      years: years
    )
  }

  static func setting(
    _ component: Calendar.Component,
    to value: Int,
    in date: Date,
    calendar: Calendar,
    years: ClosedRange<Int>
  ) -> Date {
    var parts = calendar.dateComponents([.year, .month, .day], from: date)
    parts.setValue(value, for: component)
    parts.year = min(years.upperBound, max(years.lowerBound, parts.year ?? years.lowerBound))
    parts.month = min(12, max(1, parts.month ?? 1))
    let requestedDay = parts.day ?? 1
    parts.day = 1
    parts.hour = 12
    guard
      let firstDay = calendar.date(from: parts),
      let days = calendar.range(of: .day, in: .month, for: firstDay)
    else {
      return date
    }
    parts.day = min(days.upperBound - 1, max(days.lowerBound, requestedDay))
    guard let result = calendar.date(from: parts) else {
      return date
    }
    return calendar.startOfDay(for: result)
  }
}
