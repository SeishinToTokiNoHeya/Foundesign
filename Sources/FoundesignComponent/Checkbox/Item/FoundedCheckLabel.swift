import FoundesignFoundation
import SwiftUI

public struct FoundedCheckLabel: View {
  @Environment(\.theme) private var theme
  @Environment(\.checkboxProperty) private var inheritedProperty
  @Environment(\.isEnabled) private var isEnabled

  private let title: String
  private let property: FoundesignCheckboxProperty?

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
