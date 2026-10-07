import FoundesignFoundation
import SwiftUI

/// 레이블·도움말·오류 안내를 함께 표시하는 한 줄 텍스트 입력입니다.
///
/// 입력은 `text`에 즉시 반영하며 상위 `.disabled`와 테마를 따릅니다.
/// 오류 메시지는 도움말보다 우선합니다. 최대 글자 수를 넘으면 오류 테두리와 글자 수를
/// 표시하지만, 한글 조합과 붙여넣기를 보존하기 위해 입력을 자르거나 바인딩을 보정하지 않습니다.
/// 읽기 전용에서는 선택·복사할 수 있는 텍스트를 표시합니다.
/// 크기·스타일·레이블 강조와 읽기 전용·지우기 정책은 환경에서 상속합니다.
/// 도움말·오류·글자 수·필수 표시는 개별 필드 modifier로 설정하며 다른 필드에 상속하지 않습니다.
/// 개별 필드 modifier는 `.padding` 등 일반 `View` modifier보다 먼저 적용하세요.
/// `.onSubmit` 등 표준 SwiftUI 입력 modifier를 함께 사용할 수 있습니다.
/// 사용 흐름은 <doc:TextField>를 참고하세요.
public struct FoundesignTextField<HeaderTrailing: View, Leading: View, Trailing: View>: View {
  @Environment(\.theme) private var theme
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.textFieldProperty) private var property
  @Environment(\.textFieldIsReadOnly) private var isReadOnly
  @Environment(\.textFieldShowsClearButton) private var showsClearButton
  @FocusState private var isFocused: Bool
  @Binding private var text: String

  private let title: String
  private let placeholder: String
  private var helperText: String?
  private var errorMessage: String?
  private var requirement: FoundesignTextFieldRequirement = .none
  private var maximumLength: Int?
  private var focus: FocusState<Bool>.Binding?
  private let headerTrailing: HeaderTrailing
  private let leading: Leading
  private let trailing: Trailing

  /// 한 줄 입력과 선택적인 보조 콘텐츠를 만듭니다.
  /// - Parameters:
  ///   - title: 입력 위의 레이블입니다. 빈 문자열이면 레이블과 필요 여부 표시를 생략합니다.
  ///   - text: 호출자가 소유하는 입력값입니다. 외부 변경도 그대로 표시합니다.
  ///   - placeholder: 입력값이 비어 있을 때 표시할 문구입니다.
  ///   - headerTrailing: 레이블 옆의 보조 액션입니다. 기본값은 빈 뷰입니다.
  ///   - leading: 입력 앞의 아이콘이나 접두사입니다. 기본값은 빈 뷰입니다.
  ///   - trailing: 입력 뒤의 단위나 보조 액션입니다. 기본값은 빈 뷰입니다.
  public init(
    title: String,
    text: Binding<String>,
    placeholder: String = "",
    @ViewBuilder headerTrailing: () -> HeaderTrailing = { EmptyView() },
    @ViewBuilder leading: () -> Leading = { EmptyView() },
    @ViewBuilder trailing: () -> Trailing = { EmptyView() }
  ) {
    self.title = title
    self._text = text
    self.placeholder = placeholder
    self.headerTrailing = headerTrailing()
    self.leading = leading()
    self.trailing = trailing()
  }

  /// 이 필드에만 표시할 도움말을 설정합니다.
  /// - Parameter text: 오류 메시지가 없을 때 표시할 도움말입니다. 기본값인 `nil`과 빈 문자열은 생략합니다.
  /// - Returns: 도움말이 설정된 필드입니다. 반복 적용하면 마지막 값이 우선합니다.
  public func helperText(_ text: String?) -> Self {
    var field = self
    field.helperText = text
    return field
  }

  /// 이 필드의 오류 상태와 메시지를 설정합니다.
  /// - Parameter message: 도움말 대신 표시할 오류입니다. 기본값인 `nil`과 빈 문자열은 오류가 아닙니다.
  /// - Returns: 오류 메시지가 설정된 필드입니다. 반복 적용하면 마지막 값이 우선합니다.
  public func errorMessage(_ message: String?) -> Self {
    var field = self
    field.errorMessage = message
    return field
  }

  /// 이 필드의 레이블 옆에 입력 필요 여부를 표시합니다.
  /// - Parameter requirement: 기본값은 `.none`입니다. 표시만 변경하며 필수 값 검증을 수행하지 않습니다.
  /// - Returns: 입력 필요 여부가 설정된 필드입니다. 반복 적용하면 마지막 값이 우선합니다.
  public func requirement(_ requirement: FoundesignTextFieldRequirement) -> Self {
    var field = self
    field.requirement = requirement
    return field
  }

  /// 이 필드의 글자 수 안내와 초과 상태의 기준을 설정합니다.
  /// - Parameter length: 기본값인 `nil`이면 생략하며 음수는 0으로 취급합니다.
  ///   `String.count`로 세며 입력이나 외부 바인딩을 자르지 않습니다.
  /// - Returns: 글자 수 기준이 설정된 필드입니다. 반복 적용하면 마지막 값이 우선합니다.
  public func maximumLength(_ length: Int?) -> Self {
    var field = self
    field.maximumLength = length.map { max(0, $0) }
    return field
  }

  /// 외부 포커스 상태를 이 필드의 실제 입력에 연결합니다.
  /// - Parameter focus: 입력 포커스를 제어·관찰할 바인딩입니다. 기본값인 `nil`이면 내부에서 관리합니다.
  ///   읽기 전용이나 비활성 상태로 전환하면 포커스를 해제합니다.
  /// - Returns: 포커스가 연결된 필드입니다. 반복 적용하면 마지막 바인딩이 우선합니다.
  public func textFieldFocused(_ focus: FocusState<Bool>.Binding?) -> Self {
    var field = self
    field.focus = focus
    return field
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.small) {
      if !title.isEmpty || HeaderTrailing.self != EmptyView.self {
        header
      }
      input
      if displayedError != nil || nonempty(helperText) != nil || maximumLength != nil {
        footer
      }
    }
    .onChange(of: canEdit) { _, canEdit in
      if !canEdit {
        inputFocus.wrappedValue = false
      }
    }
  }

  private var header: some View {
    HStack(alignment: .firstTextBaseline, spacing: theme.spacing.small) {
      if !title.isEmpty {
        HStack(alignment: .firstTextBaseline, spacing: theme.spacing.xSmall) {
          Text(title)
            .fontWeight(property.weight == .bold ? .bold : .medium)
            .fixedSize(horizontal: false, vertical: true)

          switch requirement {
          case .none:
            EmptyView()
          case .required:
            Text("*")
              .foregroundStyle(isEnabled ? theme.color.foreground.critical.normal : theme.color.foreground.disabled)
          case .optional(let text):
            Text(text)
              .typography(theme.typography.body.small)
              .foregroundStyle(secondaryColor)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }

      headerTrailing
    }
    .typography(theme.typography.body.medium)
    .foregroundStyle(foregroundColor)
  }

  private var input: some View {
    HStack(spacing: theme.spacing.small) {
      leading
        .foregroundStyle(secondaryColor)

      Group {
        if isReadOnly {
          Text(text.isEmpty ? placeholder : text)
            .foregroundStyle(text.isEmpty ? placeholderColor : foregroundColor)
            .lineLimit(1)
            .textSelection(.enabled)
        } else {
          TextField(title, text: $text, prompt: Text(placeholder).foregroundStyle(placeholderColor))
            .textFieldStyle(.plain)
            .foregroundStyle(foregroundColor)
            .focused(inputFocus)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      if showsClearButton && canEdit && inputFocus.wrappedValue && !text.isEmpty {
        Button(action: clearButtonTapped) {
          Image(systemName: "xmark.circle.fill")
            .foregroundStyle(theme.color.foreground.tertiary)
        }
        .buttonStyle(.plain)
      }

      trailing
        .foregroundStyle(secondaryColor)
    }
    .typography(inputTypography)
    .padding(.horizontal, property.style == .outline ? horizontalPadding : theme.spacing.zero)
    .padding(.vertical, verticalPadding)
    .background(backgroundColor, in: inputShape)
    .overlay {
      if property.style == .outline {
        inputShape.strokeBorder(borderColor, lineWidth: borderWidth)
          .allowsHitTesting(false)
      }
    }
    .overlay(alignment: .bottom) {
      if property.style == .underline {
        Rectangle()
          .fill(borderColor)
          .frame(height: borderWidth)
          .allowsHitTesting(false)
      }
    }
  }

  private var footer: some View {
    HStack(alignment: .top, spacing: theme.spacing.small) {
      if let message = displayedError ?? nonempty(helperText) {
        Text(message)
          .foregroundStyle(displayedError != nil ? errorColor : secondaryColor)
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      if let maximumLength {
        HStack(spacing: theme.spacing.zero) {
          Text(text.count.formatted())
            .foregroundStyle(isInvalid ? errorColor : text.isEmpty ? secondaryColor : foregroundColor)
          Text(" / \(maximumLength.formatted())")
            .foregroundStyle(isInvalid ? errorColor : secondaryColor)
        }
        .fixedSize()
        .frame(maxWidth: displayedError == nil && nonempty(helperText) == nil ? .infinity : nil, alignment: .trailing)
      }
    }
    .typography(theme.typography.body.small)
  }

  private var inputFocus: FocusState<Bool>.Binding { focus ?? $isFocused }
  private var canEdit: Bool { isEnabled && !isReadOnly }
  private var displayedError: String? { nonempty(errorMessage) }
  private var isInvalid: Bool {
    displayedError != nil || maximumLength.map { text.count > $0 } == true
  }

  private var inputTypography: Typography {
    switch (property.style, property.size) {
    case (.outline, .medium): theme.typography.body.medium
    case (.outline, .large), (.underline, .medium): theme.typography.body.large
    case (.underline, .large): theme.typography.title.small
    }
  }

  private var horizontalPadding: CGFloat {
    property.size == .large ? theme.spacing.large : theme.spacing.medium
  }

  private var verticalPadding: CGFloat {
    property.size == .large ? theme.spacing.medium : theme.spacing.small
  }

  private var inputShape: RoundedRectangle {
    .rect(cornerRadius: property.size == .large ? theme.radius.large : theme.radius.medium)
  }

  private var foregroundColor: Color {
    isEnabled ? theme.color.foreground.primary : theme.color.foreground.disabled
  }

  private var secondaryColor: Color {
    isEnabled ? theme.color.foreground.secondary : theme.color.foreground.disabled
  }

  private var placeholderColor: Color {
    isEnabled ? theme.color.foreground.placeholder : theme.color.foreground.disabled
  }

  private var errorColor: Color {
    isEnabled ? theme.color.foreground.critical.normal : theme.color.foreground.disabled
  }

  private var backgroundColor: Color {
    guard property.style == .outline else { return theme.color.background.transparent.normal }
    return canEdit ? theme.color.background.base : theme.color.background.disabled
  }

  private var borderColor: Color {
    if !isEnabled { return theme.color.border.disabled }
    if isInvalid { return theme.color.border.critical.solid }
    if canEdit && inputFocus.wrappedValue { return theme.color.border.focus }
    return theme.color.border.base
  }

  private var borderWidth: CGFloat {
    // 기본 경계는 1pt, 오류·입력 포커스 경계는 2pt로 강조합니다.
    isEnabled && (isInvalid || (canEdit && inputFocus.wrappedValue)) ? 2 : 1
  }

  private func nonempty(_ value: String?) -> String? {
    value.flatMap { $0.isEmpty ? nil : $0 }
  }

  private func clearButtonTapped() {
    text = ""
    inputFocus.wrappedValue = true
  }
}
