import Foundesign
import SwiftUI

struct ButtonStyleExamplePage: View {
  @Environment(\.theme) private var theme

  var body: some View {
    List {
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
  }

  private var outline: some View {
    VStack(alignment: .leading) {
      ForEach(FoundesignButtonProperty.Tone.allCases, id: \.hashValue) { tone in
        Text(tone.description)
          .typography(theme.typography.title.small)
          .foregroundStyle(theme.color.text.primary)

        ForEach(FoundesignButtonProperty.Size.allCases, id: \.hashValue) { size in
          HStack {
            button(size.description)
              .buttonStyle(.outline(tone: tone, size: size))

            button(size.description + ".disabled")
              .buttonStyle(.outline(tone: tone, size: size))
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
          .foregroundStyle(theme.color.text.primary)

        ForEach(FoundesignButtonProperty.Size.allCases, id: \.hashValue) { size in
          HStack {
            button(size.description)
              .buttonStyle(.solid(tone: tone, size: size))

            button(size.description + ".disabled")
              .buttonStyle(.solid(tone: tone, size: size))
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
          .foregroundStyle(theme.color.text.primary)

        ForEach(FoundesignButtonProperty.Size.allCases, id: \.hashValue) { size in
          HStack {
            button(size.description)
              .buttonStyle(.weak(tone: tone, size: size))

            button(size.description + ".disabled")
              .buttonStyle(.weak(tone: tone, size: size))
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
