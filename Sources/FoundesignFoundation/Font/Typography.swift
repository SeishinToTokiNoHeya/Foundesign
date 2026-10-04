import SwiftUI

/// 텍스트에 적용할 SwiftUI 글꼴을 담는 값입니다.
public struct Typography: Hashable, Sendable {
  /// 텍스트에 적용할 글꼴입니다.
  public var font: Font

  /// 지정한 글꼴로 타이포그래피를 만듭니다.
  /// - Parameter font: 적용할 SwiftUI 글꼴입니다.
  public init(font: Font) {
    self.font = font
  }
}
