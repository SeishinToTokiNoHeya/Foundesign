import Foundation

public struct FoundesignButtonProperty: Hashable, Sendable {
  public var tone: Tone
  public var size: Size

  public init(
    tone: Tone,
    size: Size
  ) {
    self.tone = tone
    self.size = size
  }
}
