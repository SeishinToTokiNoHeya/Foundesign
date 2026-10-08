# 빌드·문서 검증

명령은 저장소 루트에서 실행합니다. Swift 6.4를 지원하는 Xcode와 Apple SDK가 필요합니다.
도구 버전은 `swift --version`, `xcodebuild -version`으로 확인합니다.

## 변경에 맞는 검증

| 변경 | 확인할 내용 |
| --- | --- |
| 개발 안내·Markdown 링크 | 변경한 링크의 대상과 삭제·이동한 경로를 여전히 가리키는 링크 |
| Swift 코드·문서의 Swift 예제·포맷 설정 | SwiftFormat 적용·검사와 코드 컨벤션의 수동 확인 항목 |
| 공개 API 주석·`.docc` | 해당 문서의 DocC 빌드와 진단 |
| Swift 구현·`Package.swift` | 패키지 빌드, 영향받는 플랫폼의 Example 빌드 |
| UI 동작·예제 화면 | Example 실행 후 변경 기능의 조작 결과 |

변경과 무관한 검증을 일괄 실행하거나 전용 검사 도구를 새로 만들지 않습니다.
이번 변경으로 생길 수 있는 문제를 확인하는 데 필요한 검증만 실행합니다. 통과하면 마무리하고,
추가 변경이나 실패가 있거나 확인하지 못한 문제가 구체적으로 남아 있을 때만 확대하거나 반복합니다.
문구·링크 수정에 앱 전체 빌드나 모든 플랫폼 검증을 추가하지 않습니다.
일회성 확인이 필요하면 임시 위치에서 수행하고 테스트·검사 스크립트로 저장소에 남기지 않습니다.
파일을 삭제·이동하면 `rg` 등으로 이전 경로를 검색하고, 변경한 상대 링크가 실제 파일을 가리키는지 확인합니다.

## 코드 컨벤션 검증

[SwiftFormat](https://github.com/nicklockwood/SwiftFormat)을 사용합니다.
설정의 최소 버전은 0.58.1이며, 설치가 필요하면 `brew install swiftformat`으로 설치하고
`swiftformat --version`으로 버전을 확인합니다. 별도 래퍼 스크립트나 패키지 의존성은 사용하지 않습니다.

작업을 마치기 전에 변경한 파일 경로를 지정해 아래 순서로 실행합니다.
다음 명령의 `<변경한 파일 경로...>`는 실제 Swift·Markdown 파일 경로로 바꿉니다.

```sh
swiftformat <변경한 파일 경로...> --config .swiftformat --cache ignore
swiftformat <변경한 파일 경로...> --config .swiftformat --cache ignore --lint
git diff --check
```

설정의 `--markdown-files lenient`는 Markdown·DocC의 Swift 코드 블록에도 포맷을 적용하며,
생략된 코드가 있는 블록의 파싱 실패는 건너뛸 수 있습니다. 문서 예제는 직접 확인합니다.
[코드 컨벤션](code-conventions.md#자동-포맷과-수동-확인)의 수동 확인 항목과 실제 diff를 검토하고,
동작·공개 API·예제의 의미가 바뀌지 않았는지 확인합니다.

기존 파일 전체를 일괄 포맷하지 않고 작업에서 변경한 파일부터 적용합니다.
포맷 설정을 바꾸면 임시 Swift·Markdown 예제로 2칸 들여쓰기, 의도한 빈 줄 보존,
여러 줄 case와 짧은 한 줄 반환 case의 공존을 확인합니다. 임시 예제는 저장소에 남기지 않습니다.
도구를 실행할 수 없으면 수동 확인 결과와 실행하지 못한 이유를 기록합니다.

## 패키지 빌드

```sh
swift build
```

호스트 macOS 기준의 빌드이며 iOS 분기 검증을 대신하지 않습니다.

## DocC

Xcode에서 `Example/Example.xcodeproj`를 열고 `Foundesign` 스킴을 선택한 뒤
**Product → Build Documentation**으로 빌드합니다. 소스의 `///`는 Option-click Quick Help에서도 확인합니다.

명령줄에서는 Xcode의 같은 기능을 사용합니다.

```sh
xcodebuild docbuild -project Example/Example.xcodeproj -scheme Foundesign \
  -destination 'generic/platform=macOS' -derivedDataPath .build/documentation \
  CODE_SIGNING_ALLOWED=NO OTHER_DOCC_FLAGS='--warnings-as-errors'
```

로컬 DocC 빌드에는 별도 패키지 플러그인이 필요하지 않습니다. 문서 경고는 오류로 처리합니다.
결과는 `.build/documentation/Build/Products/Debug/`의 모듈별 `.doccarchive`에 생성됩니다.
문서 빌드는 DocC 코드 블록을 타입 검사하거나 실행하지 않습니다.

## 웹 배포 검증

`.github/workflows/documentation.yml`에서 `xcodebuild docbuild`와 DocC의
`transform-for-static-hosting`을 직접 실행합니다. 별도 생성·후처리 스크립트는 사용하지 않습니다.
모듈별 산출물을 `.build/site/<모듈>/`에 배치합니다. 생성물은 커밋하지 않습니다.

현재 기본 브랜치 `develop`의 문서 관련 변경이 있거나 수동으로 실행했을 때 빌드하며 PR에서는 배포하지 않습니다.
기본 브랜치를 바꾸면 workflow의 push 필터도 함께 변경합니다.
`xcode-27` runner에서 Xcode 27.0과 Swift 6.4를 사용합니다.
첫 배포에는 저장소 Settings → Pages의 Source를 **GitHub Actions**로 설정해야 합니다.
빌드가 실패하면 배포하지 않으므로 기존 공개 사이트는 유지됩니다.

배포 명령이나 경로를 변경하면 workflow의 공식 명령으로 문서를 생성합니다.
문서 링크만 바꿨다면 해당 주소가 생성된 문서를 가리키는지 확인합니다. 모든 API를 순회하는 별도 검사기는 추가하지 않습니다.
공개 문서 주소는 [README](../../README.md#문서-읽기)에서 관리합니다. 사이트 루트에는 별도 첫 화면이 없습니다.
배포 후 실제 접근을 확인한 경우에만 공개 배포 검증이 완료되었다고 보고합니다. 주소 변경 시 workflow의 hosting base path와
README·Skill·DocC의 웹 링크를 함께 갱신합니다.

## Example과 플랫폼

먼저 `xcodebuild -list -project Example/Example.xcodeproj`로 사용 가능한 스킴을 확인합니다.
현재 앱 스킴은 `Example`입니다.

```sh
xcodebuild -project Example/Example.xcodeproj -scheme Example \
  -destination 'generic/platform=macOS' -derivedDataPath .build/Example-macOS \
  CODE_SIGNING_ALLOWED=NO build

xcodebuild -project Example/Example.xcodeproj -scheme Example \
  -destination 'generic/platform=iOS Simulator' -derivedDataPath .build/Example-iOS \
  CODE_SIGNING_ALLOWED=NO build
```

소스나 플랫폼 구현을 바꿨다면 해당 빌드를 실행합니다. UI 동작을 바꿨다면 Xcode에서 Example을
실행해 페이지 진입, 상태 변경, 영향받는 테마와 변경 기능의 기본 동작을 확인합니다.
빌드 성공과 실제 실행 확인을 구분해서 기록합니다.

## 결과 기록

실행한 검증, 성공 여부와 남은 문제를 짧게 기록합니다. 필요한 검증을 수행하지 못했다면 이유를 명시하고,
SDK·권한·실행 환경의 문제는 코드 실패와 구분합니다.
[현재 개발 정책](development-policy.md)에 따라 유예한 항목을 누락된 필수 작업으로 보고하지 않습니다.
