# 아키텍처와 코드 지도

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

## 컴포넌트의 실제 구성

| 디렉토리 | 주된 구성·주의점 | 예제 |
| --- | --- | --- |
| `Button/` | `Style`, `Property`, `Group`; 표준 ButtonStyle 확장 | ButtonStyleExamplePage |
| `Accordion/` | Item, 전용 builder, 환경 크기·스타일 | AccordionExamplePage |
| `Checkbox/` | 단일·복수 바인딩, 그룹, 환경 속성 | CheckboxExamplePage |
| `AlertDialog/` | Container, FooterBuilder, Presentation 및 UIKit/AppKit | AlertDialogExamplePage |
| `WheelPicker/` | Container·Column, Scroll 및 UIKit/AppKit | WheelPickerExamplePage |
| `DatePicker/` | WheelPicker 조합, 그레고리력 날짜 보정 | WheelPickerExamplePage 안의 날짜 예제 |
| `Fog/` | 그라디언트 뷰와 View modifier | 독립 사용 예제 없음 |

실제 파일 경로는 [기능 색인](ai/catalog.json)에 있습니다. `Group`, `Item`, `Property`, `Style`,
`Presentation`, `Scroll`은 이미 사용하는 구분이며 새 컴포넌트에 모두 만들 필요는 없습니다.

## 유지할 설계 방향

- 디자인 값은 `FoundesignTheme`으로 주입하고 컴포넌트는 `@Environment(\.theme)`에서 읽습니다.
- 입력 상태는 호출자의 Binding으로 표현하고 시각적 일시 상태와 구분합니다.
- 플랫폼 구현은 해당 `UIKit/`, `AppKit/` 하위에 두고 공통 API와 상태 계약을 공유합니다.
- 예제는 라이브러리 내부 접근 없이 공개 API로 구성합니다.

현재 `Tests/`와 테스트 타깃, 문서 게시 자동화, MCP 서버는 없습니다.
패키지 최소 지원 OS와 Example 앱의 배포 설정은 서로 다르므로 별도로 확인합니다.
