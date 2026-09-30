import SwiftUI

extension View {
  /// 다이얼로그를 표시합니다.
  ///
  /// AlertDialogButtonItem을 누르면 자동으로 닫히며, onDismiss는 닫힘 전환이 끝난 뒤 호출됩니다.
  /// 배경 클릭은 닫지 않고, Escape는 버튼 액션 없이 닫습니다.
  public func alertDialog<DialogContent: View>(
    isPresented: Binding<Bool>,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> DialogContent
  ) -> some View {
    background {
      AlertDialogPresenter(
        isPresented: isPresented,
        onDismiss: onDismiss,
        content: content
      )
      .frame(width: 0, height: 0)
      .accessibilityHidden(true)
    }
  }

  /// 제목, 설명과 primary 하나 또는 primary, secondary 버튼으로 다이얼로그를 표시합니다.
  public func alertDialog<Actions: View>(
    isPresented: Binding<Bool>,
    title: String,
    description: String,
    onDismiss: (() -> Void)? = nil,
    @AlertDialogFooterBuilder actions: @escaping () -> Actions
  ) -> some View {
    alertDialog(isPresented: isPresented, onDismiss: onDismiss) {
      AlertDialogContainer(
        title: title,
        description: description,
        footer: actions
      )
    }
  }
}
