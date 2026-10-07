import Foundesign
import SwiftUI

struct ButtonStyleExamplePage: View {
  @Environment(\.theme) private var theme
  @State private var usesBrandTone = true
  @State private var actionCount = 0

  var body: some View {
    List {
      Section("Environment Overrides") {
        Toggle("브랜드 톤", isOn: $usesBrandTone)
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
          Button("상속한 크기와 톤") { actionCount += 1 }
          Button("크기만 Small로 변경") { actionCount += 1 }
            .buttonSize(.small)
            .buttonStyle(.outline)
          Button("전체 속성 교체") { actionCount += 1 }
            .buttonProperty(.init(tone: .critical, size: .medium))
        }
        .buttonStyle(.solid)
        .buttonProperty(.init(tone: usesBrandTone ? .brand : .neutral, size: .large))
        Text("실행 횟수: \(actionCount)")
      }

      Section("Outline") {
        outline
      }

      Section("Solid") {
        solid
      }

      Section("Weak") {
        weak
      }
    }
    .navigationTitle("Button Style")
  }

  private var outline: some View {
    VStack(alignment: .leading) {
      ForEach(FoundesignButtonProperty.Tone.allCases, id: \.hashValue) { tone in
        Text(tone.description)
          .typography(theme.typography.title.small)
          .foregroundStyle(theme.color.foreground.primary)

        ForEach(FoundesignButtonProperty.Size.allCases, id: \.hashValue) { size in
          HStack {
            button(size.description)
              .buttonStyle(.outline)
              .buttonTone(tone)
              .buttonSize(size)

            button(size.description + ".disabled")
              .buttonStyle(.outline)
              .buttonTone(tone)
              .buttonSize(size)
              .disabled(true)
          }
        }
      }
    }
  }

  private var solid: some View {
    VStack(alignment: .leading) {
      ForEach(FoundesignButtonProperty.Tone.allCases, id: \.hashValue) { tone in
        Text(tone.description)
          .typography(theme.typography.title.small)
          .foregroundStyle(theme.color.foreground.primary)

        ForEach(FoundesignButtonProperty.Size.allCases, id: \.hashValue) { size in
          HStack {
            button(size.description)
              .buttonStyle(.solid)
              .buttonTone(tone)
              .buttonSize(size)

            button(size.description + ".disabled")
              .buttonStyle(.solid)
              .buttonTone(tone)
              .buttonSize(size)
              .disabled(true)
          }
        }
      }
    }
  }

  private var weak: some View {
    VStack(alignment: .leading) {
      ForEach(FoundesignButtonProperty.Tone.allCases, id: \.hashValue) { tone in
        Text(tone.description)
          .typography(theme.typography.title.small)
          .foregroundStyle(theme.color.foreground.primary)

        ForEach(FoundesignButtonProperty.Size.allCases, id: \.hashValue) { size in
          HStack {
            button(size.description)
              .buttonStyle(.weak)
              .buttonTone(tone)
              .buttonSize(size)

            button(size.description + ".disabled")
              .buttonStyle(.weak)
              .buttonTone(tone)
              .buttonSize(size)
              .disabled(true)
          }
        }
      }
    }
  }

  private func button(_ title: String) -> some View {
    Button {

    } label: {
      Text(title)
    }
  }
}
