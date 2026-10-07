import FoundesignFoundation
import SwiftUI

struct FoundesignMenuOverlay<Content: View>: View {
  @Environment(\.theme) private var theme
  @Environment(\.menuProperty) private var property
  @Environment(\.layoutDirection) private var layoutDirection
  let anchor: CGRect
  let bounds: CGRect
  let dismiss: () -> Void
  let content: Content
  @State private var contentHeight: CGFloat = 0

  var body: some View {
    let frame = menuFrame
    ZStack(alignment: .topLeading) {
      Color.clear
        .contentShape(.rect)
        .onTapGesture(perform: dismiss)
      ScrollView {
        VStack(alignment: .leading, spacing: theme.spacing.zero) {
          content
        }
        .padding(.vertical, theme.spacing.small)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .background {
          GeometryReader { proxy in
            Color.clear.preference(
              key: FoundesignMenuHeightPreference.self, value: proxy.size.height)
          }
        }
      }
      .scrollBounceBehavior(.basedOnSize)
      .frame(width: frame.width, height: frame.height)
      .background(theme.color.background.elevated)
      .clipShape(.rect(cornerRadius: theme.radius.large))
      .overlay {
        RoundedRectangle(cornerRadius: theme.radius.large)
          // 어두운 표면에서도 경계만 구분되도록 얇고 옅게 표시합니다.
          .strokeBorder(theme.color.border.base.opacity(0.4), lineWidth: 0.5)
          .allowsHitTesting(false)
      }
      // 딤 처리용 색상의 강도를 낮추고 넓게 퍼뜨려 가벼운 부유감을 만듭니다.
      // 기본 테마에서는 약 11% 불투명도의 그림자가 됩니다.
      .shadow(
        color: theme.color.background.overlay.opacity(0.24),
        radius: theme.spacing.medium,
        y: theme.spacing.xSmall
      )
      .environment(\.dismissFoundesignMenu, FoundesignMenuDismissAction(action: dismiss))
      .environment(\.layoutDirection, layoutDirection)
      .onPreferenceChange(FoundesignMenuHeightPreference.self) { contentHeight = $0 }
      // 계산한 좌표는 물리적 왼쪽이 원점이므로 RTL의 leading 정렬과 분리합니다.
      .position(x: frame.midX, y: frame.midY)
      // 첫 측정 전의 임시 높이가 화면에 노출되지 않게 합니다.
      .opacity(contentHeight > 0 ? 1 : 0)
    }
    // 위치만 물리 좌표로 배치하고 메뉴 콘텐츠는 호출자의 읽기 방향을 유지합니다.
    .environment(\.layoutDirection, .leftToRight)
  }

  private var menuFrame: CGRect {
    let gap = theme.spacing.small
    let available = bounds.insetBy(dx: min(gap, bounds.width / 2), dy: min(gap, bounds.height / 2))
    let above = max(0, min(available.height, anchor.minY - gap - available.minY))
    let below = max(0, min(available.height, available.maxY - anchor.maxY - gap))
    // 긴 메뉴는 480pt를 상한으로 두고 나머지는 내부 스크롤로 조작합니다.
    let desiredHeight = min(contentHeight > 0 ? contentHeight : 480, 480)
    let prefersBottom = property.placement == .bottom
    let preferredSpace = prefersBottom ? below : above
    let oppositeSpace = prefersBottom ? above : below
    let usesPreferred = preferredSpace >= desiredHeight || preferredSpace >= oppositeSpace
    let opensBelow = usesPreferred ? prefersBottom : !prefersBottom
    let height = min(desiredHeight, opensBelow ? below : above)
    let fixedWidth: CGFloat = property.size == .small ? 200 : 240
    let width = min(property.width == .trigger ? anchor.width : fixedWidth, available.width)
    let isRTL = layoutDirection == .rightToLeft
    let proposedX: CGFloat
    switch property.alignment {
    case .leading: proposedX = isRTL ? anchor.maxX - width : anchor.minX
    case .center: proposedX = anchor.midX - width / 2
    case .trailing: proposedX = isRTL ? anchor.minX : anchor.maxX - width
    }
    return CGRect(
      x: min(max(proposedX, available.minX), available.maxX - width),
      y: min(
        max(opensBelow ? anchor.maxY + gap : anchor.minY - gap - height, available.minY),
        available.maxY - height),
      width: width,
      height: height
    )
  }
}

private struct FoundesignMenuHeightPreference: PreferenceKey {
  static let defaultValue: CGFloat = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = max(value, nextValue())
  }
}
