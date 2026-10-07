---
name: foundesign
description: Foundesign을 사용하는 SwiftUI 앱의 화면을 구현하거나 수정할 때, 앱의 패키지 리비전에 맞는 컴포넌트·토큰·사용 안내를 찾아 적용합니다. Foundesign 라이브러리 자체의 개발 규칙은 해당 저장소의 AGENTS.md를 따릅니다.
---

# Foundesign으로 화면 구현하기

## 앱이 사용하는 버전 확인

Foundesign을 사용하는 앱 프로젝트의 작업 지침을 먼저 읽습니다. `Package.swift`, Xcode 프로젝트의 패키지 참조와
`Package.resolved`에서 Foundesign의 URL, 버전, 브랜치와 실제 리비전(커밋)을 확인합니다.
로컬 패키지라면 연결된 경로의 소스와 변경 상태를 기준으로 합니다.
사용 중인 커밋을 확인할 수 없다면 최신 버전이라고 가정하지 않습니다.
해당 앱에서 평소 사용하는 방법으로 패키지 의존성을 내려받아 버전을 확인합니다.

공식 저장소: https://github.com/SeishinToTokiNoHeya/Foundesign

## 필요한 문서만 읽기

1. 앱에 연결된 로컬 패키지 또는 Xcode/SwiftPM 체크아웃을 찾아 실제 리비전이 일치하는지 확인합니다.
   Skill 설치 폴더 옆에 Foundesign 소스가 있다고 가정하지 않습니다.
2. 처음 사용하면 패키지의 `README.md`와 Foundesign 모듈의 `Foundesign.docc/GettingStarted.md`를 읽습니다.
   모듈 카탈로그는 `Sources/<모듈>/<모듈>.docc/`에 있습니다.
3. 토큰과 테마는 Foundation 모듈, 컴포넌트는 Component 모듈의 DocC 모듈 소개 페이지에서
   필요한 사용 안내를 선택합니다. 정확한 인자·기본값·바인딩 변경·입력 제약은 공개 선언의 `///`와 구현으로 확인합니다.
4. 로컬 소스가 없으면 앱에서 사용하는 Foundesign과 **같은 커밋**의 원문을 공식 저장소에서 읽습니다.
   주소는 `https://github.com/SeishinToTokiNoHeya/Foundesign/blob/<revision>/<path>` 형식입니다.
   필요한 파일만 탐색하고 저장소 전체를 읽지 않습니다.

웹 문서 링크는 [저장소 README](https://github.com/SeishinToTokiNoHeya/Foundesign#문서-읽기)에서 찾습니다.

웹 문서는 최신 개발 버전을 살펴보는 보조 자료입니다. 앱에서 사용하는 Foundesign과 같은
버전이라고 가정하지 않습니다. API의 존재와 동작·사용 조건은 앱에 연결된 소스 또는 같은 커밋의 저장소 원문으로
확인합니다. 웹에 접근할 수 없어도 원문으로 작업을 계속합니다.

## 구현하고 확인하기

앱에서는 `import Foundesign`을 사용합니다. 기존 컴포넌트와 의미별 테마 토큰으로 요청한 화면을
구성하고, 상태를 관리할 위치와 바인딩 변경 시점은 API 문서의 설명을 따릅니다.
화면 전체를 구성하는 예제가 필요하면 같은 리비전의 `Example`에서 해당 화면을 확인합니다.
문서에 없는 API나 지원 동작을 추측해 만들지 않습니다.

해당 앱의 빌드·검증 방법으로 변경을 확인하고, 검증한 내용과 실행하지 못한 내용을 구분해 보고합니다.
Foundesign 저장소의 개발 정책을 해당 앱에 그대로 적용하지 않습니다.
