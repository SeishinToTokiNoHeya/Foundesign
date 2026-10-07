import SwiftUI

extension View {
  /// 메뉴 배치의 기준이 되는 뷰를 식별자로 등록합니다.
  ///
  /// 버튼 액션에서 `menuScope(selection:content:)`의 선택값을 이 식별자로 바꾸면 메뉴가 열립니다.
  /// 가장 가까운 동일 식별자 타입의 표시 영역으로 위치와 활성 상태만 전달합니다.
  /// - Parameter id: 표시 영역 안에서 고유한 식별자입니다. 중복되면 마지막 뷰의 위치를 사용합니다.
  public func menuAnchor<ID: Hashable>(id: ID) -> some View {
    modifier(FoundesignMenuAnchor(id: id))
  }

  /// 선택된 버튼의 위치에 제네릭 콘텐츠로 구성한 메뉴를 표시합니다.
  ///
  /// 화면 전체를 채운 안전 영역의 컨테이너에 적용하고 ScrollView·List·클리핑 바깥에 둡니다.
  /// 시트에는 별도로 적용합니다. 콘텐츠와 외형은 이 표시 영역의 환경을 상속하며,
  /// 버튼에만 적용한 환경 설정은 메뉴에 전달되지 않습니다.
  ///
  /// 기본적으로 아래쪽에 열고 공간이 부족하면 반전합니다. 양쪽 모두 부족하면 더 넓은 쪽에서
  /// 스크롤하며 높이는 최대 480pt입니다. 버튼과 경계 여백은 테마의 `spacing.small`입니다.
  /// `FoundesignMenuItem` 선택·바깥 영역 클릭·표시 중인 앵커 제거 또는 비활성화 시
  /// 선택값을 `nil`로 바꿉니다. 일반 `Button`은 액션에서 선택값을 직접 비워 닫습니다.
  /// 일치하는 활성 앵커가 없으면 메뉴를 만들지 않습니다. 사용 흐름은 <doc:Menu>를 참고하세요.
  /// - Parameters:
  ///   - selection: 열 메뉴의 앵커 식별자입니다. `nil`이면 닫힙니다.
  ///   - content: 식별자별 메뉴 콘텐츠입니다. 조건문으로 서로 다른 뷰를 구성할 수 있습니다.
  public func menuScope<ID: Hashable, MenuContent: View>(
    selection: Binding<ID?>,
    @ViewBuilder content: @escaping (ID) -> MenuContent
  ) -> some View {
    overlayPreferenceValue(FoundesignMenuPreference<ID>.self) { anchors in
      GeometryReader { proxy in
        if let id = selection.wrappedValue,
          let anchor = anchors.last(where: { $0.id == id }),
          anchor.isEnabled
        {
          FoundesignMenuOverlay(
            anchor: proxy[anchor.bounds],
            // 앵커와 같은 로컬 좌표를 사용해 안전 여백을 중복 적용하지 않습니다.
            bounds: CGRect(origin: .zero, size: proxy.size),
            dismiss: { selection.wrappedValue = nil },
            content: content(id)
          )
          .id(id)
          .onDisappear {
            // 다른 앵커로 전환한 직후 이전 메뉴의 종료가 새 선택을 지우지 않도록 합니다.
            if selection.wrappedValue == id { selection.wrappedValue = nil }
          }
        }
      }
    }
    .transformPreference(FoundesignMenuPreference<ID>.self) { $0 = [] }
  }
}

private struct FoundesignMenuAnchor<ID: Hashable>: ViewModifier {
  @Environment(\.isEnabled) private var isEnabled
  let id: ID

  func body(content: Content) -> some View {
    content.anchorPreference(key: FoundesignMenuPreference<ID>.self, value: .bounds) { bounds in
      [FoundesignMenuAnchorValue(id: id, bounds: bounds, isEnabled: isEnabled)]
    }
  }
}

private struct FoundesignMenuAnchorValue<ID: Hashable> {
  let id: ID
  let bounds: Anchor<CGRect>
  let isEnabled: Bool
}

private struct FoundesignMenuPreference<ID: Hashable>: PreferenceKey {
  static var defaultValue: [FoundesignMenuAnchorValue<ID>] { [] }

  static func reduce(
    value: inout [FoundesignMenuAnchorValue<ID>], nextValue: () -> [FoundesignMenuAnchorValue<ID>]
  ) {
    value.append(contentsOf: nextValue())
  }
}
