# 빌드·문서 검증

명령은 저장소 루트에서 실행합니다. Swift 6.4를 지원하는 Xcode와 Apple SDK가 필요합니다.
도구 버전은 `swift --version`, `xcodebuild -version`으로 확인합니다.

[현재 개발 정책](development-policy.md)에 따라 접근성 전용 검증과 테스트 코드 작성·도입은
후속 일괄 작업으로 유예합니다. 아래 빌드·문서 검사·예제의 기본 동작 확인은 계속 적용합니다.

## 문서 경로와 기능 색인

```sh
python3 Scripts/validate-docs.py
```

로컬 Markdown 파일 링크, AI 색인의 필수 필드·고유 ID·파일 경로·예제 상태를 확인합니다.
외부 URL, DocC 심볼 링크, 예제의 컴파일이나 동작은 이 검사로 보장하지 않습니다.

## 패키지·DocC

```sh
swift build
bash Scripts/build-docs.sh
```

문서 스크립트는 `swift package dump-symbol-graph`로 패키지를 빌드하고 공개 심볼을 추출한 뒤,
Xcode에 포함된 `docc`로 모듈별 카탈로그를 변환합니다. 추가 패키지 플러그인은 필요하지 않습니다.
문서 경고는 오류로 처리합니다. 결과는 `.build/documentation/<모듈>.doccarchive`에 생성됩니다.
호스트 macOS 기준의 빌드이며 iOS 분기 검증을 대신하지 않습니다.

Xcode에서는 패키지 또는 Example 프로젝트를 열고 해당 패키지 스킴을 선택한 뒤
**Product → Build Documentation**으로 읽을 수 있습니다. 소스의 `///`는 Option-click Quick Help에서도 확인합니다.

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

## 테스트 코드 유예와 결과 기록

현재 패키지에는 테스트 타깃이 없습니다. `swift test`를 기존 검증처럼 기재하지 않습니다.
날짜 보정, 선택 확정, 상태 전환을 포함해 일반 기능 개발이나 버그 수정에서는 테스트 코드·타깃을
추가하지 않습니다. 테스트 코드는 디자인 시스템이 어느 정도 완성된 뒤 별도 작업으로 다룹니다.

결과에는 현재 검증 범위에서 실행한 명령, 성공 여부, 관련 경고, 수동 확인 항목을 적습니다.
정책에 따라 유예한 접근성과 테스트 코드를 누락된 필수 작업으로 보고하지 않습니다. SDK·권한·실행 환경으로
실패하면 코드 실패와 구분하고, 수행하지 못한 검증과 이유를 명시합니다.
