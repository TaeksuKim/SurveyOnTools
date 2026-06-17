# Coding Agents 기능 비교 — 취합 마스터 표 (draft v0.3)

> **목적:** Claude(`claude/coding-agents-feature-comparison.md` v2.1)와
> Gemini(`gemini/coding_agents_comparison.md` v2.4) 두 리포트를 단일 비교표로 취합한 초안.
> 최종 report의 기준 문서가 되는 것을 목표로 한다.
>
> **작성:** Claude · **기준일:** 2026-06-17 · **상태:** draft v0.3
> (Gemini `000015`·`000016` 반영 + Claude의 §4-A 직접 검증 완료)
>
> **병합 원칙(보수적):** 두 리포트의 등급이 다르고 1차 출처로 확정되지 않은 *상향*은
> 보수적으로 **◐(†)** 로 두고 §4에 표시한다. 검증되면 상향한다.
>
> **범례:** ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인
> **도구 열 순서(고정):** Claude Code → Codex CLI → Antigravity → OpenClaw → oh-my-openagent → Hermes Agent

---

## 1. 한눈에 보는 비교표

### 1.A Core — 설계·지능

| 지표 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|
| **Agentic Memory** (세션 간 영속) | ● | ● | ● | ◐ ‡ | ◐ | ● |
| **자기개선 학습 루프** (스킬 자동승격) | ◐ | ◐ | ◐ | ○ | ○ | ● |
| **Context Compaction** (토큰 절감) | ● | ◐ | ◐ | ◐ | ● | ◐ |
| **멀티/서브 에이전트** | ● | ◐ | ● | ● | ● | ● |
| **멀티모델 라우팅** | ◐ | ◐ | ◐ | ● | ● | ◐ ‡ |
| **코드 인텔리전스** (LSP/AST) | ◐ | ◐ | ● | ◐ | ● | ◐ |

### 1.B Harness & Ops — 인프라·운영

| 지표 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|
| **Lifecycle Hooks** | ● | ◐ | ◐ | ◐ | ● | ◐ |
| **다단계 권한(Permissions)** | ● | ● | ◐ | ◐ | ◐ | ◐ |
| **샌드박싱(Sandboxing)** | ● | ● | ● | ◐ | ◐ | ◐ ‡ |
| **체크포인트/롤백(rewind)** | ● | ◐ | ◐ | ○ | ○ | ○ |
| **Git/Worktree 격리** | ● | ◐ | ◐ | ◐ | ◐ | ◐ |
| **Headless/CI-Native** | ● | ● | ◐ | ◐ | ◐ | ◐ |
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
| **프로필/설정 배포** | ◐ | ○ | ◐ | ● | ○ | ● |
| **팀/공유 메모리** | ◐ | ○ | ◐ | ◐ | ○ | ◐ |

**전략 라벨(참고, 등급 아님):** Context 전략 — Claude=5-Layer · Codex=Async Summary(2-model) ·
Antigravity=Knowledge Base · OpenClaw=Workspace-as-Memory(bootstrap files) ·
oh-my-openagent=Tokenmax/IntentGate · Hermes=3-Tier(Short=MD / Long=SQLite·FTS5 / Procedural=Skills).
오케스트레이션 — Antigravity=Mission Control(Manager·Writer·Critic·Tester) ·
oh-my-openagent=IntentGate→Sisyphus→Prometheus→Atlas(Team Mode) · OpenClaw=Gateway·Channel·LLM 3계층.

> **마커:** ‡ = 두 리포트 판정차의 보수적 결론(§4-B). 추가 근거 시 상향 가능.
> (v0.2의 † Antigravity 항목은 §4-A에서 **검증 완료** — 샌드박싱 ● 확정, 체크포인트/Git/Headless ◐ 유지.)

---

## 2. 도구별 한 줄 포지셔닝

| 도구 | 분류 | 핵심 정체성 |
|------|------|-------------|
| **Claude Code** | 범용 | 최소 스캐폴딩+최대 하니스. 메모리·압축·hooks·권한·체크포인트·헤드리스가 가장 성숙 |
| **Codex CLI** | 범용 | `AGENTS.md` 표준+2-모델 자동 메모리, `execpolicy`(Starlark)+Seatbelt/Landlock, `codex exec` 무인 |
| **Antigravity** | 범용(Agent-first IDE) | Gemini 3 Pro, Knowledge Base, Mission Control(Manager/Writer/Critic/Tester), 내장 브라우저 |
| **OpenClaw** | 특수(로컬 자동화) | 100+ 스킬(`SKILL.md`+ClawHub), Gateway·Channel·LLM 3계층, 브라우저/canvas/cron 타입드 툴 |
| **oh-my-openagent** | 특수(토큰 최적 하니스) | "tokenmaxxers"용, 카테고리별 멀티모델 라우팅, LSP+AST, Team Mode 5+ 병렬 |
| **Hermes Agent** | 특수(자기개선 장기 실행) | 영속 3-Tier 메모리+학습 루프, cron, 메신저 게이트웨이 `/handoff` 세션 핸드오프 |

---

## 3. 지표 정의 (취합 합의용)

| 지표 | 정의 | 비고 |
|------|------|------|
| **자기개선 학습 루프** | 작업 성공 경험을 *재사용 가능한 스킬로 자동 승격*하는 폐루프 | 단순 메모리 누적은 제외(Agentic Memory) |
| **세션 핸드오프** | *다른 기기/채널*로 세션을 무중단 이전 | 같은 기기 resume/fork 제외 → Claude/Codex ○ |
| **작업 스케줄링** | *도구 내장* cron/스케줄러 | 외부 cron 의존만 가능하면 ◐ |
| **Headless/CI-Native** | 비대화형 실행+구조화 출력(json 등)+CI 액션 | 1급은 공식 CI 액션/exit code 보유 |
| **샌드박싱** | OS 수준 격리(Seatbelt/Landlock/nsjail/컨테이너 등) | "로컬 보존"만으로는 ◐ |
| **체크포인트/롤백** | 변경 전 스냅샷+코드/대화 선택 복원 | Artifacts/git 간접은 ◐ |

---

## 4. 미해결·검증 항목

### 4-A. Antigravity † 항목 — 검증 완료 (Claude WebSearch)
Gemini의 ● 상향 권고를 직접 검증한 결과 **분리 판정**한다:
- **샌드박싱 = ● 확정.** Antigravity IDE는 실제로 **Terminal Sandboxing**(macOS=Seatbelt/
  sandbox-exec, Linux=nsjail) 커널 수준 격리를 네이티브 제공한다(워크스페이스 한정 쓰기·
  네트워크 토글·Strict Mode). *단 기본값은 비활성.* → Gemini 판정이 옳았고 **Claude의 초기
  유보를 정정**한다. [Ref A]
- **체크포인트/Git-Worktree = ◐ 유지.** Gemini가 든 `/restore`+`~/.gemini/history` 섀도 git은
  **Gemini CLI의 기능**임을 공식 docs로 확인(google-gemini/gemini-cli) — *혼동이 맞다.*
  Antigravity IDE 네이티브 코드 스냅샷 복원은 1차 출처 미확인이라 ◐ 유지(Artifacts·Strict Mode
  리뷰는 있으나 rewind와 다름).
- **Headless/CI = ◐ 유지.** Antigravity 전용 CI 경로 1차 출처 확인 전까지 보수 유지.

### 4-B. ‡ 두 리포트 판정차 — 보수적 결론
1. **OpenClaw Agentic Memory** — C:◐ / G:●. Gemini는 "Workspace-as-Memory"(MEMORY.md 등)로
   ● 권고. 다만 *대화 중 자동 write-back*(Claude/Codex/Hermes 수준)인지 불명확 → **◐ 유지**.
2. **Hermes 멀티모델 라우팅** — C:◐ / G:●. 근거가 "multi-model reasoning"으로 *작업별 라우팅*
   (oh-my-openagent 수준)인지 약함 → **◐ 유지**.
3. **Hermes 샌드박싱** — C:◐ / G:●. "로컬 데이터 보존"은 OS 격리와 다름, 추가 근거 필요 → **◐ 유지**.

### 4-C. 합의·해소 완료 (v0.2 반영)
- **Antigravity 학습 루프 = ◐** (양측 합의: Knowledge Base는 메모리 혁신 ●이나 자동 스킬승격
  폐루프는 아님).
- **OpenClaw Headless/CI = ◐** (양측 합의: 네이티브 CI가 아닌 'Headless Browser' 설정에 가까움).
- **Hermes 세션 핸드오프 = ●** (`/handoff` cross-device 공식 확인).
- **Hermes 프로필/설정 배포 = ●** (개인정보 제외 `SOUL.md`·스킬·설정 패키징 배포, 공식 확인).
- **Codex execpolicy 1차 출처 확정**:
  `github.com/openai/codex/blob/rust-v0.107.0/codex-rs/execpolicy/README.md`.
  *"tree-sitter"* 표현은 **"정밀 명령어 구문 분석"**으로 순화(양측 합의).
- **"Max Context" 수치 지표 폐기** → Context 전략 라벨로 대체(양측 합의).

---

## 5. 향후 유사 도구 개발 아이디어 (취합)

1. **투명 파일 메모리 + 비동기 2-모델 관리** (Claude 파일 메모리 × Codex 요약·병합·pruning).
2. **자기개선 폐루프의 표준화** (Hermes × `agentskills.io` → 팀 자산화).
3. **다계층 컨텍스트 압축 기본 탑재 + silent truncation 경고** (Claude 5계층 × Codex 32KiB 보완).
4. **Harness-first + deny-first 보안** (27 hooks·7권한·execpolicy(Starlark)·Seatbelt/Landlock).
5. **작업별 멀티모델 라우팅(벤더 중립)** (oh-my-openagent 카테고리 라우팅).
6. **역할 분담형 병렬 멀티에이전트 + 검증 역할** (Antigravity Manager/Writer/Critic/Tester).
7. **검증 가능한 산출물(Artifacts)** — 사람이 전체 diff 없이 신뢰·검증.
8. **체크포인트/롤백을 1급 안전망으로** (Claude `/rewind`).
9. **CI-Native 헤드리스 표준** (Claude `-p`+Action, Codex `codex exec`; json/stream-json+exit code).
10. **cron 무인 실행 + 다채널 핸드오프** (Hermes `/handoff`; 단 권한·샌드박스 동반 강화).
11. **팀/공유 메모리 + 프로필 배포(미개척 기회)** — 개인 메모리를 *개인정보 제외* 패키징해
    팀 자산으로 동기화/배포하는 표준(OpenClaw·Hermes의 Profile Distribution이 초기 사례).

---

## 6. References (검증된 URL 기준)

Claude 리포트 References 1–25를 1차 기준으로 사용한다(상세: `claude/coding-agents-feature-comparison.md`).
핵심·교정 출처:

- Claude Code: arXiv *Dive into Claude Code* (https://arxiv.org/html/2604.14228v1);
  Headless/CI (https://institute.sfeir.com/en/claude-code/claude-code-headless-mode-and-ci-cd/)
- Codex CLI: **execpolicy README(1차)**
  (https://github.com/openai/codex/blob/rust-v0.107.0/codex-rs/execpolicy/README.md);
  Memory (https://mem0.ai/blog/how-memory-works-in-codex-cli)
- Antigravity: Google Developers Blog
  (https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/);
  **[Ref A] Terminal Sandboxing(Seatbelt/nsjail)** — Antigravity IDE Settings docs
  (https://antigravity.google/docs/ide-settings). *체크포인트 `/restore`는 Gemini CLI 기능
  (https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/checkpointing.md), Antigravity 적용 미확인.*
- OpenClaw: Agent runtime (https://docs.openclaw.ai/concepts/agent)
- oh-my-openagent: Overview
  (https://github.com/code-yeongyu/oh-my-openagent/blob/dev/docs/guide/overview.md)
- Hermes Agent: Nous docs
  (https://hermes-agent.nousresearch.com/docs/user-guide/features/overview);
  hermes-agent.org(3-Tier 메모리·/handoff·Profile Dist.)

### 변경 이력
- **v0.3 (2026-06-17):** Claude 직접 검증(§4-A) — **Antigravity 샌드박싱 ●로 정정 확정**
  (Seatbelt/nsjail Terminal Sandboxing), 체크포인트/Git/Headless는 ◐ 유지(`/restore`는 Gemini
  CLI 기능으로 혼동 확인), † 마커 해소.
- **v0.2 (2026-06-17):** Gemini `000015`·`000016` 반영 — Hermes 핸드오프·프로필배포 ● 확정,
  Codex execpolicy 1차 출처 확정, Antigravity 상향 권고는 *Gemini CLI 혼동 가능성*으로 ◐ 보류(†),
  OpenClaw/Hermes 일부 ‡ 보수 유지, 전략 라벨·포지셔닝 보강.
- **v0.1:** Claude 초안(3분할 매트릭스, 21지표, 지표정의·확인필요·아이디어).
