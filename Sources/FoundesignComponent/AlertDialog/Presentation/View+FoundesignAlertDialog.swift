import SwiftUI

extension View {
  /// 다이얼로그를 표시합니다.
  ///
  /// ``FoundesignAlertDialogButtonItem``을 누르면 닫힘을 요청한 뒤 버튼 액션을 실행합니다.
  /// `onDismiss`는 닫힘 전환이 끝난 뒤 호출됩니다.
  /// 배경 클릭은 닫지 않고, Escape는 버튼 액션 없이 닫습니다.
  ///
  /// - Parameters:
  ///   - isPresented: 표시 여부입니다. 닫힘 요청 시 `false`로 변경됩니다.
  ///   - onDismiss: 닫힘 전환을 완료했을 때 호출할 선택적 클로저입니다.
  ///   - content: 표시할 다이얼로그 콘텐츠입니다.
  /// - Returns: 다이얼로그 표시 기능이 연결된 뷰입니다.
  public func alertDialog<DialogContent: View>(
    isPresented: Binding<Bool>,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> DialogContent
  ) -> some View {
    background {
      FoundesignAlertDialogPresenter(
        isPresented: isPresented,
        onDismiss: onDismiss,
        content: content
      )
      .frame(width: 0, height: 0)
      .accessibilityHidden(true)
    }
  }

  /// 제목, 설명과 primary 하나 또는 primary, secondary 버튼으로 다이얼로그를 표시합니다.
  ///
  /// ``FoundesignAlertDialogButtonItem``을 누르면 닫힘을 요청한 뒤 버튼 액션을 실행합니다.
  /// 배경 클릭은 닫지 않고 Escape는 버튼 액션 없이 닫습니다. 사용 예제는 <doc:AlertDialog>를 참고하세요.
  ///
  /// - Parameters:
  ///   - isPresented: 표시 여부입니다. 닫힘 요청 시 `false`로 변경됩니다.
  ///   - title: 다이얼로그 제목입니다.
  ///   - description: 본문 설명입니다.
  ///   - onDismiss: 닫힘 전환 완료 후 호출할 선택적 클로저입니다.
  ///   - actions: primary 하나 또는 primary·secondary 순서의 버튼 두 개입니다.
  /// - Returns: 다이얼로그 표시 기능이 연결된 뷰입니다.
  public func alertDialog<Actions: View>(
    isPresented: Binding<Bool>,
    title: String,
    description: String,
    onDismiss: (() -> Void)? = nil,
    @FoundesignAlertDialogFooterBuilder actions: @escaping () -> Actions
  ) -> some View {
    alertDialog(isPresented: isPresented, onDismiss: onDismiss) {
      FoundesignAlertDialogContainer(
        title: title,
        description: description,
        footer: actions
      )
    }
  }
}
