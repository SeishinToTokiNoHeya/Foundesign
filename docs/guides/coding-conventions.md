# Swift 코드 컨벤션

`Sources/`, `Example/`, `Package.swift`를 포함한 저장소의 Swift 코드에 적용합니다.
코드 배치는 swift-format으로 통일하고, 이름은 기존 API와 인접 구현의 용어를 따릅니다.

## 포맷 기준

저장소 루트의 [`.swift-format`](../../.swift-format)을 설정 원본으로 사용합니다.
들여쓰기는 공백 2칸, 줄 길이는 100자를 기준으로 하며 나머지는 swift-format 기본값을 사용합니다.
줄 길이는 포매터의 줄바꿈 기준입니다. 문자열이나 분리할 수 없는 토큰까지 강제로 자르지 않습니다.

- 줄바꿈·공백·중괄호 배치·import 정렬은 포매터 결과를 따릅니다.
- 의미 단위를 나누는 기존 줄바꿈은 기본 설정이 허용하는 범위에서 유지합니다.
- 편집기의 Swift 들여쓰기도 탭 대신 공백 2칸으로 설정합니다.
- 포매터가 자동으로 고치지 못하는 lint 진단은 내용을 확인하고 직접 수정합니다.

프로젝트에서 사용하는 Xcode의 `swift format`을 실행합니다. 도구 버전은
`swift --version`과 `swift format --version`으로 확인합니다. 명시하지 않은 기본 규칙은
도구 버전에 따라 달라질 수 있으므로 같은 Xcode 버전을 사용합니다.

## 이름과 선언

- 타입·프로토콜은 `UpperCamelCase`, 프로퍼티·함수·인자·enum case는 `lowerCamelCase`로 씁니다.
- 같은 역할에는 기존 API의 용어를 사용합니다. 포맷 정리를 이유로 공개 API 이름을 바꾸지 않습니다.
- 약어보다 역할을 드러내는 이름을 사용하고, 호출 위치에서 이미 드러나는 타입 이름을 불필요하게 반복하지 않습니다.
- 접근 수준은 각 선언에 명시하고 외부 사용에 필요한 선언만 공개합니다.
  `public extension`으로 묶기보다 extension 안의 공개 멤버에 `public`을 붙입니다.
- enum case와 변수 선언은 한 줄에 하나씩 작성합니다.

컴포넌트의 API 설계는 [컴포넌트 개발 규칙](components.md),
주석과 공개 API 설명은 [문서 규칙](documentation.md)을 따릅니다.

## 적용과 확인

저장소 루트에서 변경한 Swift 파일을 지정합니다. 아래 `path/to/File.swift`는 실제 변경 파일 경로로 바꿉니다.

```sh
swift format format --configuration .swift-format --in-place path/to/File.swift
swift format lint --configuration .swift-format --strict path/to/File.swift
```

전체 현황을 확인할 때는 다음 명령을 사용합니다. 파일은 수정하지 않습니다.

```sh
swift format lint --configuration .swift-format --strict --recursive Sources Example Package.swift
```

기존 코드 전체가 이 규칙을 만족한다고 가정하지 않습니다. 일반 기능 변경에서는 변경한 파일에
적용하고 diff를 확인합니다. 저장소 전체 재포맷은 별도 작업으로 진행합니다.
포맷 검사와 빌드 검증은 목적이 다르며, 구현 변경의 검증은 [검증 가이드](validation.md)를 따릅니다.

설정 항목의 의미는 [swift-format 공식 설정 문서](https://github.com/swiftlang/swift-format/blob/main/Documentation/Configuration.md)를 참고합니다.
