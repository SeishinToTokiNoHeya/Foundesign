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

      Section("Ghost") {
        ghost
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

  private var ghost: some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      ForEach(FoundesignButtonProperty.Tone.allCases, id: \.self) { tone in
        Button(tone.description) { actionCount += 1 }
          .buttonTone(tone)
      }

      ForEach(FoundesignButtonProperty.Size.allCases, id: \.self) { size in
        Button(size.description) { actionCount += 1 }
          .buttonSize(size)
      }

      Button("비활성 버튼") { actionCount += 1 }
        .disabled(true)

      Button { actionCount += 1 } label: {
        Label("아이콘과 함께 표시", systemImage: "plus")
      }

      Button { actionCount += 1 } label: {
        Text("좁은 폭에서 여러 줄로 표시되는 긴 버튼 라벨")
          .frame(maxWidth: .infinity)
      }
      .frame(width: 180)

      Text("실행 횟수: \(actionCount)")
    }
    .buttonStyle(.ghost)
    .buttonTone(usesBrandTone ? .brand : .neutral)
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
