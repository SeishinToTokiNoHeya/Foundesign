import Foundesign
import SwiftUI

struct CheckboxExamplePage: View {
  @Environment(\.theme) private var theme

  @State private var isSelected = false
  @State private var terms = true
  @State private var privacy = false
  @State private var marketing = false
  @State private var overseasTransfer = true
  @State private var messaging = false
  @State private var usesCustomTheme = false

  var body: some View {
    List {
      ForEach(FoundesignCheckboxProperty.Shape.allCases, id: \.self) { shape in
        Section(shape.description) {
          ForEach(FoundesignCheckboxProperty.Tone.allCases, id: \.self) { tone in
            variants(shape: shape, tone: tone)
          }
        }
      }

      Section("Group") {
        FoundesignCheckboxGroup {
          FoundesignCheckbox(title: "이용약관 동의", isOn: $terms)
          FoundesignCheckbox(title: "개인정보 처리방침 동의", isOn: $privacy)
          FoundesignCheckbox(title: "마케팅 정보 수신 동의 (선택)", isOn: $marketing)
        } header: {
          FoundesignCheckbox(title: "전체 동의", sources: [$terms, $privacy, $marketing])
        }
        .checkboxTone(.brand)
      }

      Section("Nested Group") {
        FoundesignCheckboxGroup {
          FoundesignCheckbox(title: "(필수) 개인정보 제3자 제공 동의", isOn: $terms)
          FoundesignCheckbox(title: "(필수) 만 14세 이상입니다.", isOn: $privacy)

          FoundesignCheckboxGroup {
            FoundesignCheckbox(title: "(선택) 국외 정보 이전 동의", isOn: $overseasTransfer)
            FoundesignCheckbox(title: "(선택) 광고 메시지를 메신저로 받기", isOn: $messaging)
          } header: {
            FoundesignCheckbox(title: "(선택) 마케팅 활용 및 광고성 정보 수신 동의", isOn: $marketing)
              .checkboxWeight(.regular)
          }
        }
      }

      Section("Custom Label") {
        FoundesignCheckbox(isOn: $isSelected) {
          VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            FoundesignCheckLabel(title: "알림 받기")
              .checkboxWeight(.bold)

            Text("여러 줄로 표시되는 설명과 함께 사용해도 행 전체를 눌러 선택할 수 있습니다.")
              .typography(theme.typography.body.small)
              .foregroundStyle(theme.color.foreground.secondary)
          }
        }
        .checkboxShape(.ghost)
      }

      Section("Items") {
        ForEach(FoundesignCheckboxState.allCases, id: \.self) { state in
          HStack(spacing: theme.spacing.small) {
            FoundesignCheckmark(state: state)
            FoundesignCheckLabel(title: state.description)
          }
        }
      }

      Section("Disabled Group") {
        FoundesignCheckboxGroup {
          FoundesignCheckbox(title: "선택할 수 없는 항목", isOn: .constant(false))
          FoundesignCheckbox(title: "이미 선택된 항목", isOn: .constant(true))
          FoundesignCheckbox(title: "일부 선택된 항목", sources: [.constant(true), .constant(false)])
        }
        .disabled(true)
      }

      Section("Theme") {
        Toggle("커스텀 테마 적용", isOn: $usesCustomTheme)

        ForEach(FoundesignCheckboxProperty.Size.allCases, id: \.self) { size in
          FoundesignCheckboxGroup {
            FoundesignCheckbox(title: "Outlined", isOn: $terms)
            FoundesignCheckbox(title: "Ghost", isOn: $privacy)
              .checkboxShape(.ghost)
          } header: {
            FoundesignCheckbox(title: size.description, sources: [$terms, $privacy])
          }
          .checkboxSize(size)
          .checkboxTone(.brand)
          .environment(\.theme, usesCustomTheme ? customTheme : theme)
        }
      }

      Section("Dynamic Type") {
        FoundesignCheckboxGroup {
          FoundesignCheckbox(title: "Outlined", isOn: $terms)
          FoundesignCheckbox(title: "Ghost", isOn: $privacy)
            .checkboxShape(.ghost)
        } header: {
          FoundesignCheckbox(title: "큰 텍스트", sources: [$terms, $privacy])
        }
        .dynamicTypeSize(.accessibility1)
      }
    }
    .navigationTitle("Checkbox")
  }

  private var customTheme: FoundesignTheme {
    var custom = theme
    custom.spacing.xSmall *= 1.5
    custom.spacing.small *= 1.5
    custom.spacing.medium *= 1.5
    custom.spacing.large *= 1.5
    custom.spacing.xLarge *= 1.5
    custom.spacing.xxLarge *= 1.5
    custom.radius.small = theme.radius.medium
    custom.typography.body.medium = theme.typography.body.large
    custom.typography.body.large = theme.typography.title.small
    return custom
  }

  private func variants(
    shape: FoundesignCheckboxProperty.Shape,
    tone: FoundesignCheckboxProperty.Tone
  ) -> some View {
    FoundesignCheckboxGroup {
      Text(tone.description)
        .typography(theme.typography.title.small)
        .foregroundStyle(theme.color.foreground.primary)

      ForEach(FoundesignCheckboxProperty.Size.allCases, id: \.self) { size in
        ForEach(FoundesignCheckboxProperty.Weight.allCases, id: \.self) { weight in
          FoundesignCheckbox(
            title: "\(size.description) · \(weight.description)",
            isOn: $isSelected
          )
          .checkboxSize(size)
          .checkboxWeight(weight)
        }
      }

      FoundesignCheckbox(title: "Selected", isOn: .constant(true))
      FoundesignCheckbox(title: "Indeterminate", sources: [.constant(true), .constant(false)])
      FoundesignCheckbox(title: "Disabled", isOn: .constant(false))
        .disabled(true)
      FoundesignCheckbox(title: "Selected · Disabled", isOn: .constant(true))
        .disabled(true)
      FoundesignCheckbox(title: "Indeterminate · Disabled", sources: [.constant(true), .constant(false)])
        .disabled(true)
    }
    .checkboxShape(shape)
    .checkboxTone(tone)
  }
}
