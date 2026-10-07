import Foundesign
import SwiftUI

struct MenuExamplePage: View {
  @Environment(\.theme) private var theme
  private enum MenuAnchor: Hashable { case top, bottom }
  @State private var selectedMenu: MenuAnchor?
  @State private var selection = "최신순"
  @State private var lastAction = "없음"
  @State private var property = FoundesignMenuProperty()
  @State private var showsManyItems = false
  @State private var isDisabled = false
  @State private var isRightToLeft = false

  var body: some View {
    VStack(spacing: theme.spacing.large) {
      HStack {
        menuButton("상단 메뉴", anchor: .top)
        Spacer()
      }
      Form {
        Section("상태") {
          Text("선택: \(selection)")
          Text("마지막 액션: \(lastAction)")
        }
        Section("설정") {
          Picker("크기", selection: $property.size) {
            Text("Small").tag(FoundesignMenuProperty.Size.small)
            Text("Medium").tag(FoundesignMenuProperty.Size.medium)
          }
          Picker("너비", selection: $property.width) {
            Text("기본 너비").tag(FoundesignMenuProperty.Width.fixed)
            Text("버튼 너비").tag(FoundesignMenuProperty.Width.trigger)
          }
          Picker("우선 방향", selection: $property.placement) {
            Text("아래").tag(FoundesignMenuProperty.Placement.bottom)
            Text("위").tag(FoundesignMenuProperty.Placement.top)
          }
          Picker("정렬", selection: $property.alignment) {
            Text("시작").tag(FoundesignMenuProperty.Alignment.leading)
            Text("중앙").tag(FoundesignMenuProperty.Alignment.center)
            Text("끝").tag(FoundesignMenuProperty.Alignment.trailing)
          }
          Toggle("긴 메뉴와 스크롤", isOn: $showsManyItems)
          Toggle("메뉴 버튼 비활성", isOn: $isDisabled)
          Toggle("오른쪽에서 왼쪽으로 정렬", isOn: $isRightToLeft)
        }
        Section("배치 확인") {
          Text("상단 버튼에서는 아래로, 하단 버튼에서는 위로 열립니다. 오른쪽 가장자리에서는 메뉴가 화면 안으로 이동합니다.")
          Text("창 크기나 기기 방향을 바꾸면 남은 공간에 맞춰 위치와 높이가 조정됩니다.")
        }
      }
      HStack {
        Spacer()
        menuButton("하단 메뉴", anchor: .bottom)
      }
    }
    .padding(theme.spacing.large)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .menuScope(selection: $selectedMenu) { _ in
      menuContent
    }
    .menuProperty(property)
    .environment(\.layoutDirection, isRightToLeft ? .rightToLeft : .leftToRight)
    .navigationTitle("Menu")
  }

  private func menuButton(_ title: String, anchor: MenuAnchor) -> some View {
    Button(title) { selectedMenu = anchor }
      .buttonStyle(.weak)
      .menuAnchor(id: anchor)
      .disabled(isDisabled)
  }

  @ViewBuilder
  private var menuContent: some View {
    FoundesignMenuGroup(title: "정렬") {
      ForEach(["최신순", "인기순", "가까운순"], id: \.self) { value in
        FoundesignMenuItem(title: value, isSelected: selection == value) {
          selection = value
        }
      }
    }
    FoundesignMenuDivider()
    FoundesignMenuGroup(title: "작업") {
      FoundesignMenuItem(title: "공유하기", systemImage: "square.and.arrow.up", badge: "NEW") {
        lastAction = "공유하기"
      }
      FoundesignMenuItem(title: "보관하기", systemImage: "archivebox") {
        lastAction = "보관하기"
      }
      .disabled(true)
      if showsManyItems {
        ForEach(1...15, id: \.self) { index in
          FoundesignMenuItem(
            title: "긴 제목이 여러 줄로 표시되는 추가 메뉴 \(index)",
            description: index == 1 ? "이 항목에 대한 보조 설명입니다." : nil,
            systemImage: "doc"
          ) {
            lastAction = "추가 메뉴 \(index)"
          }
        }
      }
    }
    FoundesignMenuDivider()
    FoundesignMenuGroup {
      FoundesignMenuItem(title: "삭제하기", systemImage: "trash", role: .destructive) {
        lastAction = "삭제하기"
      }
    }
  }
}
