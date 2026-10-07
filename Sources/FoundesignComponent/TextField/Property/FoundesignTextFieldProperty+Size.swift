import Foundation

extension FoundesignTextFieldProperty {
  /// 입력 영역의 글꼴과 여백 조합입니다.
  public enum Size: CaseIterable, Hashable, Sendable {
    /// 좁은 데스크톱 폼에 사용할 수 있는 작은 크기입니다.
    case medium
    /// 모바일과 데스크톱에서 사용하는 기본 크기입니다.
    case large
  }
}

extension FoundesignTextFieldProperty.Size: CustomStringConvertible {
  public var description: String {
    switch self {
    case .medium: "Medium"
    case .large: "Large"
    }
  }
}
