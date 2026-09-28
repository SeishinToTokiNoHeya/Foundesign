import Foundation

public struct TypographyToken: Hashable, Sendable {
  public var body: Body
  public var display: Display
  public var Label: Label
  public var title: Title

  public init(
    body: Body,
    display: Display,
    Label: Label,
    title: Title
  ) {
    self.body = body
    self.display = display
    self.Label = Label
    self.title = title
  }
}
