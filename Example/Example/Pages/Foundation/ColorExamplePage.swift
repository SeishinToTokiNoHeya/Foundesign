import FoundesignFoundation
import SwiftUI

struct ColorExamplePage: View {
  @Environment(\.theme) private var theme

  var body: some View {
    List {
      Section("Action") {
        action(theme.color.action.primary, title: "primary")
        action(theme.color.action.secondary, title: "secondary")
        action(theme.color.action.neutral, title: "neutral")
        action(theme.color.action.destructive, title: "destructive")
      }

      Section("Background") {
        background(theme.color.background)
      }

      Section("Text") {
        text(theme.color.text)
      }
    }
  }

  private func action(
    _ state: ColorToken.Action.State,
    title: String
  ) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(title)
        .typography(theme.typography.title.small)
        .foregroundStyle(theme.color.text.primary)

      HStack(spacing: theme.spacing.medium) {
        cell("normal", state.normal)
        cell("pressed", state.pressed)
        cell("focused", state.focused)
        cell("disabled", state.disabled)
      }
    }
  }

  private func background(_ token: ColorToken.Background) -> some View {
    HStack(spacing: theme.spacing.medium) {
      cell("base", token.base)
      cell("subtle", token.subtle)
      cell("elevated", token.elevated)
      cell("overlay", token.overlay)
      cell("inverse", token.inverse)
    }
  }

  private func text(_ token: ColorToken.Text) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      HStack(spacing: theme.spacing.medium) {
        cell("primary", token.primary)
        cell("secondary", token.secondary)
        cell("tertiary", token.tertiary)
        cell("disabled", token.disabled)
      }

      HStack(spacing: theme.spacing.medium) {
        cell("inverse", token.inverse)
        cell("link", token.link)
        cell("destructive", token.destructive)
      }
    }
  }

  private func cell(_ title: String, _ color: Color) -> some View {
    VStack(spacing: theme.spacing.small) {
      RoundedRectangle(cornerRadius: theme.radius.large)
        .fill(color)
        .overlay {
          RoundedRectangle(cornerRadius: theme.radius.large)
            .stroke(theme.color.text.primary.opacity(0.1), lineWidth: 1)
        }
        .frame(width: 45, height: 45)

      Text(title)
        .typography(theme.typography.body.small)
        .foregroundStyle(theme.color.text.primary)
        .lineLimit(1)
    }
    .minimumScaleFactor(0.5)
  }
}
