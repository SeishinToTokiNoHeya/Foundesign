import FoundesignFoundation
import SwiftUI

/// 체크박스의 크기·강조·비활성 상태에 맞춰 표시하는 문자열 라벨입니다.
public struct FoundesignCheckLabel: View {
  @Environment(\.theme) private var theme
  @Environment(\.checkboxProperty) private var property
  @Environment(\.isEnabled) private var isEnabled

  private let title: String

  /// 체크박스 라벨을 만듭니다.
  /// - Parameters:
  ///   - title: 표시할 문자열입니다.
  public init(title: String) {
    self.title = title
  }

  public var body: some View {
    Text(title)
      .typography(property.size.typography(theme.typography))
      .fontWeight(property.weight.fontWeight)
      .foregroundStyle(isEnabled ? theme.color.foreground.primary : theme.color.foreground.disabled)
      .multilineTextAlignment(.leading)
      .fixedSize(horizontal: false, vertical: true)
  }
}
