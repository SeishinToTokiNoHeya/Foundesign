import FoundesignFoundation
import SwiftUI

/// Accordion 항목 사이에 스타일에 맞는 구분을 삽입하는 결과 빌더입니다.
///
/// 하나 이상의 뷰를 순서대로 선언하며, 각 표현식 사이에 구분을 삽입합니다.
/// ``FoundesignAccordionItem``에 일반 View modifier를 붙인 결과도 사용할 수 있습니다.
/// 여러 항목을 하나의 컨테이너로 묶으면 그 컨테이너를 하나의 구획으로 처리합니다.
@MainActor
@resultBuilder
public enum FoundesignAccordionBuilder {
  public static func buildPartialBlock<First: View>(
    first: First
  ) -> _FoundesignAccordionContent<First> {
    .init(content: first)
  }

  public static func buildPartialBlock<Accumulated: View, Next: View>(
    accumulated: _FoundesignAccordionContent<Accumulated>,
    next: Next
  ) -> _FoundesignAccordionContent<
    TupleView<
      (
        _FoundesignAccordionContent<Accumulated>,
        FoundesignAccordionSeparator,
        Next
      )
    >
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
