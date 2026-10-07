# 코드 주석과 DocC 작성

## 한 내용에는 한 원본

| 내용 | 작성 위치 |
| --- | --- |
| API의 목적, 인자, 기본값, 제약, 상태 변화 | 선언 바로 위 `///` |
| 여러 API를 조합하는 사용 흐름 | API가 정의된 모듈의 `.docc` 사용 안내 |
| 모듈 소개와 관련 심볼 분류 | `.docc/<모듈명>.md`의 Overview·Topics |
| 개발 규칙과 검증 방법 | `docs/guides/` |

문서 본문과 주석은 한국어로 작성하고 심볼 이름·경로는 코드와 동일하게 유지합니다.
AI도 같은 원문을 읽습니다. 같은 설명을 여러 파일에 복사하거나 별도 요약본으로 관리하지 않습니다.
문서 탐색에는 기존 README와 DocC의 Topics를 먼저 사용합니다. 별도 안내 파일이 반드시 필요하다면
원문 링크와 각 링크의 용도만 담은 색인으로 작성합니다. API 설명·사용 예제·개발 규칙은 복제하지 않습니다.
`skills/foundesign/SKILL.md`는 Foundesign을 사용하는 앱에서 버전을 확인하고 문서를 찾는 절차만 안내합니다.

## 공개 API 주석

새로 만들거나 동작을 바꾼 공개 타입, initializer, 프로퍼티, enum case, modifier에 적용합니다.
아직 설명이 없는 API는 관련 기능을 수정할 때 우선 보강합니다.

1. 첫 문장은 API가 하는 일을 짧게 설명합니다.
2. 호출자가 알아야 할 바인딩 변경, 환경 상속, 기본값, 빈 입력, 범위 보정, 콜백 순서를 설명합니다.
3. 이름·타입만으로 드러나지 않는 인자의 의미와 제약은 `- Parameters:` 또는 `- Parameter`로 설명합니다.
4. 추가 설명이 필요한 반환값은 `- Returns:`, 실제 throw 조건은 `- Throws:`로 씁니다. 시그니처를 그대로 반복하지 않습니다.
5. 전제 조건 위반으로 실패하는 입력은 `- Precondition:`으로 명시합니다. 구현이 보정하지 않는 값을 보정한다고 쓰지 않습니다.
6. 사용법이 자명하지 않은 타입에는 작은 Swift 예제나 관련 DocC 안내를 연결합니다.

`View.body`, `ButtonStyle.makeBody`, `description` 같은 표준 프로토콜 구현에 같은 설명을
기계적으로 반복하지 않습니다. 추가로 설명할 동작이나 제약이 있으면 타입 또는 진입 API에서 설명합니다.
내부 `//` 주석은 코드가 이미 보여 주는 절차보다 선택한 이유·불변식·플랫폼 제약을 설명합니다.

## DocC 카탈로그

- 모듈마다 `Sources/<모듈>/<모듈>.docc/`를 사용합니다.
- 모듈 소개 페이지의 첫 줄은 아래처럼 실제 모듈 이름을 이중 백틱으로 감싼 제목입니다.
- 같은 모듈의 심볼은 이중 백틱, article은 `<doc:ArticleName>`으로 연결합니다.
- `## Topics` 아래에 사용 흐름과 관련 심볼을 묶습니다. 실제로 존재하는 심볼만 연결합니다.
- 다른 모듈의 API는 해당 API가 정의된 모듈에서 설명합니다. 개별 카탈로그 빌드에서 해결할 수 없는 교차 모듈 링크를 만들지 않습니다.
- Swift 코드 블록에는 필요한 import와 상태를 포함합니다. 일부분만 보여 주면 문맥을 명시합니다.
- 조작 가능한 전체 예제는 Example에 둡니다. DocC는 최소 예제와 설명을 제공하며 변경 시 서로 맞춥니다.
- DocC 빌드는 코드 블록을 실행하거나 타입 검사하지 않습니다. 예제와 같은 API인지 별도로 확인합니다.

```markdown
# ``FoundesignComponent``
```

## 웹과 AI용 문서

세 모듈의 DocC를 공식 명령으로 생성·정적 변환하여 GitHub Pages에 배포합니다.
루트 README에서 모듈별 웹 문서로 직접 연결하며, 별도의 웹 첫 화면은 관리하지 않습니다.
앱 개발자가 API를 찾기 쉽도록 사용 안내에서 관련 심볼을 연결하고 실행 예제는 저장소 링크로 제공합니다.

AI는 Skill의 안내에 따라 앱에서 사용하는 Foundesign과 같은 커밋의 소스 주석과 DocC 원문을 읽습니다.
AI 활용을 이유로 생성 문서의 링크 재작성, 별도 색인·`llms.txt` 생성기, 출력 형식 변환기를
추가하지 않습니다. DocC 출력은 그대로 사용하며, 기본 기능으로 부족하다면 먼저 부가 기능을 줄일 수 있는지 검토합니다.
웹 문서는 최신 개발 버전을 기준으로 하며, 특정 버전의 API 동작과 사용 조건은 해당 커밋의 원문에서 확인합니다.
배포 명령과 확인 방법은 [검증 가이드](validation.md)를 따릅니다.

## 제출 전에

[검증 가이드](validation.md)로 변경한 링크·DocC 진단을 확인합니다. 중요한 API는 Xcode Quick Help에서도
요약과 인자 설명이 보이는지 확인합니다. 생성된 `.doccarchive`, symbol graph, HTML은 원본처럼 커밋하지 않습니다.

공식 문법 참고: [DocC](https://www.swift.org/documentation/docc/),
[심볼 주석 작성](https://developer.apple.com/documentation/xcode/writing-symbol-documentation-in-your-source-files),
[문서 구조와 Topics](https://www.swift.org/documentation/docc/adding-structure-to-your-documentation-pages).
