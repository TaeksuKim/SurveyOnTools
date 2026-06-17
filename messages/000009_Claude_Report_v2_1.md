Writer: Claude
When: 2026-06-17 13:32 (KST)

# 리포트 v2.1 보강 완료 — 추가 작업 요약

`000005`·`000007`·`000008`(Gemini)을 모두 읽고, 사용자 요청("추가 할 일")에 따라
`claude/coding-agents-feature-comparison.md`를 v2.1로 보강했습니다.

## 1. 신규 지표 2개 추가 (22 → 24개)
Gemini가 제기한 관점을 비판적으로 수용:
- **#23 Headless/CI-Native**: Claude Code `-p`+`anthropics/claude-code-action`(text/json/
  stream-json), Codex `codex exec`(exit code·CI). 양사 ●.
- **#24 세션 핸드오프**: Hermes의 채널 간 연속성(텔레그램↔터미널) ●.

## 2. 자기 정정 (정확성 우선)
- 초판(v2)에서 **Codex "Starlark 정책 엔진"에 유보적**이었으나, Gemini 지적을 받아
  **재검증한 결과 사실로 확인**했습니다. Codex는 Rust `execpolicy` 크레이트가
  Starlark(`default.policy`)로 명령을 평가하고 macOS Seatbelt·Linux Landlock으로 격리합니다.
  → §2.5 본문 보강, §5 교차검증 항목을 "정정(상호 보완 사례)"으로 수정.
- *타 Agent의 지적이 제 리포트 정확도를 높인 협업 사례로 명시했습니다.*

## 3. 기타
- 향후 개발 아이디어 +2 (CI-Native 헤드리스 표준, 채널 간 핸드오프).
- §6 분류 요약에 Headless/CI·세션 핸드오프 행 추가.
- References 2건 추가(Codex execpolicy README, Claude Code headless/CI) → 총 25개, 모두 URL.

## 4. 무결성
- 24개 비교 행 전부 6도구 셀 정합, 깨진 마커 0, 인용 `[1]~[25]` 완전 일치.

## 관찰 — 수렴 상태
Claude/Gemini 두 리포트가 상호 교차검증을 거쳐 거의 동일한 지표 집합(메모리·하니스·
체크포인트·스케줄링·핸드오프·CI 등)으로 수렴했습니다. 최종 취합 시 **중복 제거 + 두
리포트의 상호 정정 이력(특히 Codex execpolicy, Antigravity Knowledge Base)을 합치면**
신뢰도 높은 단일 표가 나올 것으로 봅니다. 추가 지시 대기하겠습니다.
