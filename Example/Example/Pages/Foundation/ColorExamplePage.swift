import Foundesign
import SwiftUI

struct ColorExamplePage: View {
  @Environment(\.theme) private var theme

  private let palette = ColorPalette.default
  private let customTheme: FoundesignTheme = {
    var palette = ColorPalette.default
    palette.purple[.`700`] = .adaptive(light: 0x7959D8, dark: 0xAF96F5)
    return FoundesignTheme(palette: palette, brand: palette.purple)
  }()

  var body: some View {
    List {
      Section("테마") {
        themePreview("기본 테마 · 파란색", theme: .default)
        themePreview("사용자 정의 테마 · 보라색", theme: customTheme)
      }

      Section("팔레트") {
        swatches("회색", colors: ColorPalette.GrayScale.Step.allCases.map {
          Swatch("\($0.rawValue)", palette.gray[$0])
        })
        paletteRow("주황색", palette.orange)
        paletteRow("파란색", palette.blue)
        paletteRow("초록색", palette.green)
        paletteRow("노란색", palette.yellow)
        paletteRow("빨간색", palette.red)
        paletteRow("보라색", palette.purple)
        swatches("고정 색상", colors: [Swatch("검은색", palette.black), Swatch("흰색", palette.white)])
        paletteRow("검은색 투명도", palette.blackAlpha)
        swatches(
          "흰색 투명도",
          colors: ColorPalette.WhiteAlphaScale.Step.allCases.map {
            Swatch("\($0.rawValue)", palette.whiteAlpha[$0])
          }
        )
      }

      Section("전경") {
        swatches("공통", colors: [
          Swatch("기본", theme.color.foreground.primary),
          Swatch("보조", theme.color.foreground.secondary),
          Swatch("부가", theme.color.foreground.tertiary),
          Swatch("반전", theme.color.foreground.inverse),
          Swatch("비활성", theme.color.foreground.disabled),
          Swatch("입력 안내", theme.color.foreground.placeholder),
          Swatch("링크", theme.color.foreground.link)
        ])
      }

      Section("배경") {
        swatches("공통", colors: [
          Swatch("기본", theme.color.background.base),
          Swatch("은은한", theme.color.background.subtle),
          Swatch("띄운 배경", theme.color.background.elevated),
          Swatch("반전", theme.color.background.inverse),
          Swatch("덮개", theme.color.background.overlay),
          Swatch("비활성", theme.color.background.disabled)
        ])
        stateRow("투명 배경", theme.color.background.transparent)
      }

      Section("테두리") {
        swatches("공통", colors: [
          Swatch("기본", theme.color.border.base),
          Swatch("은은한", theme.color.border.subtle),
          Swatch("강조", theme.color.border.strong),
          Swatch("포커스", theme.color.border.focus),
          Swatch("비활성", theme.color.border.disabled)
        ], borderOnly: true)
      }

      Section("역할별 색상") {
        rolePreview(
          "중립",
          foreground: .init(
            normal: theme.color.foreground.secondary,
            strong: theme.color.foreground.primary,
            solid: theme.color.foreground.inverse
          ),
          background: theme.color.background.neutral,
          border: .init(weak: theme.color.border.base, solid: theme.color.border.strong)
        )
        rolePreview(
          "브랜드",
          foreground: theme.color.foreground.brand,
          background: theme.color.background.brand,
          border: theme.color.border.brand
        )
        rolePreview(
          "정보",
          foreground: theme.color.foreground.informative,
          background: theme.color.background.informative,
          border: theme.color.border.informative
        )
        rolePreview(
          "긍정",
          foreground: theme.color.foreground.positive,
          background: theme.color.background.positive,
          border: theme.color.border.positive
        )
        rolePreview(
          "주의",
          foreground: theme.color.foreground.warning,
          background: theme.color.background.warning,
          border: theme.color.border.warning
        )
        rolePreview(
          "위험",
          foreground: theme.color.foreground.critical,
          background: theme.color.background.critical,
          border: theme.color.border.critical
        )
      }
    }
  }

  private func themePreview(_ title: String, theme previewTheme: FoundesignTheme) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(title)
        .typography(theme.typography.title.small)
        .foregroundStyle(previewTheme.color.foreground.primary)

      ViewThatFits(in: .horizontal) {
        HStack { themeButtons }
        VStack(alignment: .leading) { themeButtons }
      }
      .environment(\.theme, previewTheme)
    }
    .padding(.vertical, theme.spacing.small)
  }

  @ViewBuilder
  private var themeButtons: some View {
    Button("외곽선") {}
      .buttonStyle(.outline(size: .small))
    Button("옅은 배경") {}
      .buttonStyle(.weak(size: .small))
    Button("진한 배경") {}
      .buttonStyle(.solid(size: .small))
  }

  private func paletteRow(_ title: String, _ scale: ColorPalette.Scale) -> some View {
    swatches(title, colors: ColorPalette.Scale.Step.allCases.map {
      Swatch("\($0.rawValue)", scale[$0])
    })
  }

  private func rolePreview(
    _ title: String,
    foreground: ColorToken.Foreground.Role,
    background: ColorToken.Background.Role,
    border: ColorToken.Border.Role
  ) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.medium) {
      Text(title)
        .typography(theme.typography.title.small)
        .foregroundStyle(theme.color.foreground.primary)

      swatches("전경", colors: [
        Swatch("일반", foreground.normal),
        Swatch("강조", foreground.strong),
        Swatch("진한 배경 위", foreground.solid)
      ])
      swatches("테두리", colors: [
        Swatch("옅은", border.weak),
        Swatch("진한", border.solid)
      ], borderOnly: true)
      stateRow("진한 배경", background.solid)
      stateRow("옅은 배경", background.weak)
    }
    .padding(.vertical, theme.spacing.small)
  }

  private func stateRow(_ title: String, _ state: ColorToken.State) -> some View {
    swatches(title, colors: [
      Swatch("일반", state.normal),
      Swatch("눌림", state.pressed),
      Swatch("포커스", state.focused),
      Swatch("비활성", state.disabled)
    ])
  }

  private func swatches(_ title: String, colors: [Swatch], borderOnly: Bool = false) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      Text(title)
        .typography(theme.typography.label.medium)
        .foregroundStyle(theme.color.foreground.secondary)

      ScrollView(.horizontal) {
        HStack(alignment: .top, spacing: theme.spacing.small) {
          ForEach(colors) { swatch in
            VStack(spacing: theme.spacing.small) {
              RoundedRectangle(cornerRadius: theme.radius.medium)
                .fill(borderOnly ? theme.color.background.base : swatch.color)
                .overlay {
                  RoundedRectangle(cornerRadius: theme.radius.medium)
                    .strokeBorder(borderOnly ? swatch.color : theme.color.border.base, lineWidth: 1)
                }
                .frame(height: 44)

              Text(swatch.name)
                .typography(theme.typography.body.small)
                .foregroundStyle(theme.color.foreground.primary)
            }
            .frame(width: 84)
          }
        }
      }
    }
    .padding(.vertical, theme.spacing.small)
  }
}

private struct Swatch: Identifiable {
  var id: String { name }
  let name: String
  let color: Color

  init(_ name: String, _ color: Color) {
    self.name = name
    self.color = color
  }
}
