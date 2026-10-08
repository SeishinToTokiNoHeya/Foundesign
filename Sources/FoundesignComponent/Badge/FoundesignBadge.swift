import FoundesignFoundation
import SwiftUI

/// 짧은 분류나 상태를 표시하는 정적인 정보 라벨입니다.
///
/// 크기·톤·표현 방식은 환경에서 상속하며, 가까운 스타일 modifier가 우선합니다.
/// 환경의 테마와 비활성 상태를 반영합니다. 라벨은 한 줄로 표시하며,
/// 부모가 제공하는 폭이 부족하면 끝을 말줄임합니다. 자체 최대 폭은 지정하지 않습니다.
/// 빈 문자열도 여백과 배경을 유지합니다. 동작이 필요하면 별도의 버튼을 사용하세요.
/// 사용 예제는 <doc:Badge>를 참고하세요.
public struct FoundesignBadge: View {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.badgeProperty) private var property

  private let title: String
  private let systemImage: String?

  /// 문자열과 선택적인 SF Symbol로 뱃지를 만듭니다.
  /// - Parameters:
  ///   - title: 표시할 짧은 문자열입니다.
  ///   - systemImage: 앞에 표시할 SF Symbol 이름입니다. `nil`이면 텍스트만 표시합니다.
  public init(
    title: String,
    systemImage: String? = nil
  ) {
    self.title = title
    self.systemImage = systemImage
  }

  public var body: some View {
    HStack(spacing: theme.spacing.xSmall) {
      if let systemImage {
        Image(systemName: systemImage)
          .fixedSize()
      }
      Text(title)
        .lineLimit(1)
        .truncationMode(.tail)
    }
    .typography(typography)
    .fontWeight(property.variant == .weak ? .medium : .bold)
    .foregroundStyle(foregroundColor)
    .padding(.horizontal, horizontalPadding)
    .padding(.vertical, theme.spacing.xSmall)
    .background(backgroundColor, in: shape)
    .overlay {
      if property.variant == .outline {
        // 크기에 관계없이 얇은 경계를 유지합니다.
        shape.strokeBorder(borderColor, lineWidth: 1)
      }
    }
  }

  private var typography: Typography {
    switch property.size {
    case .medium: theme.typography.label.small
    case .large: theme.typography.label.medium
    }
  }

  private var horizontalPadding: CGFloat {
    switch property.size {
    case .medium: theme.spacing.small
    case .large: theme.spacing.medium
    }
  }

  private var shape: RoundedRectangle {
    let radius =
      switch property.size {
      case .medium: theme.radius.small
      case .large: theme.radius.medium
      }
    return .rect(cornerRadius: radius)
  }

  private var backgroundRole: ColorToken.Background.Role {
    switch property.tone {
    case .neutral: theme.color.background.neutral
    case .brand: theme.color.background.brand
    case .informative: theme.color.background.informative
    case .positive: theme.color.background.positive
    case .warning: theme.color.background.warning
    case .critical: theme.color.background.critical
    }
  }

  private var backgroundColor: Color {
    let state: ColorToken.State =
      switch property.variant {
      case .weak: backgroundRole.weak
      case .solid: backgroundRole.solid
      case .outline: theme.color.background.transparent
      }
    return isEnabled ? state.normal : state.disabled
  }

  private var foregroundColor: Color {
    guard isEnabled else { return theme.color.foreground.disabled }
    let foreground = theme.color.foreground
    let role: ColorToken.Foreground.Role
    switch property.tone {
    case .neutral:
      return property.variant == .solid ? foreground.inverse : foreground.secondary
    case .brand: role = foreground.brand
    case .informative: role = foreground.informative
    case .positive: role = foreground.positive
    case .warning: role = foreground.warning
    case .critical: role = foreground.critical
    }
    return property.variant == .solid ? role.solid : role.strong
  }

  private var borderColor: Color {
    guard isEnabled else { return theme.color.border.disabled }
    let border = theme.color.border
    switch property.tone {
    case .neutral: return border.base
    case .brand: return border.brand.weak
    case .informative: return border.informative.weak
    case .positive: return border.positive.weak
    case .warning: return border.warning.weak
    case .critical: return border.critical.weak
    }
  }
}
