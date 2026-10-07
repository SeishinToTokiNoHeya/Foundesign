# Foundesign 작업 안내

SwiftUI 디자인 시스템 패키지입니다. 이 파일은 공통 규칙과 탐색 경로만 유지합니다.
세부 규칙을 여기에 복사하지 말고, 작업 대상에 해당하는 문서만 읽으세요.

## 작업 시작

1. 변경할 디렉토리의 `AGENTS.md`와 아래 연결 문서를 읽습니다.
2. 기존 API, 인접 구현, 연결된 예제를 확인한 뒤 변경합니다.
3. 파일 탐색은 디렉토리와 검색을 사용하고, 작업에 필요한 문서만 읽습니다.

| 작업 대상 | 읽을 안내 |
| --- | --- |
| 모듈 구조, `Package.swift` | [아키텍처](docs/architecture.md) |
| `Sources/FoundesignFoundation/` | [Foundation 안내](Sources/FoundesignFoundation/AGENTS.md) |
| `Sources/FoundesignComponent/` | [Component 안내](Sources/FoundesignComponent/AGENTS.md) |
| `Sources/Foundesign/` | [진입 모듈 안내](Sources/Foundesign/AGENTS.md) |
| `Example/` | [예제 안내](Example/AGENTS.md) |
| 문서, 주석, `.docc`, `docs/` | [문서 안내](docs/AGENTS.md) |
| 개발 단계·접근성·테스트 코드·GitHub 리뷰 | [현재 개발 정책](docs/guides/development-policy.md) |

## 작업 범위와 단순함

- 요청한 문제를 해결하는 데 필요한 변경만 합니다. 향후 확장 가능성만으로 추상화·설정·의존성·자동화를 추가하지 않습니다.
- 기존 코드와 Swift·SwiftUI·Xcode·DocC의 기본 기능을 먼저 사용합니다. 보조 스크립트·자동화 도입 기준은 [현재 개발 정책](docs/guides/development-policy.md)을 따릅니다.
- 요청에 없는 AI용 색인, MCP 설계, 전용 검증 스크립트, 계획 문서를 미리 만들지 않습니다. 일회성 확인 코드를 저장소의 유지보수 대상으로 남기지 않습니다.
- 파일·계층·프로토콜·래퍼는 책임이나 실제 사용처가 필요할 때 나눕니다. 한 번 쓰는 로직을 미래의 재사용을 위해 범용화하지 않습니다.
- API의 동작과 사용 조건은 소스의 `///`, 사용 흐름은 DocC, 작업 규칙은 기존 가이드에 둡니다. 같은 내용을 여러 문서에 복제하지 않습니다. 필요한 색인은 원문 링크와 용도만 담고, [문서 규칙](docs/guides/documentation.md)을 따릅니다.
- 단순화할 때는 실제 동작에 필요한 상태 관리·입력 제약·플랫폼 처리를 보존합니다. 공개 API와 동작 변경은 요청 범위에서만 합니다.

## 현재 개발 단계

- 접근성과 테스트 코드는 디자인 시스템이 어느 정도 완성된 뒤 별도 작업으로 일괄 진행합니다.
- 현재 기능 개발에는 접근성 전용 구현·검증이나 테스트 코드 작성을 추가하지 않습니다. 빌드·문서 검사·예제 반영은 유지합니다.

## Code Review Rules

- GitHub Codex 리뷰에서 접근성과 테스트 코드 관련 사항은 리뷰 대상에서 제외합니다. 미구현·부족·개선 필요성을 지적하거나 추가를 요구하지 않습니다.
- 리뷰 제목, 본문, 인라인 코멘트, 요약은 모두 한국어로 작성합니다. 코드 식별자와 경로는 원문을 유지합니다.
- 나머지 기능의 실제 동작 오류, 빌드 실패, 공개 API 호환성, 문서·예제 불일치를 검토합니다. 상세 범위는 [현재 개발 정책](docs/guides/development-policy.md)을 따릅니다.

## 공통 완료 조건

- 변경한 공개 API의 동작과 사용 조건은 `///`에, 사용 흐름 변경은 관련 DocC에 반영합니다. [DocC 규칙](docs/guides/documentation.md)을 따릅니다.
- 기능 추가·사용법 변경은 실행 가능한 예제에도 반영합니다. 기존 예제로 충분하면 그대로 확인하고, 새 화면은 [예제 기준](docs/guides/examples.md)에 따라 탐색에 등록합니다.
- [검증 가이드](docs/guides/validation.md)의 해당 검증을 실행하고, 실행하지 못한 항목을 명시합니다.
- 지원 플랫폼, 공개 API, 동작을 문서 작업에 섞어 임의로 바꾸지 않습니다.
- 현재 동작과 제안·미구현 상태를 구분하며, 존재하지 않는 API·예제·검증 결과를 작성하지 않습니다.
