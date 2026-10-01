import SwiftUI

/// 체크마크와 라벨을 조합하고, 라벨을 포함한 행 전체에서 선택을 변경합니다.
public struct FoundesignCheckbox<Label>: View where Label: View {
  @Environment(\.checkboxProperty) private var inheritedProperty

  private let toggle: Toggle<Label>
  private let property: FoundesignCheckboxProperty?
  private let isEmpty: Bool

  public init(
    isOn: Binding<Bool>,
    property: FoundesignCheckboxProperty? = nil,
    @ViewBuilder label: () -> Label
  ) {
    self.toggle = Toggle(isOn: isOn, label: label)
    self.property = property
    self.isEmpty = false
  }

  /// 여러 바인딩을 함께 변경합니다. 일부만 선택되면 부분 선택 상태로 표시합니다.
  /// 선택할 바인딩이 없으면 미선택 상태로 비활성화됩니다.
  public init(
    sources: some RandomAccessCollection<Binding<Bool>>,
    property: FoundesignCheckboxProperty? = nil,
    @ViewBuilder label: () -> Label
  ) {
    if sources.isEmpty {
      self.toggle = Toggle(isOn: .constant(false), label: label)
    } else {
      self.toggle = Toggle(sources: sources, isOn: \.self, label: label)
    }
    self.property = property
    self.isEmpty = sources.isEmpty
  }

  public var body: some View {
    toggle
      .toggleStyle(FoundesignCheckboxToggleStyle())
      .environment(\.checkboxProperty, property ?? inheritedProperty)
      .disabled(isEmpty)
  }
}

extension FoundesignCheckbox where Label == FoundedCheckLabel {
  public init(
    title: String,
    isOn: Binding<Bool>,
    property: FoundesignCheckboxProperty? = nil
  ) {
    self.init(isOn: isOn, property: property) {
      FoundedCheckLabel(title: title)
    }
  }

  public init(
    title: String,
    sources: some RandomAccessCollection<Binding<Bool>>,
    property: FoundesignCheckboxProperty? = nil
  ) {
    self.init(sources: sources, property: property) {
      FoundedCheckLabel(title: title)
    }
  }
}
