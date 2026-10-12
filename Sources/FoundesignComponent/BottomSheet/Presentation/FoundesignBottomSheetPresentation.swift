import SwiftUI

/// 플랫폼 표시 수명과 SwiftUI 등장·퇴장 전환을 연결합니다.
@MainActor
@Observable
final class FoundesignBottomSheetPresentation {
  private(set) var isVisible = false
  @ObservationIgnored private let present: () -> Bool
  @ObservationIgnored private let remove: (@escaping () -> Void) -> Void

  @ObservationIgnored lazy var lifecycle = FoundesignModalPresentation(
    present: { [weak self] in self?.present() ?? false },
    dismiss: { [weak self] in self?.dismiss() }
  )

  init(present: @escaping () -> Bool, remove: @escaping (@escaping () -> Void) -> Void) {
    self.present = present
    self.remove = remove
  }

  func didAppear() {
    guard lifecycle.phase == .presenting, !isVisible else { return }
    // 실제 호스트가 배치된 뒤 상태를 바꿔 첫 프레임부터 이동 전환을 적용합니다.
    DispatchQueue.main.async { [weak self] in
      guard let self, self.lifecycle.phase == .presenting, !self.isVisible else { return }
      withAnimation(.easeOut(duration: 0.25), completionCriteria: .logicallyComplete) {
        self.isVisible = true
      } completion: {
        self.lifecycle.presentationDidFinish()
      }
    }
  }

  private func dismiss() {
    withAnimation(.easeOut(duration: 0.25), completionCriteria: .logicallyComplete) {
      isVisible = false
    } completion: {
      self.remove { self.lifecycle.dismissalDidFinish() }
    }
  }
}
