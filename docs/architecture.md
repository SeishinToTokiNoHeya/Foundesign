# 모듈 구조

## 모듈 경계

`Package.swift`가 제품·의존성·최소 지원 OS의 기준입니다.
현재 하나의 라이브러리 제품 `Foundesign`과 세 타깃이 있습니다.

| 모듈 | 역할 | 프로젝트 내부 의존성 |
| --- | --- | --- |
| `FoundesignFoundation` | 색상·간격·모서리·타이포그래피 토큰, 테마와 환경 주입 | 없음 |
| `FoundesignComponent` | 토큰을 소비하는 SwiftUI 컴포넌트와 플랫폼 어댑터 | Foundation |
| `Foundesign` | 두 모듈을 재수출하는 소비자 진입점 | Component, Foundation |

새 구현은 소유 모듈에 둡니다. Foundation에서 Component를 참조하지 않습니다.
`Sources/Foundesign/Export.swift`의 재수출을 이유로 모든 DocC를 그 모듈에 모으지 않습니다.
심볼 문서는 실제 선언이 있는 모듈에서 생성합니다.

컴포넌트는 `Sources/FoundesignComponent/<기능>/`, 토큰은 `Sources/FoundesignFoundation/`에서 찾습니다.
기능별 사용법은 각 모듈 DocC의 Topics에서, 실행 예제는 `Example/Example/Pages/`에서 찾습니다.
컴포넌트 내부 파일 구분은 [컴포넌트 개발 규칙](guides/components.md)을 따릅니다.

## 유지할 설계 방향

- 디자인 값은 `FoundesignTheme`으로 주입하고 컴포넌트는 `@Environment(\.theme)`에서 읽습니다.
- 입력 상태는 호출자의 Binding으로 표현하고 시각적 일시 상태와 구분합니다.
- 플랫폼 구현은 해당 `UIKit/`, `AppKit/` 하위에 두고 공통 API와 상태 계약을 공유합니다.
- 예제는 라이브러리 내부 접근 없이 공개 API로 구성합니다.

패키지 최소 지원 OS와 Example 앱의 배포 설정은 서로 다르므로 별도로 확인합니다.
