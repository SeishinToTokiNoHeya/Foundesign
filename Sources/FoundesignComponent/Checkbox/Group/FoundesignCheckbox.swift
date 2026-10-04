import SwiftUI

/// 체크마크와 라벨을 조합하고, 라벨을 포함한 행 전체에서 선택을 변경합니다.
///
/// 명시적인 `property`는 환경에서 상속한 속성보다 우선합니다.
/// 단일 선택과 전체 선택의 조합은 <doc:Checkbox>를 참고하세요.
public struct FoundesignCheckbox<Label>: View where Label: View {
  @Environment(\.checkboxProperty) private var inheritedProperty

  private let toggle: Toggle<Label>
  private let property: FoundesignCheckboxProperty?
  private let isEmpty: Bool

  /// 하나의 선택 바인딩과 사용자 정의 라벨로 체크박스를 만듭니다.
  /// - Parameters:
  ///   - isOn: 현재 선택 상태이며 행을 누르면 변경되는 바인딩입니다.
  ///   - property: 이 항목의 속성입니다. `nil`이면 환경 속성을 상속합니다.
  ///   - label: 체크마크 옆에 표시할 라벨입니다.
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
  ///
  /// - Parameters:
  ///   - sources: 함께 변경할 선택 바인딩 목록입니다.
  ///   - property: 이 항목의 속성입니다. `nil`이면 환경 속성을 상속합니다.
  ///   - label: 체크마크 옆에 표시할 라벨입니다.
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
  /// 문자열 라벨을 사용하는 단일 선택 체크박스를 만듭니다.
  /// - Parameters:
  ///   - title: 표시할 라벨입니다.
  ///   - isOn: 행을 누르면 변경되는 선택 바인딩입니다.
  ///   - property: 명시적 속성입니다. `nil`이면 환경 속성을 상속합니다.
  public init(
    title: String,
    isOn: Binding<Bool>,
    property: FoundesignCheckboxProperty? = nil
  ) {
    self.init(isOn: isOn, property: property) {
      FoundedCheckLabel(title: title)
    }
  }

  /// 문자열 라벨을 사용하는 전체 선택 체크박스를 만듭니다.
  /// - Parameters:
  ///   - title: 표시할 라벨입니다.
  ///   - sources: 함께 변경할 바인딩입니다. 비어 있으면 미선택 상태로 비활성화됩니다.
  ///   - property: 명시적 속성입니다. `nil`이면 환경 속성을 상속합니다.
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
