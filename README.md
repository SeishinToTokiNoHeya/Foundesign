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

| 목적 | 문서 |
| --- | --- |
| 시작과 사용법 | [Foundesign DocC](Sources/Foundesign/Foundesign.docc/GettingStarted.md) |
| 테마와 토큰 | [Foundation DocC](Sources/FoundesignFoundation/FoundesignFoundation.docc/FoundesignFoundation.md) |
| 컴포넌트 사용법 | [Component DocC](Sources/FoundesignComponent/FoundesignComponent.docc/FoundesignComponent.md) |
| 기여·개발 규칙 | [문서 안내](docs/README.md) |
| AI 작업 진입점 | [AGENTS.md](AGENTS.md) |

`Example/Example.xcodeproj`를 열어 사용 예제를 실행할 수 있습니다. Example 앱의 실행 대상 OS는
패키지의 최소 지원 OS와 다를 수 있습니다. [빌드·문서 검증 방법](docs/guides/validation.md)을 참고하세요.
