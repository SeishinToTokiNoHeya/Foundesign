import SwiftUI

/// 설명 항목을 세로로 배치하고 스타일에 맞는 구분을 삽입하는 컨테이너입니다.
///
/// 펼침 상태는 각 항목의 호출자가 관리합니다. 사용 예제는 <doc:Accordion>을 참고하세요.
public struct FoundesignAccordion<Content: View>: View {
  private let content: Content

  /// 전용 builder가 허용하는 Accordion 항목으로 컨테이너를 만듭니다.
  /// - Parameter content: 배치할 ``FoundesignAccordionItem`` 목록입니다.
  public init(
    @FoundesignAccordionBuilder content: () -> Content
  ) {
    self.content = content()
  }

  public var body: some View {
    content
  }
}
