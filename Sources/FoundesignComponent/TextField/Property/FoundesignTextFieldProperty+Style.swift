import Foundation

extension FoundesignTextFieldProperty {
  /// 입력 영역의 경계를 표현하는 방식입니다.
  public enum Style: CaseIterable, Hashable, Sendable {
    /// 둥근 사각형 테두리를 표시합니다.
    case outline
    /// 입력 영역 아래에만 선을 표시합니다.
    case underline
  }
}

extension FoundesignTextFieldProperty.Style: CustomStringConvertible {
  public var description: String {
    switch self {
    case .outline: "Outline"
    case .underline: "Underline"
    }
  }
}
