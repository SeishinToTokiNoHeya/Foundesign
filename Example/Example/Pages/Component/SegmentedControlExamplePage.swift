import Foundesign
import SwiftUI

struct SegmentedControlExamplePage: View {
  @Environment(\.theme) private var theme

  @State private var selection = "전체"
  @State private var itemCount = 3
  @State private var isDisabled = false
  @State private var disablesSelectedItem = false
  @State private var usesLongLabels = false
  @State private var usesNarrowWidth = false
  @State private var usesCustomTheme = false

  private let options = ["전체", "진행 중", "완료", "보관"]

  var body: some View {
    List {
      Section("Segmented Control") {
        FoundesignSegmentedControl {
          ForEach(Array(options.prefix(itemCount)), id: \.self) { option in
            FoundesignSegmentedControlItem(value: option, selection: $selection) {
              HStack(spacing: theme.spacing.xSmall) {
                Text(usesLongLabels ? "\(option) 항목을 모두 표시합니다" : option)

                if option == "진행 중" {
                  FoundesignBadge(title: "2")
                    .fixedSize()
                }
              }
            }
            .disabled(disablesSelectedItem && option == "전체")
          }
        }
        .frame(maxWidth: usesNarrowWidth ? 220 : .infinity)
        .disabled(isDisabled)
        .environment(\.theme, usesCustomTheme ? customTheme : theme)

        Text("현재 필터: \(selection)")

        Text(selection == "전체" ? "모든 항목을 표시합니다." : "\(selection) 항목을 표시합니다.")
      }

      Section("설정") {
        Stepper("항목 수: \(itemCount)", value: $itemCount, in: 2...4)

        Toggle("전체 비활성", isOn: $isDisabled)

        Toggle("전체 항목 비활성", isOn: $disablesSelectedItem)

        Toggle("긴 라벨", isOn: $usesLongLabels)

        Toggle("좁은 폭", isOn: $usesNarrowWidth)

        Toggle("커스텀 테마", isOn: $usesCustomTheme)

        Button("외부에서 전체 선택") {
          selection = "전체"
        }

        Button("목록에 없는 값 선택") {
          selection = "없음"
        }
      }
    }
    .navigationTitle("Segmented Control")
  }

  private var customTheme: FoundesignTheme {
    var custom = theme
    custom.spacing.small = theme.spacing.medium
    custom.radius.medium = theme.radius.small
    custom.radius.large = theme.radius.medium
    custom.color.background.subtle = theme.color.background.brand.weak.normal
    return custom
  }
}
