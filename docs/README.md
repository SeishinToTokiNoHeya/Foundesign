# 문서 안내

## 읽는 목적에 따른 진입점

| 목적 | 원본 위치 | 읽는 방법 |
| --- | --- | --- |
| 프로젝트 사용 시작 | [Foundesign DocC](../Sources/Foundesign/Foundesign.docc/GettingStarted.md) | import와 작은 사용 예제부터 읽기 |
| API의 정확한 계약 | `Sources/`의 공개 선언 위 `///` | Xcode Quick Help 또는 생성된 DocC에서 확인 |
| 여러 API의 조합 | 각 모듈의 `.docc` | 사용 시나리오와 관련 심볼 따라가기 |
| 기여 규칙 | 이 디렉토리의 `guides/` | 작업에 필요한 가이드만 읽기 |
| AI의 작업 경로 탐색 | [루트 AGENTS](../AGENTS.md), 디렉토리별 AGENTS | 변경 범위에서 필요한 가이드로 이동 |
| 향후 기계 검색 | [기능 색인](ai/catalog.json) | 안정적인 ID로 소스·DocC·예제 찾기 |

## 개발 가이드

- [아키텍처와 현재 코드 지도](architecture.md)
- [디자인 컴포넌트 개발](guides/components.md)
- [Foundation·토큰 개발](guides/foundation.md)
- [코드 주석과 DocC 작성](guides/documentation.md)
- [예제 반영과 등록](guides/examples.md)
- [빌드·문서 검증](guides/validation.md)
- [AI·MCP 문서 설계](ai/README.md)

## 현재 코드에서 시작하는 개선 순서

이번 문서 구조는 각 모듈의 DocC 진입점과 사용 안내, 주요 진입 API의 주석을 제공합니다.
기존의 모든 공개 멤버가 같은 수준으로 문서화된 상태는 아닙니다. 이후 변경하는 API부터
초기화 조건·바인딩 변경 시점·환경 상속·플랫폼 차이를 보강합니다.

1. DatePicker의 날짜 보정, WheelPicker의 선택 확정, AlertDialog의 닫힘 순서처럼 오해하기 쉬운 계약을 우선 관리합니다.
2. Color·Typography 예제를 기준으로 Spacing·Radius의 시각 비교 예제를 확장합니다.
3. Fog는 WheelPicker 구현에서 사용하지만 독립적인 공개 API 예제는 없습니다. Fog 기능을 변경할 때 직접 사용 예제를 추가합니다.
4. CI와 문서 게시가 필요해지면 현재 로컬 검증 명령을 자동화합니다. 문서 게시나 MCP 서버는 아직 구현하지 않았습니다.

사람용·AI용 API 설명을 각각 작성하면 불일치가 생기기 쉽습니다. 같은 계약과 사용 예제를 공유하고,
사람에게는 DocC 탐색 화면을, AI에게는 작은 검색 색인과 필요한 원문 조각을 제공하는 방식을 권장합니다.
