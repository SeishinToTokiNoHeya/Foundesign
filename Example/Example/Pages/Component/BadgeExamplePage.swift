import Foundesign
import SwiftUI

struct BadgeExamplePage: View {
  @Environment(\.theme) private var theme
  @State private var property = FoundesignBadgeProperty()
  @State private var title = "새 소식"
  @State private var showsIcon = false
  @State private var isDisabled = false

  var body: some View {
    List {
      Section("미리보기") {
        FoundesignBadge(
          title: title,
          systemImage: showsIcon ? "checkmark.circle.fill" : nil,
          property: property
        )
        .disabled(isDisabled)
      }

      Section("설정") {
        TextField("라벨", text: $title)
        Picker("크기", selection: $property.size) {
          ForEach(FoundesignBadgeProperty.Size.allCases, id: \.self) { size in
            Text(size.description).tag(size)
          }
        }
        Picker("톤", selection: $property.tone) {
          ForEach(FoundesignBadgeProperty.Tone.allCases, id: \.self) { tone in
            Text(tone.description).tag(tone)
          }
        }
        Picker("스타일", selection: $property.variant) {
          ForEach(FoundesignBadgeProperty.Variant.allCases, id: \.self) { variant in
            Text(variant.description).tag(variant)
          }
        }
        Toggle("아이콘 표시", isOn: $showsIcon)
        Toggle("비활성", isOn: $isDisabled)
      }

      Section("의미별 톤") {
        ForEach(FoundesignBadgeProperty.Tone.allCases, id: \.self) { tone in
          FoundesignBadge(
            title: tone.description,
            property: .init(size: property.size, tone: tone, variant: property.variant)
          )
        }
      }

      Section("긴 라벨과 좁은 폭") {
        FoundesignBadge(
          title: "확인이 필요한 새로운 업데이트가 있습니다",
          systemImage: showsIcon ? "info.circle.fill" : nil,
          property: property
        )
        .frame(width: 140, alignment: .leading)
      }

      Section("콘텐츠와 함께 사용") {
        HStack(spacing: theme.spacing.small) {
          Text("주문 내역")
          FoundesignBadge(
            title: "배송 완료",
            systemImage: "checkmark",
            property: .init(tone: .positive)
          )
        }
      }
    }
    .navigationTitle("Badge")
  }
}
