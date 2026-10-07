import SwiftUI

extension EnvironmentValues {
  @Entry var badgeProperty = FoundesignBadgeProperty()
}

extension View {
  /// 하위 뱃지가 상속할 외형 속성 전체를 교체합니다.
  /// - Parameter property: 크기·톤·표현 방식입니다. 하위 뷰에 더 가까운 설정이 우선합니다.
  public func badgeProperty(_ property: FoundesignBadgeProperty) -> some View {
    environment(\.badgeProperty, property)
  }

  /// 다른 상속 속성을 유지하면서 하위 뱃지의 크기를 바꿉니다.
  /// - Parameter size: 상속할 크기입니다. 기본값은 `.medium`이며 가까운 설정이 우선합니다.
  public func badgeSize(_ size: FoundesignBadgeProperty.Size) -> some View {
    transformEnvironment(\.badgeProperty) { $0.size = size }
  }

  /// 다른 상속 속성을 유지하면서 하위 뱃지의 톤을 바꿉니다.
  /// - Parameter tone: 상속할 톤입니다. 기본값은 `.neutral`이며 가까운 설정이 우선합니다.
  public func badgeTone(_ tone: FoundesignBadgeProperty.Tone) -> some View {
    transformEnvironment(\.badgeProperty) { $0.tone = tone }
  }

  /// 다른 상속 속성을 유지하면서 하위 뱃지의 배경과 테두리 표현을 바꿉니다.
  /// - Parameter variant: 상속할 표현 방식입니다. 기본값은 `.weak`이며 가까운 설정이 우선합니다.
  public func badgeVariant(_ variant: FoundesignBadgeProperty.Variant) -> some View {
    transformEnvironment(\.badgeProperty) { $0.variant = variant }
  }
}
