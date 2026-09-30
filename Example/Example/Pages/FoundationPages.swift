import SwiftUI

enum FoundationPages: CaseIterable, Hashable, Identifiable, Sendable {
  case color
  case font
}

enum ComponentPages: CaseIterable, Hashable, Identifiable, Sendable {
  case accordion
  case alertDialog
  case buttonStyle
}

extension FoundationPages {
  var id: Self { self }

  var title: String {
    switch self {
    case .color: "색상"
    case .font: "폰트"
    }
  }
}

extension ComponentPages {
  var id: Self { self }

  var title: String {
    switch self {
    case .accordion: "아코디언"
    case .alertDialog: "다이얼로그"
    case .buttonStyle: "버튼"
    }
  }
}

extension View {
  func navigationFoundationPages() -> some View {
    navigationDestination(for: FoundationPages.self) { page in
      switch page {
      case .color: ColorExamplePage()
      case .font: FontExamplePage()
      }
    }
  }

  func navigationComponentPages() -> some View {
    navigationDestination(for: ComponentPages.self) { page in
      switch page {
      case .accordion: AccordionExamplePage()
      case .alertDialog: AlertDialogExamplePage()
      case .buttonStyle: ButtonStyleExamplePage()
      }
    }
  }
}
