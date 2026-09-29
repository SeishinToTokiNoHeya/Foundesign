import Foundation

public struct FoundesignAccordionProperty: Hashable, Sendable {
  public var size: Size
  public var variant: Variant

  public init(
    size: Size,
    variant: Variant
  ) {
    self.size = size
    self.variant = variant
  }
}
