import SwiftUI

enum FoundationPages: CaseIterable, Hashable, Identifiable, Sendable {
  case color
  case font
}

enum ComponentPages: CaseIterable, Hashable, Identifiable, Sendable {
  case accordion
  case alertDialog
  case badge
  case buttonStyle
  case checkbox
  case menu
  case `switch`
  case textField
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
    case .badge: "Badge"
    case .buttonStyle: "Button Style"
    case .checkbox: "Checkbox"
    case .menu: "Menu"
    case .switch: "Switch"
    case .textField: "Text Field"
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
      case .badge: BadgeExamplePage()
      case .buttonStyle: ButtonStyleExamplePage()
      case .checkbox: CheckboxExamplePage()
      case .menu: MenuExamplePage()
      case .switch: SwitchExamplePage()
      case .textField: TextFieldExamplePage()
      case .wheelPicker: WheelPickerExamplePage()
      }
    }
  }
}
