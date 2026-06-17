# Coding Agents 기능 비교 — 최종 리포트 (draft)

> 범용 Coding Agents(**Claude Code**, **Codex CLI**, **Antigravity**)와 특수 목적
> Agents(**OpenClaw**, **oh-my-openagent**, **Hermes Agent**)의 **고급 기능**을 비교·분석하고
> 차세대 도구 설계 아이디어를 도출하는 최종 보고서.
>
> **작성:** Claude(취합) + Gemini(특수목적 심층) · **기준일:** 2026-06-17 · **상태:** draft
> **데이터 원본(단일 진실):** 비교 매트릭스·검증 이력은 `merged/master-comparison.md` 참조.
> 본 문서는 그 데이터를 바탕으로 한 *서술형 분석 + 심층 코멘트*다.

## 목차
1. Executive Summary
2. 한눈에 보는 비교표 (요약 — 전체는 master-comparison.md)
3. 범용 3종 심층 코멘트
4. 특수목적 3종 심층 코멘트 *(Gemini 작성 예정)*
5. 차세대 도구 설계 아이디어
6. References

---

## 1. Executive Summary

- **범용 3종은 "인프라 성숙도"가 강점**(메모리·압축·하니스·샌드박싱·체크포인트). Claude Code가
  가장 포괄적, Codex는 무인 실행·정책엔진, Antigravity는 Knowledge Base·역할분담 병렬·브라우저.
- **특수 3종은 "뾰족한 한 방"**: OpenClaw=스킬 생태계/프로필 배포, oh-my-openagent=토큰최적
  하니스/멀티모델 라우팅/LSP·AST, Hermes=자기개선 학습 루프/다채널/세션 핸드오프/cron.
- **단일 승자 없음** — 용도(인프라·안전 vs 벤더중립·비용·자율·다채널)에 따라 적합 도구가 갈린다.
- **최대 기회**: *팀/공유 메모리*는 거의 모든 도구의 공백이며, CI-Native 헤드리스 표준화와 함께
  차세대 차별점이 될 수 있다.

---

## 2. 한눈에 보는 비교표 (요약)

전체 21개 지표 × 3분할(Core / Harness&Ops / UX&Ecosystem) 매트릭스는
**`merged/master-comparison.md §1`** 에 있다(단일 진실 원본). 아래는 대표 12개 요약.

**범례:** ● 1급 · ◐ 부분 · ○ 미지원/미확인

| 대표 지표 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes |
|------|:--:|:--:|:--:|:--:|:--:|:--:|
| Agentic Memory | ● | ● | ● | ◐ | ◐ | ● |
| 자기개선 학습 루프 | ◐ | ◐ | ◐ | ○ | ○ | ● |
| Context Compaction | ● | ◐ | ◐ | ◐ | ● | ◐ |
| Harness/Hooks | ● | ◐ | ◐ | ◐ | ● | ◐ |
| 샌드박싱·권한 | ● | ● | ● | ◐ | ◐ | ◐ |
| 체크포인트/롤백 | ● | ◐ | ● | ○ | ○ | ○ |
| 멀티/서브 에이전트 | ● | ◐ | ● | ● | ● | ● |
| 멀티모델 라우팅 | ◐ | ◐ | ◐ | ● | ● | ◐ |
| 도구 연결성(MCP) | ● | ● | ● | ● | ◐ | ● |
| 작업 스케줄링(cron) | ◐ | ◐ | ● | ● | ○ | ● |
| 세션 핸드오프 | ○ | ○ | ◐ | ◐ | ○ | ● |
| 멀티 서피스/채널 | ◐ | ◐ | ◐ | ◐ | ○ | ● |

---

## 3. 범용 3종 심층 코멘트

### 3.1 Claude Code — "최소 스캐폴딩, 최대 하니스"
코드의 ~1.6%만 AI 결정 로직이고 98.4%가 운영 인프라라는 *harness-first* 철학이 정체성이다.
강점은 **운영 성숙도의 폭**: 5계층 컨텍스트 압축, 27종 lifecycle hooks, 7단계 권한 모드
(deny-first), 샌드박싱, 그리고 변경 전 자동 스냅샷 + `/rewind`(코드/대화 선택 복원)라는 안전망.
서브에이전트는 격리 컨텍스트(sidechain)로 동작해 상위 맥락을 보호하고, 메모리는 *버전 관리
가능한 파일*(CLAUDE.md 계층 + auto-memory)로 투명하다. 헤드리스(`-p`)+공식 GitHub Action으로
CI 통합도 1급. **한계**: 멀티모델 라우팅은 자사 계열 중심(◐), 메신저 등 다채널·세션 핸드오프는
비초점, 팀 공유 메모리는 부분적(◐). [1][6][14][15]

### 3.2 Codex CLI — "표준 + 무인 실행 + 정책 엔진"
`AGENTS.md`(Linux Foundation 표준화)와 **2-모델 비동기 메모리**(판단+병합, 30일 pruning)로
메모리를 효율 관리한다. 보안 하니스가 특히 단단하다 — Rust `execpolicy`가 **Starlark 정책**으로
명령을 allow/prompt/forbidden 평가하고, **macOS Seatbelt·Linux Landlock**으로 OS 격리하며,
3축(approval/sandbox/network) 제어를 `/mode`로 세션 중 전환한다. `codex exec`는 exit code 기반
무인 실행(cron·CI)에 적합. **한계**: `AGENTS.md` 32KiB 상한의 silent truncation, lifecycle
hooks·체크포인트·다채널은 상대적으로 제한적, 팀 공유 메모리는 *명시적 미지원*. [2][4][8][16][17][18]

### 3.3 Antigravity — "Agent-first IDE + Knowledge Base + 역할분담 병렬"
Gemini 3 Pro 기반의 에이전트 우선 IDE로, **Knowledge Base**가 학습을 코어 프리미티브로 다뤄
과거 작업의 컨텍스트·스니펫·성공 단계를 축적한다. **Mission Control**에서 Manager·Writer·
Critic·Tester를 비동기 병렬로 오케스트레이션하고, 내장 Chromium 브라우저로 스크린샷 기반 UI
검증(멀티모달)을 네이티브 수행한다. **Terminal Sandboxing**(Seatbelt/nsjail/AppContainer)으로
OS 격리를 제공하고, 별도 **Antigravity CLI(`agy`)** 는 `/rewind`·`/undo`·`/fork` 체크포인트를
지원(IDE는 Artifacts·Strict Mode 검증 중심). 검증 가능한 *Artifacts*로 신뢰·협업을 높인다.
**한계**: 자기개선 폐루프·멀티모델 라우팅은 부분적(◐), 샌드박스는 기본 비활성. [3][12][19][20] / [Ref A][Ref B]

---

## 4. 특수목적 3종 심층 코멘트

> *Gemini 작성 예정 (요청: `000022_Claude_Work_Request`).* OpenClaw / oh-my-openagent /
> Hermes 각각의 차별적 강점 + 한계를 균형있게. 도착 시 Claude가 본 절에 통합한다.

---

## 5. 차세대 도구 설계 아이디어

`merged/master-comparison.md §5`의 11개 아이디어를 채택한다. 핵심 우선순위:
1. **투명 파일 메모리 + 비동기 2-모델 관리**(Claude × Codex).
2. **자기개선 폐루프 표준화**(Hermes × `agentskills.io`).
3. **다계층 컨텍스트 압축 + silent truncation 경고**.
4. **Harness-first + deny-first 보안**(hooks·권한·execpolicy·Seatbelt/Landlock).
5. **벤더중립 작업별 멀티모델 라우팅**(oh-my-openagent).
6. **역할분담 병렬 + 검증 역할 분리**(Antigravity Critic/Tester).
7. **체크포인트/롤백 안전망**(Claude `/rewind`, Antigravity `agy`).
8. **cron 무인 + 다채널 세션 핸드오프**(Hermes).
9. **CI-Native 헤드리스 표준**(Claude `-p`+Action, Codex `codex exec`).
10. **팀/공유 메모리 + 프로필 배포(미개척 최대 기회)**.

---

## 6. References

전체 출처 목록은 `claude/coding-agents-feature-comparison.md §References`(1–25) 및
`merged/master-comparison.md §6`([Ref A] Antigravity Sandboxing, [Ref B] Antigravity CL. agy)을
정본으로 한다. 특수목적 3종의 1차 출처 승격은 Gemini 보강분(요청 `000022`)으로 갱신 예정.
