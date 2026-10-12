import Foundesign
import SwiftUI

struct BottomSheetExamplePage: View {
  var body: some View {
    TabView {
      BottomSheetExampleStage()
        .tabItem { Label("바텀 시트", systemImage: "rectangle.bottomhalf.inset.filled") }
      Text("바텀 시트가 열리면 이 탭으로 전환할 수 없습니다.")
        .tabItem { Label("다른 탭", systemImage: "square.grid.2x2") }
    }
    .navigationTitle("Bottom Sheet")
  }
}

private struct BottomSheetExampleStage: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.theme) private var theme
  @State private var isPresented = false
  @State private var showsSystemSheet = false
  @State private var transitionTask: Task<Void, Never>?
  @State private var usesSnapPoints = false
  @State private var showsHandle = true
  @State private var showsCloseButton = true
  @State private var centered = false
  @State private var longContent = false
  @State private var isDismissible = true
  @State private var name = ""
  @State private var result = "아직 선택하지 않았습니다."

  var body: some View {
    VStack {
      Form {
        Section("표시 옵션") {
          Toggle("스냅 높이 50% · 90%", isOn: $usesSnapPoints)
          Toggle("핸들", isOn: $showsHandle)
          Toggle("닫기 버튼", isOn: $showsCloseButton)
          Toggle("가운데 헤더", isOn: $centered)
          Toggle("긴 본문", isOn: $longContent)
          Toggle("바깥 클릭 · 드래그 닫기", isOn: $isDismissible)
        }
        Section {
          Button("바텀 시트 표시") { isPresented = true }
          Text(result)
          Button("시스템 시트 안에서 표시") { showsSystemSheet = true }
          Button("등장 중 닫기 · 다시 열기") { reopenDuringTransitionTapped() }
          Button("예제 닫기") { dismiss() }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .bottomSheet(
      isPresented: $isPresented,
      snapPoints: usesSnapPoints ? [.fraction(0.5), .fraction(0.9)] : [],
      isDismissible: isDismissible
    ) {
      FoundesignBottomSheetContainer(
        title: "어떻게 불러드릴까요?",
        description: "이름을 입력하고 아래 버튼으로 저장하세요."
      ) {
        VStack(alignment: .leading, spacing: theme.spacing.large) {
          TextField("이름", text: $name)
            .textFieldStyle(.roundedBorder)
          if longContent {
            ForEach(1...20, id: \.self) { index in
              Text("\(index). 본문만 스크롤되고 제목과 하단 버튼은 고정됩니다.")
                .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
        }
      } footer: {
        FoundesignAdaptiveButtonGroup {
          Button {
            saveTapped()
          } label: {
            Text("저장").frame(maxWidth: .infinity)
          }
          .buttonStyle(.solid)
          .buttonTone(.brand)
        } secondary: {
          Button {
            isPresented = false
          } label: {
            Text("취소").frame(maxWidth: .infinity)
          }
          .buttonStyle(.outline)
        }
      }
    }
    .sheet(isPresented: $showsSystemSheet) {
      BottomSheetNestedExample()
        .frame(minWidth: 320, minHeight: 400)
    }
    .onDisappear { transitionTask?.cancel() }
    .bottomSheetShowsHandle(showsHandle)
    .bottomSheetShowsCloseButton(showsCloseButton)
    .bottomSheetHeaderAlignment(centered ? .center : .leading)
  }

  private func reopenDuringTransitionTapped() {
    transitionTask?.cancel()
    isPresented = true
    transitionTask = Task {
      do {
        try await Task.sleep(for: .milliseconds(100))
        isPresented = false
        try await Task.sleep(for: .milliseconds(250))
        isPresented = true
      } catch {}
    }
  }

  private func saveTapped() {
    result = name.isEmpty ? "빈 이름으로 저장했습니다." : "\(name)님으로 저장했습니다."
    isPresented = false
  }
}

private struct BottomSheetNestedExample: View {
  @Environment(\.dismiss) private var dismiss
  @State private var isPresented = false

  var body: some View {
    VStack(spacing: 24) {
      Button("이 시트 위에 바텀 시트 표시") { isPresented = true }
      Button("시스템 시트 닫기") { dismiss() }
    }
    .bottomSheet(isPresented: $isPresented) {
      FoundesignBottomSheetContainer(title: "현재 window 위") {
        Text("시스템 시트 위에도 표시됩니다.")
      } footer: {
        Button("닫기") { isPresented = false }
          .buttonStyle(.solid)
      }
    }
    .bottomSheetShowsCloseButton(true)
  }
}
