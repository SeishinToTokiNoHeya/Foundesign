# 문서 작업

- 작성·수정 전 [문서 구조](README.md), [DocC 규칙](guides/documentation.md)을 읽습니다.
- AI/MCP 자료는 [AI·MCP 설계](ai/README.md)를 따르고 API 설명을 별도 복제하지 않습니다.
- 디렉토리별 `AGENTS.md`는 짧은 탐색 안내로 유지하고 규칙의 본문은 가이드에 둡니다.
- 새 규칙은 실제 구현과 구분합니다. 아직 없는 기능은 명시적으로 제안이나 후속 작업으로 표시합니다.
- 문서의 상대 경로와 `catalog.json`을 `python3 Scripts/validate-docs.py`로 검증합니다.
- `.docc` 또는 Swift 문서 주석을 바꾸면 [검증 가이드](guides/validation.md)에 따라 DocC를 빌드합니다.
