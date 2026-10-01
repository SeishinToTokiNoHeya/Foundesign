import Foundation

public struct FoundesignCheckboxProperty: Hashable, Sendable {
  public var size: Size
  public var weight: Weight
  public var tone: Tone
  public var shape: Shape

  public init(
    size: Size = .medium,
    weight: Weight = .regular,
    tone: Tone = .neutral,
    shape: Shape = .outlined
  ) {
    self.size = size
    self.weight = weight
    self.tone = tone
    self.shape = shape
  }
}
