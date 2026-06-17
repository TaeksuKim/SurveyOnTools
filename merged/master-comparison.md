# Coding Agents 기능 비교 — 취합 마스터 표 (draft v0.1)

> **목적:** Claude(`claude/coding-agents-feature-comparison.md` v2.1)와
> Gemini(`gemini/coding_agents_comparison.md` v2.4) 두 리포트를 단일 비교표로 취합한 초안.
> 최종 report의 기준 문서가 되는 것을 목표로 한다.
>
> **작성:** Claude · **기준일:** 2026-06-17 · **상태:** draft(특수목적 도구 셀은 Gemini의
> ③ 심층 보강 결과로 갱신 예정)
>
> **병합 원칙(보수적):** 두 리포트의 등급이 다르고 1차 출처로 확정되지 않은 *상향*은
> 보수적으로 **◐**로 두고 §4 "확인 필요 항목"에 표시한다. 검증되면 상향한다.
>
> **범례:** ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인
> **도구 열 순서(고정):** Claude Code → Codex CLI → Antigravity → OpenClaw → oh-my-openagent → Hermes Agent

---

## 1. 한눈에 보는 비교표

### 1.A Core — 설계·지능

| 지표 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|
| **Agentic Memory** (세션 간 영속) | ● | ● | ● | ◐ | ◐ | ● |
| **자기개선 학습 루프** (스킬 자동승격) | ◐ | ◐ | ◐ † | ○ | ○ | ● |
| **Context Compaction** (토큰 절감) | ● | ◐ | ◐ | ◐ | ● | ◐ |
| **멀티/서브 에이전트** | ● | ◐ | ● | ● | ● | ● |
| **멀티모델 라우팅** | ◐ | ◐ | ◐ | ● | ● | ◐ † |
| **코드 인텔리전스** (LSP/AST) | ◐ | ◐ | ● | ◐ | ● | ◐ |

### 1.B Harness & Ops — 인프라·운영

| 지표 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|
| **Lifecycle Hooks** | ● | ◐ | ◐ | ◐ | ● | ◐ |
| **다단계 권한(Permissions)** | ● | ● | ◐ | ◐ | ◐ | ◐ |
| **샌드박싱(Sandboxing)** | ● | ● | ◐ † | ◐ | ◐ | ◐ † |
| **체크포인트/롤백(rewind)** | ● | ◐ | ◐ † | ○ | ○ | ○ |
| **Git/Worktree 격리** | ● | ◐ | ◐ † | ◐ | ◐ | ◐ |
| **Headless/CI-Native** | ● | ● | ◐ † | ◐ † | ◐ | ◐ |
| **작업 스케줄링(cron)** | ◐ | ◐ | ● | ● | ○ | ● |

### 1.C UX & Ecosystem — 경험·확장

| 지표 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|
| **Adaptive/개인화** | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| **멀티모달**(vision·음성) | ◐ | ◐ | ● | ◐ | ○ | ● |
| **도구 연결성(MCP)** | ● | ● | ● | ● | ◐ | ● |
| **Skills/확장** | ● | ◐ | ◐ | ● | ● | ● |
| **멀티 서피스/채널** | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| **세션 핸드오프**(cross-device) | ○ | ○ | ◐ | ◐ | ○ | ● |
| **프로필/설정 배포** | ◐ | ○ | ◐ | ● | ○ | ● † |
| **팀/공유 메모리** | ◐ | ○ | ◐ | ◐ | ○ | ◐ |

**전략 라벨(참고, 등급 아님):** Context 전략 — Claude=5-Layer · Codex=Async Summary ·
Antigravity=Knowledge Base · OpenClaw=Bootstrap files · oh-my-openagent=Tokenmax/IntentGate ·
Hermes=Tiered. 채널 — Claude/Codex/omo=CLI·IDE · Antigravity=IDE/TUI · OpenClaw=Gateway ·
Hermes=Msg Gateway.

> † = §4 "확인 필요 항목"에 해당(두 리포트 불일치 또는 1차 출처 미확정). 보수적 등급 적용.

---

## 2. 도구별 한 줄 포지셔닝

| 도구 | 분류 | 핵심 정체성 |
|------|------|-------------|
| **Claude Code** | 범용 | 최소 스캐폴딩+최대 하니스. 메모리·압축·hooks·권한·체크포인트·헤드리스가 가장 성숙 |
| **Codex CLI** | 범용 | `AGENTS.md` 표준+2-모델 자동 메모리, `execpolicy`(Starlark)+Seatbelt/Landlock, `codex exec` 무인 |
| **Antigravity** | 범용(Agent-first IDE) | Gemini 3 Pro, Knowledge Base, Mission Control(Manager/Writer/Critic/Tester), 내장 브라우저 |
| **OpenClaw** | 특수(로컬 자동화) | 100+ 스킬, 단일 임베디드 런타임, 브라우저/canvas/cron 타입드 툴, 프로필 배포 |
| **oh-my-openagent** | 특수(토큰 최적 하니스) | "tokenmaxxers"용, 카테고리별 멀티모델 라우팅, LSP+AST, 5+ 병렬 |
| **Hermes Agent** | 특수(자기개선 장기 실행) | 영속 메모리+학습 루프, cron, 메신저 게이트웨이 세션 핸드오프 |

---

## 3. 지표 정의 (취합 합의용)

병합 시 등급 해석을 통일하기 위한 정의. 특히 불일치가 있었던 항목을 엄격히 정의한다.

| 지표 | 정의 | 비고 |
|------|------|------|
| **자기개선 학습 루프** | 작업 성공 경험을 *재사용 가능한 스킬로 자동 승격*하는 폐루프 | 단순 메모리 누적은 제외(그건 Agentic Memory) |
| **세션 핸드오프** | *다른 기기/채널*로 세션을 무중단 이전 | 같은 기기의 resume/fork는 제외 → Claude/Codex ○ |
| **작업 스케줄링** | *도구 내장* cron/스케줄러 | 외부 cron 의존만 가능하면 ◐ |
| **Headless/CI-Native** | 비대화형 실행+구조화 출력(json 등)+CI 액션 | 1급은 공식 CI 액션/exit code 보유 |
| **샌드박싱** | OS 수준 격리(Seatbelt/Landlock/컨테이너 등) | "로컬 보존"만으로는 ◐ |
| **체크포인트/롤백** | 변경 전 스냅샷+코드/대화 선택 복원 | Artifacts/git 간접은 ◐ |

---

## 4. 확인 필요 항목 (†) — 두 리포트 불일치 / 1차 출처 미확정

병합 전 검증이 필요한 셀. 검증 시 본 표를 갱신한다. (Claude=C, Gemini=G 판정)

1. **Antigravity 학습 루프** — C:◐ / G:●. Knowledge Base는 누적이나 "자동 스킬 승격"
   폐루프인지 1차 확인 필요. → 현재 **◐**.
2. **Hermes 멀티모델 라우팅** — C:◐ / G:●. "multi-model reasoning"의 라우팅 수준 확인 필요. → **◐**.
3. **Antigravity·Hermes 샌드박싱** — C:◐ / G:●. OS 수준 격리 메커니즘 1차 확인 필요. → **◐**.
4. **Antigravity 체크포인트/롤백·Git/Worktree** — C:◐ / G:●. 실제 스냅샷 복원 여부 확인. → **◐**.
5. **Antigravity·OpenClaw Headless/CI** — C:◐ / G:●. 공식 CI 경로(GitHub Actions 등) 확인. → **◐**.
6. **Hermes 프로필/설정 배포** — Gemini 신규 지표. Nous 공식 docs 확인 권장. → 잠정 **●†**.

### 4-B. 출처 검증 권고 (Gemini 리포트 대상)
- `openai.com/blog/codex-cli-security-policy`(G[4]) → **검증된 1차 출처로 교체 권장**:
  `github.com/openai/codex/blob/rust-v0.107.0/codex-rs/execpolicy/README.md`.
- `github.com/openai/codex-cli/releases/tag/v0.130`(G[15]) → 저장소명 `openai/codex`(‑cli 아님), 링크 점검.
- execpolicy "**tree-sitter** 구문분석" 주장 → 확인된 자료는 *Starlark 정책+패턴 매칭*까지. 출처 확인.
- Hermes "**SQLite 3계층 메모리/`/handoff`/Profile Dist.**" → 1차 출처(Nous docs) 확인 후 확정.

### 4-C. 합의된 정정 이력 (두 리포트 공통 반영 완료)
- **Codex execpolicy(Starlark)+Seatbelt/Landlock**: Claude 초판 유보 → 재검증 후 사실 확인, 양측 반영.
- **Antigravity Agentic Memory ●**: Knowledge Base 근거로 양측 ● 확정.
- **"Max Context" 수치 지표 폐기**: 모델 의존적이므로 Context 전략 라벨로 대체(양측 합의).

---

## 5. 향후 유사 도구 개발 아이디어 (취합)

1. **투명 파일 메모리 + 비동기 2-모델 관리** (Claude 파일 메모리 × Codex 요약·병합·pruning).
2. **자기개선 폐루프의 표준화** (Hermes × `agentskills.io` 오픈 표준 → 팀 자산화).
3. **다계층 컨텍스트 압축 기본 탑재 + silent truncation 경고** (Claude 5계층 × Codex 32KiB 보완).
4. **Harness-first + deny-first 보안** (27 hooks·7권한·execpolicy(Starlark)·Seatbelt/Landlock).
5. **작업별 멀티모델 라우팅(벤더 중립)** (oh-my-openagent 카테고리 라우팅).
6. **역할 분담형 병렬 멀티에이전트 + 검증 역할** (Antigravity Manager/Writer/Critic/Tester).
7. **검증 가능한 산출물(Artifacts)** — 사람이 전체 diff 없이 신뢰·검증.
8. **체크포인트/롤백을 1급 안전망으로** (Claude `/rewind`).
9. **CI-Native 헤드리스 표준** (Claude `-p`+Action, Codex `codex exec`; json/stream-json+exit code).
10. **cron 무인 실행 + 다채널 핸드오프** (Hermes; 단 권한·샌드박스 동반 강화).
11. **팀/공유 메모리(미개척 기회)** — 개인 메모리를 안전하게 팀 자산으로 동기화하는 표준.

---

## 6. References (검증된 URL 기준)

Claude 리포트 References 1–25를 1차 기준으로 사용한다(모두 URL 확인). 상세 목록은
`claude/coding-agents-feature-comparison.md` §References 참조. 핵심 출처:

- Claude Code: arXiv *Dive into Claude Code* (https://arxiv.org/html/2604.14228v1);
  Headless/CI (https://institute.sfeir.com/en/claude-code/claude-code-headless-mode-and-ci-cd/)
- Codex CLI: execpolicy README
  (https://github.com/openai/codex/blob/rust-v0.107.0/codex-rs/execpolicy/README.md);
  Memory (https://mem0.ai/blog/how-memory-works-in-codex-cli)
- Antigravity: Google Developers Blog
  (https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/)
- OpenClaw: Agent runtime (https://docs.openclaw.ai/concepts/agent)
- oh-my-openagent: Overview
  (https://github.com/code-yeongyu/oh-my-openagent/blob/dev/docs/guide/overview.md)
- Hermes Agent: Nous docs
  (https://hermes-agent.nousresearch.com/docs/user-guide/features/overview)

> Gemini의 ③ 보강(OpenClaw·oh-my-openagent 1차 출처 확정)이 도착하면 해당 셀과 References를
> 갱신한다.
