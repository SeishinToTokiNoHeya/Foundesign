# Foundesign

Foundesign은 SwiftUI 앱의 색상, 타이포그래피, 간격과 컴포넌트를 일관되게 구성하는 디자인 시스템입니다.
디자인 토큰과 테마를 바탕으로 iOS와 macOS에서 재사용할 수 있는 UI를 제공합니다.

- [Foundesign 소개](#foundesign-소개)
- [기본 사용법](#기본-사용법)
- [문서 읽기](#문서-읽기)
- [설치](#설치)
- [예제](#예제)
- [AI로 Foundesign 사용하기](#ai로-foundesign-사용하기)
- [기여하기](#기여하기)

## Foundesign 소개

- **디자인 토큰**: 색상, 타이포그래피, 간격, 모서리 값을 공통 기준으로 사용합니다.
- **테마**: SwiftUI 환경에 테마를 주입해 하위 컴포넌트에 같은 디자인 값을 적용합니다.
- **컴포넌트**: 버튼, 아코디언, 체크박스, 텍스트 필드, 다이얼로그, 피커를 조합합니다.

앱에서는 `Foundesign` 하나를 import해 토큰과 컴포넌트를 함께 사용할 수 있습니다.

## 기본 사용법

SwiftUI의 `Button`에 Foundesign 스타일을 적용합니다.

```swift
import Foundesign
import SwiftUI

struct SaveButton: View {
  var body: some View {
    Button("저장") {}
      .buttonStyle(.solid)
      .buttonTone(.brand)
      .buttonSize(.medium)
  }
}
```

## 문서 읽기

GitHub Pages에 배포된 **[컴포넌트 문서](https://seishintotokinoheya.github.io/Foundesign/FoundesignComponent/documentation/foundesigncomponent/)**에서
컴포넌트별 사용 안내와 API를 확인할 수 있습니다.

| 웹 문서 | 내용 |
| --- | --- |
| [Foundesign](https://seishintotokinoheya.github.io/Foundesign/Foundesign/documentation/foundesign/) | 패키지 소개와 시작하기 |
| [FoundesignFoundation](https://seishintotokinoheya.github.io/Foundesign/FoundesignFoundation/documentation/foundesignfoundation/) | 디자인 토큰과 테마 |
| [FoundesignComponent](https://seishintotokinoheya.github.io/Foundesign/FoundesignComponent/documentation/foundesigncomponent/) | 컴포넌트별 사용 안내와 API |

처음 사용한다면 [시작하기](https://seishintotokinoheya.github.io/Foundesign/Foundesign/documentation/foundesign/gettingstarted/)를,
앱의 디자인을 바꾸려면 [테마와 토큰](https://seishintotokinoheya.github.io/Foundesign/FoundesignFoundation/documentation/foundesignfoundation/theming/)을 읽어보세요.

웹 문서는 최신 개발 버전을 기준으로 합니다. 앱에서 사용하는 버전의 동작과 사용 조건은
해당 커밋의 문서와 API 선언을 확인하세요. 저장소의
[시작하기 원문](Sources/Foundesign/Foundesign.docc/GettingStarted.md),
[테마와 토큰 원문](Sources/FoundesignFoundation/FoundesignFoundation.docc/Theming.md),
[컴포넌트 안내 원문](Sources/FoundesignComponent/FoundesignComponent.docc/FoundesignComponent.md)이나
Xcode Quick Help에서도 설명을 읽을 수 있습니다.

## 설치

Swift tools 6.4, iOS 17 이상 또는 macOS 14 이상이 필요합니다.

1. Xcode의 **File → Add Package Dependencies…**에서 아래 저장소 주소를 입력합니다.
2. 사용할 브랜치 또는 커밋을 선택합니다. 현재 버전 태그가 없으므로 개발 버전은 `develop` 브랜치로 추가할 수 있습니다.
3. `Foundesign` 라이브러리를 앱 타깃에 연결합니다.

```text
https://github.com/SeishinToTokiNoHeya/Foundesign.git
```

## 예제

[Example](Example)에는 디자인 토큰과 컴포넌트를 직접 조작할 수 있는 SwiftUI 앱이 있습니다.

- [색상](Example/Example/Pages/Foundation/ColorExamplePage.swift)과 [타이포그래피](Example/Example/Pages/Foundation/FontExamplePage.swift)
- [버튼 스타일](Example/Example/Pages/Component/ButtonStyleExamplePage.swift)
- [아코디언](Example/Example/Pages/Component/AccordionExamplePage.swift)과 [체크박스](Example/Example/Pages/Component/CheckboxExamplePage.swift)
- [텍스트 필드](Example/Example/Pages/Component/TextFieldExamplePage.swift)와 [다이얼로그](Example/Example/Pages/Component/AlertDialogExamplePage.swift)
- [휠 피커와 날짜 피커](Example/Example/Pages/Component/WheelPickerExamplePage.swift)

[Example.xcodeproj](Example/Example.xcodeproj)를 열고 `Example` 스킴으로 실행하세요. Example 앱의 실행 대상 OS는
패키지의 최소 지원 OS와 다를 수 있습니다. [빌드·문서 검증 방법](docs/guides/validation.md)을 참고하세요.

## AI로 Foundesign 사용하기

[Foundesign Skill](skills/foundesign/SKILL.md)은 Foundesign으로 앱 화면을 구현할 때 버전을 확인하고
필요한 문서와 API를 찾아 읽는 절차를 제공합니다. API 설명은 원본 문서에서 확인하도록 안내합니다.

이 저장소를 받은 뒤 `skills/foundesign` 폴더 전체를 사용하는 에이전트의 Skill 설치 위치로
복사하세요. 예를 들어 프로젝트의 Skill을 `.agents/skills/`에서 읽는 에이전트라면,
**Foundesign 저장소 루트에서** 다음처럼 Foundesign을 사용하는 앱 프로젝트에 복사합니다.

```sh
mkdir -p /path/to/your-app/.agents/skills
cp -R skills/foundesign /path/to/your-app/.agents/skills/
```

설치 위치와 새 Skill을 불러오는 방법은 사용하는 에이전트의 안내를 따릅니다. 이미 설치했다면 내용을
확인하고 갱신하세요. 예시 요청: “foundesign Skill을 사용해서 현재 앱의 버전에 맞는 저장 버튼과
커스텀 테마를 적용해줘.” Skill을 자동으로 인식하는지 여부는 에이전트에 따라 다릅니다.

설치 없이 앱에서 사용하는 Foundesign 버전의 README·DocC 원문·소스 주석을 AI에 전달해도 됩니다.
Skill은 필요한 문서를 찾아 읽는 절차를 제공하며 자동 학습을 의미하지 않습니다.

## 기여하기

라이브러리 자체를 수정할 때는 [개발 문서](docs/README.md)와 기여자용
[AGENTS.md](AGENTS.md)를 읽습니다. Foundesign을 사용하는 앱에는 이 저장소의 개발 규칙을 복사하지 않습니다.
