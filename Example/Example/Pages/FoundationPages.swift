import SwiftUI

enum FoundationPages: CaseIterable, Hashable, Identifiable, Sendable {
  case color
  case font
}

enum ComponentPages: CaseIterable, Hashable, Identifiable, Sendable {
  case accordion
  case alertDialog
  case buttonStyle
  case checkbox
  case wheelPicker
}

extension FoundationPages {
  var id: Self { self }

  var title: String {
    switch self {
    case .color: "Color"
    case .font: "Font"
    }
  }
}

extension ComponentPages {
  var id: Self { self }

  var title: String {
    switch self {
    case .accordion: "Accordion"
    case .alertDialog: "Alert Dialog"
    case .buttonStyle: "Button Style"
    case .checkbox: "Checkbox"
    case .wheelPicker: "Wheel Picker"
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
      case .checkbox: CheckboxExamplePage()
      case .wheelPicker: WheelPickerExamplePage()
      }
    }
  }
}
