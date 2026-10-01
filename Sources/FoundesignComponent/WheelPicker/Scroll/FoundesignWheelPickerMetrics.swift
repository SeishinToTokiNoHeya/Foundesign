import Foundation

struct FoundesignWheelPickerMetrics: Equatable {
  var count: Int
  var itemHeight: CGFloat
  var viewportHeight: CGFloat

  var inset: CGFloat {
    max(0, (viewportHeight - itemHeight) / 2)
  }
  var contentHeight: CGFloat {
    max(viewportHeight, CGFloat(count) * itemHeight + inset * 2)
  }
  var fogHeight: CGFloat {
    min(viewportHeight * 0.4, itemHeight * 3, inset)
  }

  func index(at offset: CGFloat) -> Int? {
    guard count > 0 else {
      return nil
    }
    return min(count - 1, max(0, Int((offset / itemHeight).rounded())))
  }

  func offset(for index: Int) -> CGFloat {
    CGFloat(min(max(0, count - 1), max(0, index))) * itemHeight
  }
}
