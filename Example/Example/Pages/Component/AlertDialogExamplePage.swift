import Foundesign
import SwiftUI

struct AlertDialogExamplePage: View {
  @Environment(\.theme) private var theme
  @State private var showsSingle = false
  @State private var showsDouble = false
  @State private var showsLong = false
  @State private var showsLongSingle = false
  @State private var showsCustom = false
  @State private var showsDisabled = false
  @State private var showsSheet = false
  @State private var actionCount = 0
  @State private var dismissCount = 0
  @State private var transitionTask: Task<Void, Never>?

  var body: some View {
    List {
      Section("Environment Overrides") {
        FoundesignAlertDialogContainer(
          title: "상속과 개별 설정",
          description: "첫 버튼은 Small · Brand를 상속하고, 두 번째는 Neutral · Outline으로 바꿉니다."
        ) {
          FoundesignAlertDialogButtonItem(label: "상위 속성 상속") { actionCount += 1 }
          FoundesignAlertDialogButtonItem(label: "Neutral · Outline으로 변경") { actionCount += 1 }
            .buttonTone(.neutral)
            .buttonStyle(.outline)
        }
        .buttonProperty(.init(tone: .brand, size: .small))
      }
      alertDialogSection
      descriptionSection
    }
    .navigationTitle("AlertDialog")
    .alertDialog(
      isPresented: $showsSingle,
      title: "확인",
      description: "Primary 버튼 하나를 표시합니다.",
      onDismiss: {
        dismissCount += 1
      }
    ) {
      primaryButton(.brand)
    }
    .alertDialog(
      isPresented: $showsDouble,
      title: "삭제할까요?",
      description: "삭제한 항목은 복구할 수 없습니다.",
      onDismiss: { dismissCount += 1 }
    ) {
      primaryButton(.critical, label: "삭제")
      secondaryButton()
    }
    .alertDialog(
      isPresented: $showsLong,
      title: "긴 내용",
      description: longDescription,
      onDismiss: { dismissCount += 1 }
    ) {
      primaryButton(.brand, label: "이 내용을 확인했습니다")
      secondaryButton()
    }
    .alertDialog(
      isPresented: $showsLongSingle,
      onDismiss: {
        dismissCount += 1
      }
    ) {
      FoundesignAlertDialogContainer(
        title: "긴 내용 · 버튼 하나",
        description: longDescription
      ) {
        primaryButton()
      }
    }
    .alertDialog(
      isPresented: $showsCustom,
      onDismiss: {
        dismissCount += 1
      }
    ) {
      FoundesignAlertDialogContainer(
        header: {
          Label("커스텀 헤더", systemImage: "info.circle")
        },
        content: {
          Text("기존 FoundesignAlertDialogContainer를 직접 전달할 수도 있습니다.")
        }
      ) {
        primaryButton()
        secondaryButton()
      }
    }
    .alertDialog(
      isPresented: $showsDisabled,
      title: "비활성 버튼",
      description: "비활성 Primary는 액션을 실행하거나 다이얼로그를 닫지 않습니다.",
      onDismiss: {
        dismissCount += 1
      }
    ) {
      primaryButton(.brand)
        .disabled(true)
      
      secondaryButton()
    }
    .sheet(isPresented: $showsSheet) {
      AlertDialogSheetExample()
    }
    .onDisappear { transitionTask?.cancel() }
  }

  private var alertDialogSection: some View {
    Section("AlertDialog") {
      Button("Primary 하나") {
        showsSingle = true
      }
      Button("Primary · Secondary") {
        showsDouble = true
      }
      Button("긴 내용 · Footer 고정 · 두 버튼") {
        showsLong = true
      }
      Button("긴 내용 · Footer 고정 · 버튼 하나") {
        showsLongSingle = true
      }
      Button("Container 직접 전달 · 두 버튼") {
        showsCustom = true
      }
      Button("비활성 Primary") {
        showsDisabled = true
      }
      Button("Sheet 내부에서 표시") {
        showsSheet = true
      }
      Button("등장 중 해제") {
        dismissDuringEntranceTapped()
      }
      Button("해제 중 다시 표시") {
        reopenDuringDismissalTapped()
      }
    }
  }

  private var descriptionSection: some View {
    Section("호출 횟수") {
      Text("액션: \(actionCount)")
      Text("닫힘 완료: \(dismissCount)")
      Button("횟수 초기화") {
        resetCountsTapped()
      }
    }
  }

  private func primaryButton(
    _ tone: FoundesignButtonProperty.Tone = .neutral,
    label: String = "확인"
  ) -> some View {
    FoundesignAlertDialogButtonItem(label: label) {
      actionCount += 1
    }
    .buttonTone(tone)
  }

  private func secondaryButton(
    _ tone: FoundesignButtonProperty.Tone = .neutral,
    label: String = "닫기"
  ) -> some View {
    FoundesignAlertDialogButtonItem(label: label) {
      actionCount += 1
    }
    .buttonTone(tone)
  }

  private func dismissDuringEntranceTapped() {
    transitionTask?.cancel()
    showsSingle = true
    transitionTask = Task {
      do {
        try await Task.sleep(for: .milliseconds(100))
      } catch {
        return
      }
      showsSingle = false
    }
  }

  private func reopenDuringDismissalTapped() {
    transitionTask?.cancel()
    showsSingle = true
    transitionTask = Task {
      do {
        try await Task.sleep(for: .milliseconds(600))
        showsSingle = false
        try await Task.sleep(for: .milliseconds(50))
        showsSingle = true
      } catch {
        return
      }
    }
  }

  private func resetCountsTapped() {
    actionCount = 0
    dismissCount = 0
  }

  private var longDescription: String {
    (1...30).map { index in
      "\(index). 이 영역을 스크롤해도 하단 버튼은 고정되어 있습니다. 큰 글자에서도 버튼을 바로 누를 수 있습니다."
    }.joined(separator: "\n\n")
  }
}

private struct AlertDialogSheetExample: View {
  @Environment(\.theme) private var theme
  @Environment(\.dismiss) private var dismiss
  @State private var showsDialog = false

  var body: some View {
    VStack(spacing: 24) {
      Text("Sheet 내부")
      Button("AlertDialog 표시") {
        showsDialog = true
      }
      Button("Sheet 닫기") {
        dismiss()
      }
    }
    .padding(theme.spacing.xxLarge)
    .alertDialog(
      isPresented: $showsDialog,
      title: "Sheet에서 표시",
      description: "현재 프레젠테이션의 위에 다이얼로그를 표시합니다."
    ) {
      FoundesignAlertDialogButtonItem(
        label: "확인"
      ) {}
      .buttonTone(.brand)
    }
  }
}
