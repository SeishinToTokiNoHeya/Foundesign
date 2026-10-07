import SwiftUI

extension ButtonStyle where Self == FoundesignOutlineButtonStyle {
  /// 환경의 톤과 크기를 사용하는 테두리 버튼 스타일입니다.
  public static var outline: FoundesignOutlineButtonStyle {
    .init()
  }
}

extension ButtonStyle where Self == FoundesignSolidButtonStyle {
  /// 환경의 톤과 크기를 사용하는 채운 배경 버튼 스타일입니다.
  public static var solid: FoundesignSolidButtonStyle {
    .init()
  }
}

extension ButtonStyle where Self == FoundesignWeakButtonStyle {
  /// 환경의 톤과 크기를 사용하는 약한 배경 버튼 스타일입니다.
  public static var weak: FoundesignWeakButtonStyle {
    .init()
  }
}
