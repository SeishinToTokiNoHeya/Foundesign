import SwiftUI

public struct FoundesignAccordion<Content: View>: View {
  private let content: Content

  public init(
    @FoundesignAccordionBuilder content: () -> Content
  ) {
    self.content = content()
  }

  public var body: some View {
    content
  }
}
