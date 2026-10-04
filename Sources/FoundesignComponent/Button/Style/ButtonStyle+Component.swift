import SwiftUI

extension ButtonStyle where Self == FoundesignOutlineButtonStyle {
  /// 브랜드 톤·중간 크기의 테두리 버튼 스타일입니다.
  public static var outline: FoundesignOutlineButtonStyle {
    outline()
  }

  /// 지정한 속성으로 테두리 버튼 스타일을 만듭니다.
  /// - Parameter property: 적용할 톤과 크기입니다.
  /// - Returns: 테두리 버튼 스타일입니다.
  public static func outline(
    property: FoundesignButtonProperty
  ) -> FoundesignOutlineButtonStyle {
    FoundesignOutlineButtonStyle(property)
  }

  /// 톤과 크기로 테두리 버튼 스타일을 만듭니다.
  /// - Parameters:
  ///   - tone: 의미별 톤입니다. 기본값은 `.brand`입니다.
  ///   - size: 버튼 크기입니다. 기본값은 `.medium`입니다.
  /// - Returns: 테두리 버튼 스타일입니다.
  public static func outline(
    tone: FoundesignButtonProperty.Tone = .brand,
    size: FoundesignButtonProperty.Size = .medium
  ) -> FoundesignOutlineButtonStyle {
    outline(property: .init(tone: tone, size: size))
  }
}

extension ButtonStyle where Self == FoundesignSolidButtonStyle {
  /// 브랜드 톤·중간 크기의 채운 배경 버튼 스타일입니다.
  public static var solid: FoundesignSolidButtonStyle {
    solid()
  }

  /// 지정한 속성으로 채운 배경 버튼 스타일을 만듭니다.
  /// - Parameter property: 적용할 톤과 크기입니다.
  /// - Returns: 채운 배경 버튼 스타일입니다.
  public static func solid(
    property: FoundesignButtonProperty
  ) -> FoundesignSolidButtonStyle {
    FoundesignSolidButtonStyle(property)
  }

  /// 톤과 크기로 채운 배경 버튼 스타일을 만듭니다.
  /// - Parameters:
  ///   - tone: 의미별 톤입니다. 기본값은 `.brand`입니다.
  ///   - size: 버튼 크기입니다. 기본값은 `.medium`입니다.
  /// - Returns: 채운 배경 버튼 스타일입니다.
  public static func solid(
    tone: FoundesignButtonProperty.Tone = .brand,
    size: FoundesignButtonProperty.Size = .medium
  ) -> FoundesignSolidButtonStyle {
    solid(property: .init(tone: tone, size: size))
  }
}

extension ButtonStyle where Self == FoundesignWeakButtonStyle {
  /// 브랜드 톤·중간 크기의 약한 배경 버튼 스타일입니다.
  public static var weak: FoundesignWeakButtonStyle {
    weak()
  }

  /// 지정한 속성으로 약한 배경 버튼 스타일을 만듭니다.
  /// - Parameter property: 적용할 톤과 크기입니다.
  /// - Returns: 약한 배경 버튼 스타일입니다.
  public static func weak(
    property: FoundesignButtonProperty
  ) -> FoundesignWeakButtonStyle {
    FoundesignWeakButtonStyle(property)
  }

  /// 톤과 크기로 약한 배경 버튼 스타일을 만듭니다.
  /// - Parameters:
  ///   - tone: 의미별 톤입니다. 기본값은 `.brand`입니다.
  ///   - size: 버튼 크기입니다. 기본값은 `.medium`입니다.
  /// - Returns: 약한 배경 버튼 스타일입니다.
  public static func weak(
    tone: FoundesignButtonProperty.Tone = .brand,
    size: FoundesignButtonProperty.Size = .medium
  ) -> FoundesignWeakButtonStyle {
    weak(property: .init(tone: tone, size: size))
  }
}
