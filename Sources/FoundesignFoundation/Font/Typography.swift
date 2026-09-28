import SwiftUI

public struct Typography: Hashable, Sendable {
  public var font: Font
  public var lineSpacing: CGFloat
  public var baselineOffset: CGFloat
  public var tracking: CGFloat

  public init(
    font: Font,
    lineSpacing: CGFloat,
    baselineOffset: CGFloat,
    tracking: CGFloat
  ) {
    self.font = font
    self.lineSpacing = lineSpacing
    self.baselineOffset = baselineOffset
    self.tracking = tracking
  }
}
