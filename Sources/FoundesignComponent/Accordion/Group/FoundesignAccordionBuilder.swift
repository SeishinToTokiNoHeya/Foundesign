import FoundesignFoundation
import SwiftUI

@MainActor
@resultBuilder
public enum FoundesignAccordionBuilder {
  public static func buildPartialBlock<Icon: View>(
    first: FoundesignAccordionItem<Icon>
  ) -> _FoundesignAccordionContent<FoundesignAccordionItem<Icon>> {
    .init(content: first)
  }

  public static func buildPartialBlock<Accumulated: View, Icon: View>(
    accumulated: _FoundesignAccordionContent<Accumulated>,
    next: FoundesignAccordionItem<Icon>
  ) -> _FoundesignAccordionContent<
    TupleView<(
      _FoundesignAccordionContent<Accumulated>,
      FoundesignAccordionSeparator,
      FoundesignAccordionItem<Icon>
    )>
  > {
    .init(
      content: TupleView(
        (
          accumulated,
          FoundesignAccordionSeparator(),
          next
        )
      )
    )
  }
}

public struct _FoundesignAccordionContent<Content: View>: View {
  @Environment(\.theme) private var theme
  private let content: Content

  init(content: Content) {
    self.content = content
  }

  public var body: some View {
    VStack(spacing: theme.spacing.zero) {
      content
    }
  }
}
