import SwiftUI

struct FoundesignWheelPickerScroll<Content> where Content: View {
  var content: Content
  var values: [AnyHashable]
  var selectionIndex: Int?
  var metrics: FoundesignWheelPickerMetrics
  var isEnabled: Bool
  var onCenter: (Int) -> Void
  var onCommit: (Int) -> Void
}
