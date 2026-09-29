import Foundesign
import SwiftUI

struct AccordionExamplePage: View {
  @State private var inlineFirstExpanded = true
  @State private var inlineSecondExpanded = false
  @State private var separatedFirstExpanded = false
  @State private var separatedSecondExpanded = true

  var body: some View {
    List {
      Section("Inline Multiple") {
        FoundesignAccordion {
          FoundesignAccordionItem(
            isExpanded: $inlineFirstExpanded,
            title: "첫 번째 항목",
            description: "내용을 펼치거나 접을 수 있습니다.",
            action: { inlineFirstExpanded.toggle() }
          )

          FoundesignAccordionItem(
            isExpanded: $inlineSecondExpanded,
            title: "비활성 항목",
            description: "이 항목은 열 수 없습니다.",
            action: { inlineSecondExpanded.toggle() }
          )
          .disabled(true)
        }
        .accordionStyle(.inline)
      }

      Section("Inline Single Large") {
        FoundesignAccordion {
          FoundesignAccordionItem(
            isExpanded: $inlineFirstExpanded,
            title: "첫 번째 항목",
            description: "내용을 펼치거나 접을 수 있습니다.",
            action: { inlineFirstExpanded.toggle() }
          )
        }
        .accordionSize(.large)
        .accordionStyle(.inline)
      }

      Section("Separated Multiple") {
        FoundesignAccordion {
          FoundesignAccordionItem(
            isExpanded: .constant(true),
            title: "첫 번째 항목",
            description: "이 항목은 변경 할 수 없습니다.",
            action: { }
          )
          .disabled(true)

          FoundesignAccordionItem(
            isExpanded: $separatedSecondExpanded,
            title: "두 번째 항목",
            description: "각 항목에 테두리가 표시됩니다.",
            action: { separatedSecondExpanded.toggle() }
          )
        }
        .accordionStyle(.separated)
      }

      Section("Separated Single Large") {
        FoundesignAccordion {
          FoundesignAccordionItem(
            isExpanded: $separatedFirstExpanded,
            title: "첫 번째 항목",
            description: "항목 사이에 간격이 있습니다.",
            action: { separatedFirstExpanded.toggle() }
          )
        }
        .accordionSize(.large)
        .accordionStyle(.separated)
      }
    }
  }
}
