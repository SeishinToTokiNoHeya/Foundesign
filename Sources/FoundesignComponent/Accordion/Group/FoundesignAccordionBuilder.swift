import FoundesignFoundation
import SwiftUI

/// Accordion 항목 사이에 스타일에 맞는 구분을 삽입하는 결과 빌더입니다.
///
/// 하나 이상의 ``FoundesignAccordionItem``을 순서대로 선언하는 구성을 지원합니다.
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

/// ``FoundesignAccordionBuilder``가 반환하기 위해 공개하는 구현 보조형입니다.
///
/// 앱에서는 이 타입을 직접 구성하지 않고 ``FoundesignAccordion``을 사용합니다.
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
