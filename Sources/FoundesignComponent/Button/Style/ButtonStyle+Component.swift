import SwiftUI

extension ButtonStyle where Self == FoundesignOutlineButtonStyle {
  public static var outline: FoundesignOutlineButtonStyle {
    outline()
  }

  public static func outline(
    property: FoundesignButtonProperty
  ) -> FoundesignOutlineButtonStyle {
    FoundesignOutlineButtonStyle(property)
  }

  public static func outline(
    tone: FoundesignButtonProperty.Tone = .brand,
    size: FoundesignButtonProperty.Size = .medium
  ) -> FoundesignOutlineButtonStyle {
    outline(property: .init(tone: tone, size: size))
  }
}

extension ButtonStyle where Self == FoundesignSolidButtonStyle {
  public static var solid: FoundesignSolidButtonStyle {
    solid()
  }

  public static func solid(
    property: FoundesignButtonProperty
  ) -> FoundesignSolidButtonStyle {
    FoundesignSolidButtonStyle(property)
  }

  public static func solid(
    tone: FoundesignButtonProperty.Tone = .brand,
    size: FoundesignButtonProperty.Size = .medium
  ) -> FoundesignSolidButtonStyle {
    solid(property: .init(tone: tone, size: size))
  }
}

extension ButtonStyle where Self == FoundesignWeakButtonStyle {
  public static var weak: FoundesignWeakButtonStyle {
    weak()
  }

  public static func weak(
    property: FoundesignButtonProperty
  ) -> FoundesignWeakButtonStyle {
    FoundesignWeakButtonStyle(property)
  }

  public static func weak(
    tone: FoundesignButtonProperty.Tone = .brand,
    size: FoundesignButtonProperty.Size = .medium
  ) -> FoundesignWeakButtonStyle {
    weak(property: .init(tone: tone, size: size))
  }
}
