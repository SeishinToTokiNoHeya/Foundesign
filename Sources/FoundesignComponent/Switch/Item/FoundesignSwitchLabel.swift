import FoundesignFoundation
import SwiftUI

/// 스위치의 크기와 비활성 상태에 맞춰 표시하는 문자열 라벨입니다.
public struct FoundesignSwitchLabel: View {
  @Environment(\.theme) private var theme
  @Environment(\.switchProperty) private var property
  @Environment(\.isEnabled) private var isEnabled

  private let title: String

  /// 스위치 라벨을 만듭니다.
  /// - Parameters:
  ///   - title: 표시할 문자열입니다. 긴 문자열은 여러 줄로 표시합니다.
  public init(title: String) {
    self.title = title
  }

  public var body: some View {
    Text(title)
      .typography(property.size.typography(theme.typography))
      .fontWeight(.medium)
      .foregroundStyle(isEnabled ? theme.color.foreground.primary : theme.color.foreground.disabled)
      .multilineTextAlignment(.leading)
      .fixedSize(horizontal: false, vertical: true)
  }
}
