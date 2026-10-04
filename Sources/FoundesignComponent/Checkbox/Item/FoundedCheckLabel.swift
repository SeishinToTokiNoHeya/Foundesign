import FoundesignFoundation
import SwiftUI

/// 체크박스의 크기·강조·비활성 상태에 맞춰 표시하는 문자열 라벨입니다.
public struct FoundedCheckLabel: View {
  @Environment(\.theme) private var theme
  @Environment(\.checkboxProperty) private var inheritedProperty
  @Environment(\.isEnabled) private var isEnabled

  private let title: String
  private let property: FoundesignCheckboxProperty?

  /// 체크박스 라벨을 만듭니다.
  /// - Parameters:
  ///   - title: 표시할 문자열입니다.
  ///   - property: 명시적 속성입니다. `nil`이면 환경 속성을 상속합니다.
  public init(title: String, property: FoundesignCheckboxProperty? = nil) {
    self.title = title
    self.property = property
  }

  public var body: some View {
    Text(title)
      .typography(resolvedProperty.size.typography(theme.typography))
      .fontWeight(resolvedProperty.weight.fontWeight)
      .foregroundStyle(isEnabled ? theme.color.foreground.primary : theme.color.foreground.disabled)
      .multilineTextAlignment(.leading)
      .fixedSize(horizontal: false, vertical: true)
  }

  private var resolvedProperty: FoundesignCheckboxProperty {
    property ?? inheritedProperty
  }
}
