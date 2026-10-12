import Foundesign
import SwiftUI

struct BrandGenerationExample: View {
  @Environment(\.self) private var environment
  @State private var input = Input.hex
  @State private var lightHex = "#FF6600"
  @State private var darkHex = "#FF9966"
  @State private var selectedColor = Color.orange
  @State private var useAsset = false
  @State private var error: String?
  @State private var appliedLight: UInt = 0xFF6600
  @State private var appliedDark: UInt = 0xFF9966

  private enum Input: String, CaseIterable {
    case hex = "공통 HEX"
    case pair = "모드별 HEX"
    case color = "Color"
  }

  private var seed: Color {
    switch input {
    case .hex: .adaptive(light: appliedLight, dark: appliedLight)
    case .pair: .adaptive(light: appliedLight, dark: appliedDark)
    case .color: useAsset ? Color("BrandSeed") : selectedColor
    }
  }

  private var scale: ColorPalette.Scale {
    switch input {
    case .hex: .init(seedHex: appliedLight)
    case .pair: .init(lightHex: appliedLight, darkHex: appliedDark)
    case .color: .init(seed: seed, environment: environment)
    }
  }

  private var generatedTheme: FoundesignTheme {
    switch input {
    case .hex: .init(brandHex: appliedLight)
    case .pair: .init(lightHex: appliedLight, darkHex: appliedDark)
    case .color: .init(brandColor: seed, environment: environment)
    }
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Picker("입력 방식", selection: $input) {
        ForEach(Input.allCases, id: \.self) { value in
          Text(value.rawValue).tag(value)
        }
      }
      .pickerStyle(.segmented)
      .onChange(of: input) { error = nil }

      if input == .color {
        Toggle("모드별 Asset 사용 · 주황 / 보라", isOn: $useAsset)

        if !useAsset {
          ColorPicker("기준색", selection: $selectedColor, supportsOpacity: true)
        }

        Text("투명도는 무시하고 불투명 팔레트를 생성합니다.")
          .font(.caption)
      } else {
        TextField(input == .hex ? "공통 HEX" : "라이트 HEX", text: $lightHex)
          .textFieldStyle(.roundedBorder)

        if input == .pair {
          TextField("다크 HEX", text: $darkHex)
            .textFieldStyle(.roundedBorder)
        }

        Button("적용", action: applyHex)

        if let error {
          Text(error)
            .foregroundStyle(.red)
        }
      }

      Text("입력 색조와 채도를 바탕으로 밝기를 조정합니다. 원본 색상과 결과가 다를 수 있습니다.")
        .font(.caption)

      let scale = scale
      let generatedTheme = generatedTheme
      ScrollView(.horizontal) {
        HStack(alignment: .top, spacing: 16) {
          preview("라이트", scheme: .light, scale: scale, theme: generatedTheme)
          preview("다크", scheme: .dark, scale: scale, theme: generatedTheme)
        }
      }
    }
    .padding(.vertical, 8)
  }

  private func applyHex() {
    func parse(_ text: String) -> UInt? {
      let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
      let digits = trimmed.hasPrefix("#") ? String(trimmed.dropFirst()) : trimmed

      guard digits.count == 6, digits.utf8.allSatisfy({
        (48...57).contains($0) || (65...70).contains($0) || (97...102).contains($0)
      }) else {
        return nil
      }
      return UInt(digits, radix: 16)
    }

    guard let light = parse(lightHex), let dark = input == .pair ? parse(darkHex) : light else {
      error = "6자리 HEX를 입력하세요. 예: #FF6600. 마지막 적용값을 유지합니다."
      return
    }
    appliedLight = light

    if input == .pair {
      appliedDark = dark
    }
    error = nil
  }

  private func preview(
    _ title: String,
    scheme: ColorScheme,
    scale: ColorPalette.Scale,
    theme: FoundesignTheme
  ) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title).font(.headline)

      HStack {
        RoundedRectangle(cornerRadius: 6).fill(seed).frame(width: 40, height: 30)

        Text("기준색")
      }

      ForEach(ColorPalette.Scale.Step.allCases, id: \.self) { step in
        HStack {
          Text("\(step.rawValue)").monospacedDigit().frame(width: 44, alignment: .leading)

          RoundedRectangle(cornerRadius: 4)
            .fill(scale[step])
            .frame(height: 22)
        }
      }

      Button("Brand · 눌러보기") {}
        .buttonStyle(.solid)

      Button("비활성") {}
        .buttonStyle(.solid)
        .disabled(true)

      Button("옅은 배경") {}
        .buttonStyle(.weak)

      Button("외곽선") {}
        .buttonStyle(.outline)

      Text("링크 색상")
        .foregroundStyle(theme.color.foreground.link)

      RoundedRectangle(cornerRadius: 4)
        .strokeBorder(theme.color.border.focus, lineWidth: 2)
        .frame(height: 24)
        .overlay(Text("포커스 테두리").font(.caption))
    }
    .padding(16)
    .frame(width: 240)
    .foregroundStyle(theme.color.foreground.primary)
    .background(theme.color.background.base)
    .clipShape(.rect(cornerRadius: 12))
    .environment(\.theme, theme)
    .environment(\.colorScheme, scheme)
  }
}
