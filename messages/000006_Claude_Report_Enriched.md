Writer: Claude
When: 2026-06-17 12:58 (KST)

# 리포트 보강 완료 (v2) — 작업 요약

요청하신 대로 추가 고급 기능을 더 발굴하고, 다른 Agent(Gemini)의 결과를
비판적으로 참고하여 `claude/coding-agents-feature-comparison.md`를 v2로 보강했습니다.

## 1. 비교 지표 확대 (12 → 22개)
기존 핵심 12개에 더해 **확장 고급 기능 10개**를 추가했습니다:
- Planning Mode, 체크포인트/롤백(rewind), 백그라운드/장기 실행, 작업 스케줄링(cron),
  브라우저 자동화/Computer Use, 코드 인텔리전스(LSP/AST), 커스텀 슬래시 커맨드,
  검증/자가 테스트(Critic·verify), Git/Worktree 격리, 팀/공유 메모리.
- 또한 핵심 표에 **샌드박싱/권한 보안**, **멀티모달(vision·음성)**을 분리 추가.
- "한눈에 보는" 가독성을 위해 표를 **핵심(12) / 확장(10) 2개**로 분할.

## 2. 신규 조사로 확인한 기능들 (출처 부기)
- **Claude Code**: Plan Mode(read-only), `/rewind` 체크포인트 복원, 슬래시 커맨드.
- **Codex CLI**: `codex exec` 무인 실행(cron/CI), 3축 보안(approval·sandbox·network), `/mode`.
- **Antigravity**: **Knowledge Base(학습을 코어 프리미티브로 취급)**, Mission Control의
  Manager·Writer·Critic·Tester, 비동기 서브에이전트, scheduled tasks, 음성 명령, 내장 브라우저.
- **Hermes**: 자연어 cron 스케줄러, 풀 브라우저 자동화, vision·이미지·TTS.

## 3. Gemini 리포트 비판적 교차검증 (§5 신설)
- **합치**: Harness-first, 2-모델 메모리, 5계층 압축, Hermes 폐루프, oh-my-openagent LSP+AST 등.
- **보정 ①**: Gemini의 "Max Context" 하드 넘버(예: ~128k)는 **모델 의존적**이라 도구 고정
  속성으로 단정하기 부적절 → 해당 행 제외, Compaction·라우팅으로 대체 평가.
- **보정 ②**: Antigravity 메모리 등급을 Knowledge Base 근거로 **◐→● 상향**.
- **보정 ③**: Gemini References의 URL 누락분을 본 리포트는 **확인 가능한 URL 23개**로 보강.
- **보정 ④**: Codex "Starlark 정책 엔진" 주장은 1차 출처 확인 곤란 → 공식 문서가 보증하는
  3축 제어로 기술.

## 4. 무결성 확인
- 22개 비교 행 전부 6개 도구 셀 정합, 깨진 마커 없음, 인용 `[n]`↔References(1~23) 일치.
- 향후 개발 아이디어를 10개로 확장(체크포인트, 팀/공유 메모리 미개척 기회 등 포함).

추가 지시가 없으면 최종 취합을 기다리겠습니다.
