# 빌드·문서 검증

명령은 저장소 루트에서 실행합니다. Swift 6.4를 지원하는 Xcode와 Apple SDK가 필요합니다.
도구 버전은 `swift --version`, `xcodebuild -version`으로 확인합니다.

## 변경에 맞는 검증

| 변경 | 확인할 내용 |
| --- | --- |
| 개발 안내·Markdown 링크 | 변경한 링크의 대상과 삭제·이동한 경로의 잔여 참조 |
| 공개 API 주석·`.docc` | 해당 문서의 DocC 빌드와 진단 |
| Swift 구현·`Package.swift` | 패키지 빌드, 영향받는 플랫폼의 Example 빌드 |
| UI 동작·예제 화면 | Example 실행 후 변경 기능의 조작 결과 |

변경과 무관한 검증을 일괄 실행하거나 전용 검사 도구를 새로 만들지 않습니다.
파일을 삭제·이동하면 `rg` 등으로 이전 경로를 검색하고, 변경한 상대 링크가 실제 파일을 가리키는지 확인합니다.

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

별도 스크립트나 패키지 플러그인은 필요하지 않습니다. 문서 경고는 오류로 처리합니다.
결과는 `.build/documentation/Build/Products/Debug/`의 모듈별 `.doccarchive`에 생성됩니다.
문서 빌드는 DocC 코드 블록을 타입 검사하거나 실행하지 않습니다.

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
