import FoundesignFoundation
import SwiftUI

/// 선택지나 액션을 실행하는 메뉴 항목입니다.
///
/// 활성 항목을 누르면 메뉴의 선택 바인딩을 `nil`로 바꾼 뒤 액션을 실행합니다.
/// `.disabled`를 존중하며 선택 상태는 호출자가 관리합니다. 긴 제목은 줄바꿈합니다.
public struct FoundesignMenuItem: View {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.menuProperty) private var property
  @Environment(\.dismissFoundesignMenu) private var dismissMenu

  private let title: String
  private let description: String?
  private let systemImage: String?
  private let badge: String?
  private let isSelected: Bool
  private let role: ButtonRole?
  private let action: () -> Void

  /// 메뉴 항목을 만듭니다.
  /// - Parameters:
  ///   - title: 항목의 제목입니다.
  ///   - description: 필요한 경우에만 표시할 보조 설명입니다.
  ///   - systemImage: 제목 앞에 표시할 선택적 SF Symbol입니다.
  ///   - badge: 제목 옆에 표시할 선택적 뱃지 문자열입니다.
  ///   - isSelected: 선택 표시 여부이며 기본값은 `false`입니다. 선택 시 체크 표시를 붙입니다.
  ///   - role: `.destructive`이면 위험 작업 색상을 사용합니다. 기본값은 `nil`입니다.
  ///   - action: 메뉴의 닫힘을 요청한 뒤 실행할 동작입니다.
  public init(
    title: String,
    description: String? = nil,
    systemImage: String? = nil,
    badge: String? = nil,
    isSelected: Bool = false,
    role: ButtonRole? = nil,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.description = description
    self.systemImage = systemImage
    self.badge = badge
    self.isSelected = isSelected
    self.role = role
    self.action = action
  }

  public var body: some View {
    Button(role: role, action: itemTapped) {
      HStack(spacing: theme.spacing.medium) {
        if let systemImage {
          Image(systemName: systemImage)
            .frame(width: theme.spacing.xLarge)
        }
        VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
          Text(title)
            .fixedSize(horizontal: false, vertical: true)
          if let description {
            Text(description)
              .typography(theme.typography.label.small)
              .foregroundStyle(
                isEnabled ? theme.color.foreground.secondary : theme.color.foreground.disabled
              )
              .fixedSize(horizontal: false, vertical: true)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        if let badge {
          FoundesignBadge(title: badge)
        }
        if isSelected {
          Image(systemName: "checkmark")
        }
      }
      .typography(
        property.size == .small ? theme.typography.body.small : theme.typography.body.medium
      )
      .foregroundStyle(foregroundColor)
    }
    .buttonStyle(FoundesignMenuItemStyle())
  }

  private var foregroundColor: Color {
    guard isEnabled else { return theme.color.foreground.disabled }
    return role == .destructive
      ? theme.color.foreground.critical.strong : theme.color.foreground.primary
  }

  private func itemTapped() {
    dismissMenu()
    action()
  }
}

private struct FoundesignMenuItemStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.menuProperty) private var property
  @State private var isHovered = false

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, theme.spacing.small)
      .padding(.vertical, property.size == .small ? theme.spacing.small : theme.spacing.medium)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        isEnabled && (configuration.isPressed || isHovered)
          ? theme.color.background.transparent.pressed
          : theme.color.background.transparent.normal,
        in: .rect(cornerRadius: theme.radius.small)
      )
      .contentShape(.rect)
      .padding(.horizontal, theme.spacing.small)
      .onHover { isHovered = $0 }
  }
}
