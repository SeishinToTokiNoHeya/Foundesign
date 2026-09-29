import SwiftUI

extension EnvironmentValues {
  @Entry var accordionSize: FoundesignAccordionSize = .medium
}

extension View {
  public func accordionSize(_ size: FoundesignAccordionSize) -> some View {
    environment(\.accordionSize, size)
  }
}
