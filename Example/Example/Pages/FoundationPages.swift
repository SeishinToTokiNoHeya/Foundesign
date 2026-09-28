import SwiftUI

enum FoundationPages: CaseIterable, Hashable, Identifiable, Sendable {
  case color
}

extension FoundationPages {
  var id: Self { self }
  
  var title: String {
    switch self {
    case .color: "색상"
    }
  }
}

extension View {
  func navigationFoundationPages() -> some View {
    navigationDestination(for: FoundationPages.self) { page in
      switch page {
      case .color: ColorExamplePage()
      }
    }
  }
}
