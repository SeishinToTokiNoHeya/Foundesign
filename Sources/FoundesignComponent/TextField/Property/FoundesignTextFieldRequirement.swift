import Foundation

/// 텍스트 필드 레이블 옆에 표시할 입력 필요 여부입니다.
///
/// 시각적 안내이며 필수 값 검증을 수행하지 않습니다. 한 폼에서는 필수 표시와 선택 표시 중
/// 한 방식을 사용하세요.
public enum FoundesignTextFieldRequirement: Hashable, Sendable {
  /// 별도 표시를 하지 않습니다.
  case none
  /// 별표를 표시합니다.
  case required
  /// 호출자가 제공한 선택 안내 문구를 표시합니다.
  case optional(String)
}
