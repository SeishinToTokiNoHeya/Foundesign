# Foundesign

SwiftUI 앱에서 사용하는 디자인 토큰과 재사용 가능한 컴포넌트 패키지입니다.
Swift tools 6.4, iOS 17 이상, macOS 14 이상을 기준으로 합니다.

앱에는 `Foundesign` 라이브러리를 연결하고 `import Foundesign`으로 사용합니다.

```swift
import Foundesign
import SwiftUI

struct SaveButton: View {
  var body: some View {
    Button("저장") {}
      .buttonStyle(.solid(tone: .brand, size: .medium))
  }
}
```

## 문서 읽기

| 문서 | 저장소 원문 | 웹 DocC |
| --- | --- | --- |
| 시작하기 | [원문](Sources/Foundesign/Foundesign.docc/GettingStarted.md) | [웹에서 읽기](https://seishintotokinoheya.github.io/Foundesign/Foundesign/documentation/foundesign/gettingstarted/) |
| 테마와 토큰 | [원문](Sources/FoundesignFoundation/FoundesignFoundation.docc/Theming.md) | [웹에서 읽기](https://seishintotokinoheya.github.io/Foundesign/FoundesignFoundation/documentation/foundesignfoundation/theming/) |
| 컴포넌트 안내 | [원문](Sources/FoundesignComponent/FoundesignComponent.docc/FoundesignComponent.md) | [웹에서 읽기](https://seishintotokinoheya.github.io/Foundesign/FoundesignComponent/documentation/foundesigncomponent/) |

웹 DocC는 GitHub Pages 첫 배포 후 사용할 수 있습니다.

웹 문서는 최신 개발 버전을 기준으로 합니다. 앱에서 사용하는 버전의 동작과 사용 조건은
해당 커밋의 문서와 API 선언을 확인하세요. 소스의 `///` 주석, Xcode Quick Help 또는
생성된 DocC에서 자세한 설명을 읽을 수 있습니다.

`Example/Example.xcodeproj`를 열어 사용 예제를 실행할 수 있습니다. Example 앱의 실행 대상 OS는
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
