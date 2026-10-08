import Foundesign
import SwiftUI

struct SwitchExamplePage: View {
  @Environment(\.theme) private var theme

  @State private var notifications = false
  @State private var automaticUpdates = true
  @State private var isDisabled = true
  @State private var disabledOff = false
  @State private var disabledOn = true
  @State private var usesCustomTheme = false

  var body: some View {
    List {
      Section("Basic") {
        FoundesignSwitch(title: "푸시 알림", isOn: $notifications)
        Text("알림: \(notifications ? "켜짐" : "꺼짐")")
        Button("외부에서 알림 전환") { notifications.toggle() }
      }

      Section("Size & Tone") {
        ForEach(FoundesignSwitchProperty.Tone.allCases, id: \.self) { tone in
          VStack(spacing: theme.spacing.medium) {
            ForEach(FoundesignSwitchProperty.Size.allCases, id: \.self) { size in
              FoundesignSwitch(
                title: "\(tone.description) · \(size.description)",
                isOn: $notifications
              )
              .switchProperty(.init(size: size, tone: tone))
            }
          }
        }
      }

      Section("Custom Label") {
        FoundesignSwitch(isOn: $automaticUpdates) {
          VStack(alignment: .leading, spacing: theme.spacing.xSmall) {
            FoundesignSwitchLabel(title: "자동 업데이트")
            Text("Wi-Fi에 연결되면 새 버전을 자동으로 다운로드합니다.")
              .typography(theme.typography.body.small)
          }
        }
        Text("자동 업데이트: \(automaticUpdates ? "켜짐" : "꺼짐")")
      }

      Section("Long Label") {
        FoundesignSwitch(
          title: "새로운 소식과 서비스 업데이트를 알림으로 받아 바로 확인합니다.",
          isOn: $notifications
        )
        .switchSize(.small)
        .frame(maxWidth: 220, alignment: .leading)
      }

      Section("Disabled") {
        Toggle("아래 항목 비활성화", isOn: $isDisabled)
        VStack(spacing: theme.spacing.medium) {
          FoundesignSwitch(title: "처음에 꺼진 항목", isOn: $disabledOff)
          FoundesignSwitch(title: "처음에 켜진 항목", isOn: $disabledOn)
        }
        .disabled(isDisabled)
        Text("현재 값: \(disabledOff ? "켜짐" : "꺼짐") / \(disabledOn ? "켜짐" : "꺼짐")")
      }

      Section("Environment Overrides") {
        VStack(spacing: theme.spacing.medium) {
          FoundesignSwitch(title: "상속: Large · Brand", isOn: $notifications)
          FoundesignSwitch(
            title: "크기만 변경: Small · Brand",
            isOn: $notifications
          )
          .switchSize(.small)
          FoundesignSwitch(title: "전체 교체: Medium · Neutral", isOn: $notifications)
            .switchProperty(.init())
        }
        .switchProperty(.init(size: .large, tone: .brand))
      }

      Section("Switchmark Composition") {
        Button {
          automaticUpdates.toggle()
        } label: {
          HStack(spacing: theme.spacing.small) {
            FoundesignSwitchLabel(title: "자동 업데이트")
            Spacer()
            FoundesignSwitchmark(isOn: automaticUpdates)
          }
          .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .switchTone(.brand)
      }

      Section("Theme") {
        Toggle("커스텀 테마 적용", isOn: $usesCustomTheme)
        themePreview(.light)
        themePreview(.dark)
      }
    }
    .navigationTitle("Switch")
  }

  private func themePreview(_ colorScheme: ColorScheme) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(colorScheme == .light ? "Light" : "Dark")
        .foregroundStyle(theme.color.foreground.primary)
      FoundesignSwitch(title: "알림 받기", isOn: $notifications)
      FoundesignSwitch(title: "자동 업데이트", isOn: $automaticUpdates)
        .switchTone(.brand)
    }
    .padding(theme.spacing.medium)
    .background(theme.color.background.base, in: .rect(cornerRadius: theme.radius.medium))
    .environment(\.theme, usesCustomTheme ? customTheme : theme)
    .environment(\.colorScheme, colorScheme)
  }

  private var customTheme: FoundesignTheme {
    var custom = theme
    custom.spacing.small *= 1.5
    custom.spacing.medium *= 1.5
    custom.spacing.xLarge *= 1.5
    custom.typography.body.medium = theme.typography.body.large
    custom.color.background.brand = theme.color.background.positive
    custom.color.foreground.brand = theme.color.foreground.positive
    return custom
  }
}
