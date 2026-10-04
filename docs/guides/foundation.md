# Foundation·토큰 개발 규칙

- 토큰은 `Color`, `Font`, `Radius`, `Spacing`에, 기본 구성은 `Theme/Default`에 둡니다.
- `ColorPalette`는 원시 색상 단계이고 `ColorToken`은 foreground·background·border의 의미별 색상입니다.
- 컴포넌트가 사용할 의미를 먼저 정하고, 같은 의미의 기존 토큰이 있으면 재사용합니다.
- 기본값은 `.default` 구성과 일관되게 관리합니다. 테마 주입 없이도 기존 기본 테마로 동작해야 합니다.
- 커스텀 테마로 교체했을 때 새 토큰을 포함해 일관되게 반영되는지 확인합니다.
- 값 타입의 기존 `Hashable`, `Sendable` 계약을 유지합니다. 새로운 저장 프로퍼티와 initializer는 호환성 영향을 검토합니다.
- 색상 변경은 밝은·어두운 모드 및 normal·pressed·disabled 등 사용하는 상태 조합을 확인합니다.
- 타이포그래피의 실제 Font 구성과 크기 동작을 설명합니다. 확인하지 않은 특성을 지원한다고 쓰지 않습니다.

공개 타입·초기화·단위·기본값의 의미는 [DocC 규칙](documentation.md)에 따라 소스에 작성합니다.
조합 사용법은 [Theming](../../Sources/FoundesignFoundation/FoundesignFoundation.docc/Theming.md)에 둡니다.

Color·Font 변경은 해당 Foundation 예제를 갱신합니다. Spacing·Radius를 새롭게 노출하거나 사용법을
바꾸면 비교 가능한 예제를 추가합니다. 페이지 등록 및 [검증](validation.md)을 함께 수행합니다.
