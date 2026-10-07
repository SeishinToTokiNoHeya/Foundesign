import Foundation
import FoundesignFoundation

extension FoundesignSwitchProperty {
  /// 테마의 간격과 타이포그래피에 대응하는 스위치 크기입니다.
  public enum Size: CaseIterable, Hashable, Sendable {
    /// 기본 테마에서 트랙 높이가 16pt인 작은 크기입니다.
    case small
    /// 기본 테마에서 트랙 높이가 24pt인 중간 크기입니다.
    case medium
    /// 기본 테마에서 트랙 높이가 32pt인 큰 크기입니다.
    case large
  }
}

extension FoundesignSwitchProperty.Size: CustomStringConvertible {
  public var description: String {
    switch self {
    case .small: "Small"
    case .medium: "Medium"
    case .large: "Large"
    }
  }
}

extension FoundesignSwitchProperty.Size {
  func height(_ token: SpacingToken) -> CGFloat {
    switch self {
    case .small: token.large
    case .medium: token.xLarge
    case .large: token.xxLarge
    }
  }

  func width(_ token: SpacingToken) -> CGFloat {
    // 기본 트랙의 26×16, 38×24, 52×32 비율을 테마에서도 유지합니다.
    switch self {
    case .small: height(token) * 26 / 16
    case .medium: height(token) * 38 / 24
    case .large: height(token) * 52 / 32
    }
  }

  func inset(_ token: SpacingToken) -> CGFloat {
    // 기본 테마의 안쪽 여백 2pt, 2pt, 3pt를 트랙 높이에 비례시킵니다.
    switch self {
    case .small: height(token) * 2 / 16
    case .medium: height(token) * 2 / 24
    case .large: height(token) * 3 / 32
    }
  }

  func minimumHeight(_ token: SpacingToken) -> CGFloat {
    max(height(token), token.xLarge)
  }

  func spacing(_ token: SpacingToken) -> CGFloat {
    // 라벨 간격은 작은 크기부터 6pt, 8pt, 10pt에 대응합니다.
    switch self {
    case .small: token.medium / 2
    case .medium: token.small
    case .large: (token.small + token.medium) / 2
    }
  }

  func typography(_ token: TypographyToken) -> Typography {
    switch self {
    case .small: token.body.small
    case .medium: token.body.medium
    case .large: token.body.large
    }
  }
}
