# Foundesign 작업 안내

SwiftUI 디자인 시스템 패키지입니다. 이 파일은 공통 규칙과 탐색 경로만 유지합니다.
세부 규칙을 여기에 복사하지 말고, 작업 대상에 해당하는 문서만 읽으세요.

## 작업 시작

1. 변경할 디렉토리의 `AGENTS.md`와 아래 연결 문서를 읽습니다.
2. 기존 API, 인접 구현, 연결된 예제를 확인한 뒤 변경합니다.
3. 새 디렉토리나 가이드가 생기면 해당 범위의 안내와 색인을 갱신합니다.

| 작업 대상 | 읽을 안내 |
| --- | --- |
| 모듈 구조, `Package.swift` | [아키텍처](docs/architecture.md) |
| `Sources/FoundesignFoundation/` | [Foundation 안내](Sources/FoundesignFoundation/AGENTS.md) |
| `Sources/FoundesignComponent/` | [Component 안내](Sources/FoundesignComponent/AGENTS.md) |
| `Sources/Foundesign/` | [진입 모듈 안내](Sources/Foundesign/AGENTS.md) |
| `Example/` | [예제 안내](Example/AGENTS.md) |
| 문서, 주석, `.docc`, `docs/`, `Scripts/` | [문서 안내](docs/AGENTS.md) |
| 향후 MCP, AI용 검색 자료 | [AI·MCP 문서 설계](docs/ai/README.md) |

## 공통 완료 조건

- 변경한 공개 API의 계약을 `///` 주석에 반영합니다. [DocC 규칙](docs/guides/documentation.md)을 따릅니다.
- 기능 추가·변경은 실행 가능한 예제에도 반영합니다. [예제 기준](docs/guides/examples.md)에 따라 새 화면은 탐색에 등록합니다.
- 관련 DocC 안내와 [기능 색인](docs/ai/catalog.json)의 경로를 함께 갱신합니다.
- [검증 가이드](docs/guides/validation.md)의 해당 검증을 실행하고, 실행하지 못한 항목을 명시합니다.
- 지원 플랫폼, 공개 API, 동작을 문서 작업에 섞어 임의로 바꾸지 않습니다.

## 컨텍스트 관리

- 모든 문서를 한꺼번에 읽지 않습니다. 색인에서 필요한 기능과 경로를 선택합니다.
- 구현은 Swift 소스, API 계약은 인접 `///`, 사용 흐름은 DocC, 기여 규칙은 `docs/guides/`에 둡니다.
- 현재 동작과 제안·미구현 상태를 구분하며, 존재하지 않는 API·예제·검증 결과를 작성하지 않습니다.
