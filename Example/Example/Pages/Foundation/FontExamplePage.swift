import FoundesignFoundation
import SwiftUI

struct FontExamplePage: View {
  @Environment(\.theme) private var theme

  var body: some View {
    List {
      Section("Body") {
        cell(theme.typography.body.large, title: "large")
        cell(theme.typography.body.medium, title: "medium")
        cell(theme.typography.body.small, title: "small")
      }

      Section("Display") {
        cell(theme.typography.display.large, title: "large")
        cell(theme.typography.display.medium, title: "medium")
        cell(theme.typography.display.small, title: "small")
      }

      Section("Label") {
        cell(theme.typography.label.large, title: "large")
        cell(theme.typography.label.medium, title: "medium")
        cell(theme.typography.label.small, title: "small")
      }

      Section("Title") {
        cell(theme.typography.title.large, title: "large")
        cell(theme.typography.title.medium, title: "medium")
        cell(theme.typography.title.small, title: "small")
      }
    }
  }

  private func cell(_ typography: Typography, title: String) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(title)
        .typography(theme.typography.body.large)
        .foregroundStyle(theme.color.foreground.brand.normal)

      Text("안녕하세요.")
        .typography(typography)
        .foregroundStyle(theme.color.foreground.primary)
        .multilineTextAlignment(.leading)

      Text("안녕하세요. 정말 안녕하십니까? 안녕!! 안녀어어어어어어어어!")
        .typography(typography)
        .foregroundStyle(theme.color.foreground.primary)
        .multilineTextAlignment(.leading)
    }
  }
}
