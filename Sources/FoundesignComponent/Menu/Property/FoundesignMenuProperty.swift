import Foundation

/// 메뉴의 크기, 너비, 우선 표시 방향과 수평 정렬입니다.
public struct FoundesignMenuProperty: Hashable, Sendable {
  /// 항목의 글꼴과 여백 크기입니다.
  public var size: Size
  /// 메뉴의 너비 결정 방식입니다.
  public var width: Width
  /// 공간이 충분할 때 우선하는 표시 방향입니다.
  public var placement: Placement
  /// 버튼에 대한 메뉴의 수평 정렬입니다.
  public var alignment: Alignment

  /// 메뉴 외형을 구성합니다.
  /// - Parameters:
  ///   - size: 기본값은 `.medium`입니다.
  ///   - width: 기본값은 `.fixed`입니다.
  ///   - placement: 기본값은 `.bottom`이며 공간이 부족하면 반대편으로 전환합니다.
  ///   - alignment: 기본값은 `.leading`이며 화면 경계를 넘으면 안쪽으로 이동합니다.
  public init(
    size: Size = .medium,
    width: Width = .fixed,
    placement: Placement = .bottom,
    alignment: Alignment = .leading
  ) {
    self.size = size
    self.width = width
    self.placement = placement
    self.alignment = alignment
  }

  /// 메뉴의 글꼴, 여백과 기본 너비를 선택합니다.
  public enum Size: CaseIterable, Hashable, Sendable {
    /// 마우스 조작에 적합한 작은 크기이며 기본 너비는 200pt입니다.
    case small
    /// 터치 조작에 적합한 기본 크기이며 기본 너비는 240pt입니다.
    case medium
  }

  /// 화면의 가용 너비 안에서 메뉴 너비를 결정합니다.
  public enum Width: CaseIterable, Hashable, Sendable {
    /// 크기별 기본 너비를 사용합니다.
    case fixed
    /// 메뉴를 여는 뷰의 너비를 사용합니다.
    case trigger
  }

  /// 메뉴가 먼저 배치를 시도할 세로 방향입니다.
  public enum Placement: CaseIterable, Hashable, Sendable {
    /// 버튼 위쪽을 우선합니다.
    case top
    /// 버튼 아래쪽을 우선합니다.
    case bottom
  }

  /// 읽기 방향을 반영하는 수평 정렬입니다.
  public enum Alignment: CaseIterable, Hashable, Sendable {
    /// 버튼의 시작 가장자리에 맞춥니다.
    case leading
    /// 버튼의 중앙에 맞춥니다.
    case center
    /// 버튼의 끝 가장자리에 맞춥니다.
    case trailing
  }
}
