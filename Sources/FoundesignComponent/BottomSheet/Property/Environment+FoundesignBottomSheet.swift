import SwiftUI

extension EnvironmentValues {
  @Entry var bottomSheetHeaderAlignment: HorizontalAlignment = .leading
  @Entry var bottomSheetShowsHandle = true
  @Entry var bottomSheetShowsCloseButton = false
  @Entry var bottomSheetIsPresented: Binding<Bool>? = nil
}

extension View {
  /// 바텀 시트 제목과 설명의 정렬을 설정합니다. 기본값은 `.leading`입니다.
  /// - Parameter alignment: `.center`이면 가운데, 그 밖의 값이면 선행 가장자리로 정렬합니다.
  public func bottomSheetHeaderAlignment(_ alignment: HorizontalAlignment) -> some View {
    environment(\.bottomSheetHeaderAlignment, alignment)
  }

  /// 바텀 시트의 드래그 핸들을 표시합니다. 기본값은 `true`입니다.
  /// 스냅 포인트가 있으면 이 설정과 관계없이 핸들을 표시합니다.
  /// 핸들을 숨기면 드래그할 영역도 사라집니다. 바깥 클릭 닫기는 별도로 설정합니다.
  public func bottomSheetShowsHandle(_ showsHandle: Bool) -> some View {
    environment(\.bottomSheetShowsHandle, showsHandle)
  }

  /// 컨테이너의 닫기 버튼을 표시합니다. 기본값은 `false`입니다.
  /// `bottomSheet` 표시 영역 안에서 사용하면 표시 바인딩을 `false`로 바꿉니다.
  public func bottomSheetShowsCloseButton(_ showsCloseButton: Bool) -> some View {
    environment(\.bottomSheetShowsCloseButton, showsCloseButton)
  }
}
