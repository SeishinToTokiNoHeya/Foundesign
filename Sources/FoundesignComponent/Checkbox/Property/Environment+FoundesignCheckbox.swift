import SwiftUI

extension EnvironmentValues {
  @Entry var checkboxProperty = FoundesignCheckboxProperty()
  @Entry var checkboxIsPressed = false
}

extension View {
  public func checkboxProperty(_ property: FoundesignCheckboxProperty) -> some View {
    environment(\.checkboxProperty, property)
  }

  public func checkboxSize(_ size: FoundesignCheckboxProperty.Size) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.size = size }
  }

  public func checkboxWeight(_ weight: FoundesignCheckboxProperty.Weight) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.weight = weight }
  }

  public func checkboxTone(_ tone: FoundesignCheckboxProperty.Tone) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.tone = tone }
  }

  public func checkboxShape(_ shape: FoundesignCheckboxProperty.Shape) -> some View {
    transformEnvironment(\.checkboxProperty) { $0.shape = shape }
  }
}
