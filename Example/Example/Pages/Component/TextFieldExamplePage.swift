import Foundesign
import SwiftUI

struct TextFieldExamplePage: View {
  @Environment(\.theme) private var theme
  @FocusState private var isNameFocused: Bool

  @State private var name = ""
  @State private var query = ""
  @State private var amount = "12000"
  @State private var note = ""
  @State private var size = FoundesignTextFieldProperty.Size.large
  @State private var style = FoundesignTextFieldProperty.Style.outline
  @State private var weight = FoundesignTextFieldProperty.Weight.medium
  @State private var isReadOnly = false
  @State private var isDisabled = false
  @State private var hasSubmitted = false
  @State private var usesCustomTheme = false
  @State private var usesDarkMode = false
  @State private var actionResult = ""

  var body: some View {
    List {
      Section("Appearance") {
        Picker("Style", selection: $style) {
          ForEach(FoundesignTextFieldProperty.Style.allCases, id: \.self) { value in
            Text(value.description).tag(value)
          }
        }
        Picker("Size", selection: $size) {
          ForEach(FoundesignTextFieldProperty.Size.allCases, id: \.self) { value in
            Text(value.description).tag(value)
          }
        }
        Picker("Label Weight", selection: $weight) {
          ForEach(FoundesignTextFieldProperty.Weight.allCases, id: \.self) { value in
            Text(value.description).tag(value)
          }
        }
        Toggle("읽기 전용", isOn: $isReadOnly)
        Toggle("비활성화", isOn: $isDisabled)
        Toggle("커스텀 테마", isOn: $usesCustomTheme)
        Toggle("어두운 모드", isOn: $usesDarkMode)
      }

      Section("Validation") {
        FoundesignTextField(
          title: "닉네임",
          text: $name,
          placeholder: "닉네임을 입력해 주세요"
        )
        .helperText("10자 이내로 입력해 주세요")
        .errorMessage(nameError)
        .requirement(.required)
        .maximumLength(10)
        .textFieldFocused($isNameFocused)
        .onSubmit { submitButtonTapped() }
        .disabled(isDisabled)

        HStack {
          Button("입력 포커스") { isNameFocused = true }
            .disabled(isDisabled || isReadOnly)
          Button("제출", action: submitButtonTapped)
            .disabled(isDisabled || isReadOnly)
        }
        Text("입력값: \(name.isEmpty ? "(비어 있음)" : name)")
        Text("포커스: \(isNameFocused ? "입력 중" : "해제")")
        if !actionResult.isEmpty {
          Text(actionResult)
        }
      }

      Section("Slots") {
        FoundesignTextField(
          title: "판매 가격",
          text: $amount,
          placeholder: "가격 입력"
        ) {
          Button("초기화") { amount = "" }
            .disabled(isReadOnly)
        } leading: {
          Image(systemName: "wonsign")
        } trailing: {
          Text("원")
        }
        .helperText("접두사·접미사와 레이블 옆 액션을 조합합니다")
        .disabled(isDisabled)
      }

      Section("Without Label") {
        FoundesignTextField(
          title: "",
          text: $query,
          placeholder: "검색어 입력",
          leading: { Image(systemName: "magnifyingglass") }
        )
      }

      Section("Narrow Width · Long Text") {
        FoundesignTextField(
          title: "배송 시 요청할 내용을 입력하는 긴 레이블",
          text: $note,
          placeholder: "요청 사항"
        )
        .helperText("도움말이 여러 줄로 표시되어도 글자 수와 겹치지 않아야 합니다.")
        .requirement(.optional("선택"))
        .maximumLength(20)
        .frame(maxWidth: 260)
      }

      Section("Environment Overrides") {
        VStack(spacing: theme.spacing.large) {
          FoundesignTextField(title: "상위 스타일 상속", text: $query, placeholder: "검색어 입력")
            .helperText("상위에서 설정한 크기·스타일·굵기를 상속합니다")
          FoundesignTextField(title: "개별 크기 변경", text: $note, placeholder: "요청 사항")
            .helperText("크기만 Medium으로 변경하고 스타일·굵기는 상속합니다")
            .textFieldSize(.medium)
            .textFieldReadOnly(false)
            .textFieldClearButton(false)
        }
        .textFieldReadOnly(isReadOnly)
      }

      Section("Read Only · Disabled") {
        FoundesignTextField(title: "읽기 전용", text: .constant("선택하고 복사할 수 있습니다"))
          .textFieldReadOnly(true)
        FoundesignTextField(title: "비활성 값", text: .constant("수정할 수 없습니다"))
          .disabled(true)
        FoundesignTextField(title: "비활성 빈 값", text: .constant(""), placeholder: "입력할 수 없습니다")
          .disabled(true)
      }
      .textFieldProperty(.init())
    }
    .textFieldSize(size)
    .textFieldStyle(style)
    .textFieldWeight(weight)
    .textFieldReadOnly(isReadOnly)
    .textFieldClearButton(true)
    .environment(\.theme, usesCustomTheme ? customTheme : theme)
    .preferredColorScheme(usesDarkMode ? .dark : .light)
    .navigationTitle("Text Field")
  }

  private var nameError: String? {
    guard hasSubmitted else { return nil }
    if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      return "닉네임을 입력해 주세요"
    }
    return name.count > 10 ? "닉네임을 10자 이내로 줄여 주세요" : nil
  }

  private var customTheme: FoundesignTheme {
    var custom = theme
    custom.spacing.small *= 1.5
    custom.spacing.medium *= 1.5
    custom.spacing.large *= 1.5
    custom.radius.large = theme.radius.small
    custom.typography.body.large = theme.typography.title.small
    custom.color.border.focus = theme.color.border.brand.solid
    return custom
  }

  private func submitButtonTapped() {
    hasSubmitted = true
    isNameFocused = nameError != nil
    actionResult = nameError == nil ? "제출값: \(name)" : "입력 내용을 확인해 주세요"
  }
}
