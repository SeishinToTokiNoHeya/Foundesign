import FoundesignFoundation
import SwiftUI

extension View {
  /// 호출 뷰가 속한 window 위에 바텀 시트를 모달로 표시합니다.
  ///
  /// TabView·NavigationStack 안의 자식 뷰에서 호출해도 현재 window의 탭바와 콘텐츠를 덮습니다.
  /// iOS에서는 해당 window의 최상위 화면 위에 전체 화면 모달로, macOS에서는 해당 window에
  /// 연결된 패널로 표시합니다. 다른 window에는 영향을 주지 않습니다.
  /// 호출 뷰가 window에서 제거되면 표시 바인딩을 `false`로 바꾸고 닫습니다.
  /// 호출 위치의 테마와 환경을 상속하며 최대 너비는 480pt입니다.
  /// 최대 높이는 가용 화면 높이의 90%와 상단 안전 영역 중 작은 값이며,
  /// 키보드가 나타나면 SwiftUI의 안전 영역에 맞춰 가용 높이가 줄어듭니다.
  ///
  /// 스냅 포인트가 없으면 콘텐츠 높이를 사용합니다. 유효한 스냅 포인트는 높이순으로 정렬하고
  /// 중복을 제거하며 처음에는 가장 작은 높이를 선택합니다. 다시 열면 초기 높이로 돌아갑니다.
  /// 핸들을 드래그해 크기를 바꾸거나 최소 높이 아래로 내려 닫습니다. 본문 드래그는 스크롤에 사용합니다.
  /// 외형 modifier는 이 modifier 뒤에 붙여 표시 영역 전체에 적용하세요. 사용 흐름은 <doc:BottomSheet>를 참고하세요.
  /// - Parameters:
  ///   - isPresented: 표시 상태입니다. 사용자 닫기 동작은 즉시 `false`로 변경합니다.
  ///   - snapPoints: 머무를 높이 목록입니다. 유한한 양수가 아닌 값은 무시하고 최대 높이로 제한합니다.
  ///   - isDismissible: 바깥 클릭과 핸들 드래그로 닫을 수 있는지 여부입니다. 기본값은 `true`입니다.
  ///     `false`여도 닫기 버튼과 직접적인 바인딩 변경은 가능합니다.
  ///   - content: 일반적으로 `FoundesignBottomSheetContainer`로 구성할 콘텐츠입니다.
  public func bottomSheet<SheetContent: View>(
    isPresented: Binding<Bool>,
    snapPoints: [FoundesignBottomSheetSnapPoint] = [],
    isDismissible: Bool = true,
    @ViewBuilder content: @escaping () -> SheetContent
  ) -> some View {
    background {
      FoundesignBottomSheetPresenter(isPresented: isPresented) { presentation in
        FoundesignBottomSheetStage(
          isPresented: isPresented,
          presentation: presentation,
          snapPoints: snapPoints,
          isDismissible: isDismissible,
          content: content()
        )
        .onAppear { presentation.didAppear() }
      }
      .frame(width: 0, height: 0)
    }
  }
}

private struct FoundesignBottomSheetStage<Content: View>: View {
  @Environment(\.theme) private var theme
  @Environment(\.bottomSheetShowsHandle) private var showsHandle
  @Binding var isPresented: Bool
  let presentation: FoundesignBottomSheetPresentation
  let snapPoints: [FoundesignBottomSheetSnapPoint]
  let isDismissible: Bool
  let content: Content
  @State private var selectedHeight: CGFloat?
  // 손을 놓거나 제스처가 취소되면 스냅 전환과 같은 속도로 원래 위치에 복귀합니다.
  @GestureState(resetTransaction: Transaction(animation: .easeOut(duration: 0.25)))
  private var drag: CGFloat = 0

  var body: some View {
    GeometryReader { proxy in
      let totalHeight = proxy.size.height + proxy.safeAreaInsets.bottom
      let maximum = max(0, min(totalHeight * 0.9, proxy.size.height))
      let heights = Array(
        Set(
          snapPoints.compactMap {
            $0.resolved(in: totalHeight, maximum: maximum)
          })
      ).sorted()
      let height = heights.isEmpty ? nil : min(selectedHeight ?? heights[0], maximum)

      ZStack(alignment: .bottom) {
        theme.color.background.overlay
          .opacity(presentation.isVisible ? 1 : 0)
          .ignoresSafeArea()
          .contentShape(.rect)
          .onTapGesture {
            if isDismissible { isPresented = false }
          }
        ViewThatFits(in: .vertical) {
          if heights.isEmpty {
            card(heights: heights, height: height, bottomInset: proxy.safeAreaInsets.bottom)
              .fixedSize(horizontal: false, vertical: true)
          }
          card(heights: heights, height: height, bottomInset: proxy.safeAreaInsets.bottom)
        }
        .frame(maxWidth: 480)
        .frame(height: height.map { max(0, min(maximum, $0 - drag)) })
        .frame(maxHeight: maximum, alignment: .bottom)
        .offset(
          y: presentation.isVisible
            ? (heights.isEmpty && isDismissible ? max(0, drag) : 0) : totalHeight
        )
        .padding(.bottom, -proxy.safeAreaInsets.bottom)
        .onChange(of: heights) { _, newValue in
          selectedHeight = newValue.min(by: {
            abs($0 - (selectedHeight ?? 0)) < abs($1 - (selectedHeight ?? 0))
          })
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
  }

  private func card(heights: [CGFloat], height: CGFloat?, bottomInset: CGFloat) -> some View {
    VStack(spacing: theme.spacing.zero) {
      if showsHandle || !heights.isEmpty {
        // 44pt의 드래그 영역에 36×4pt 핸들을 배치합니다.
        Capsule()
          .fill(drag == 0 ? theme.color.foreground.tertiary : theme.color.foreground.secondary)
          .frame(width: 36, height: 4)
          .frame(maxWidth: .infinity)
          .frame(height: 44)
          .contentShape(.rect)
          .gesture(handleDrag(heights: heights, height: height))
      }
      content
        .environment(\.bottomSheetIsPresented, $isPresented)
    }
    .padding(.bottom, bottomInset)
    .frame(maxWidth: .infinity)
    .frame(height: height.map { max(0, $0 - drag) }, alignment: .top)
    .background(theme.color.background.base)
    .clipShape(.rect(topLeadingRadius: theme.radius.xLarge, topTrailingRadius: theme.radius.xLarge))
  }

  private func handleDrag(heights: [CGFloat], height: CGFloat?) -> some Gesture {
    // 핸들 자체가 이동하므로 로컬 좌표를 쓰면 이동량 계산에 시트의 이동이 되먹임됩니다.
    DragGesture(coordinateSpace: .global)
      .updating($drag) { value, state, transaction in
        // 드래그 중에는 손가락 위치를 그대로 따라가고, 종료 시에만 애니메이션을 적용합니다.
        transaction.animation = nil
        let translation = value.translation.height
        if let height, let maximum = heights.last {
          let downwardLimit = isDismissible ? height : max(0, height - (heights.first ?? height))
          state = max(height - maximum, min(translation, downwardLimit))
        } else if isDismissible {
          state = max(0, translation)
        }
      }
      .onEnded { value in
        handleDragEnded(value, heights: heights, height: height)
      }
  }

  private func handleDragEnded(_ value: DragGesture.Value, heights: [CGFloat], height: CGFloat?) {
    // 80pt 이상 아래로 던지면 내용 맞춤 시트를 닫고, 스냅 시트는 최소 높이의 절반을 기준으로 합니다.
    let translation = value.predictedEndTranslation.height
    withAnimation(.easeOut(duration: 0.25)) {
      if let height, let minimum = heights.first {
        let proposed = height - translation
        if isDismissible && proposed < minimum / 2 {
          isPresented = false
        } else {
          selectedHeight = heights.min(by: { abs($0 - proposed) < abs($1 - proposed) })
        }
      } else if isDismissible && translation > 80 {
        isPresented = false
      }
    }
  }
}
