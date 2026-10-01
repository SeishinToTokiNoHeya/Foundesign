import Foundation

extension Date {
  subscript(
    foundesign component: Calendar.Component,
    calendar calendar: Calendar,
    years years: ClosedRange<Int>
  ) -> Int {
    get {
      calendar.component(
        component,
        from: FoundesignDatePickerDate.normalized(self, calendar: calendar, years: years)
      )
    }
    set {
      self = FoundesignDatePickerDate.setting(
        component,
        to: newValue,
        in: self,
        calendar: calendar,
        years: years
      )
    }
  }
}
