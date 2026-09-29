import SwiftUI

extension EnvironmentValues {
  @Entry var accordionSize: FoundesignAccordionSize = .medium
  @Entry var accordionStyle: FoundesignAccordionStyle = .inline
}

extension View {
  public func accordionSize(_ size: FoundesignAccordionSize) -> some View {
    environment(\.accordionSize, size)
  }

  public func accordionStyle(_ style: FoundesignAccordionStyle) -> some View {
    environment(\.accordionStyle, style)
  }
}
