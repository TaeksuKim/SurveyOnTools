# Coding Agents 기능 비교표 (v2)

> 범용 Coding Agents(**Claude Code**, **Codex CLI**, **Antigravity**)와 특수 목적
> Agents(**OpenClaw**, **oh-my-openagent**, **Hermes Agent**)가 제공하는 **고급(advanced)
> 기능**을 비교한다. 단순 코드 자동완성·파일 편집 같은 기본 기능은 제외하고, 차세대 도구
> 설계에 영향을 주는 기능에 초점을 맞춘다.
>
> *작성 기준일: 2026-06-17. 평가는 References의 공개 문서/리뷰 기준이며, 특수 목적 도구
> 일부는 공식 문서가 제한적이어서 추정이 포함될 수 있다(해당 부분은 본문에 caveat 명시).*
>
> **v2 변경:** 핵심 12개 + 확장 10개로 비교 지표 확대, Antigravity Knowledge Base 반영해
> 메모리 등급 상향, 타 Agent(Gemini) 리포트 교차검증 섹션(§5) 추가.

---

## 1. 한눈에 보는 비교표 — 핵심 기능

**범례:** ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인

| # | 핵심 고급 기능 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|---|----------------|:----:|:----:|:----:|:----:|:----:|:----:|
| 1 | **Agentic Memory** (세션 간 영속 메모리) | ● | ● | ● | ◐ | ◐ | ● |
| 2 | **자기개선 학습 루프** (재사용 스킬 자동 생성) | ◐ | ◐ | ◐ | ○ | ○ | ● |
| 3 | **Context Compaction** (토큰 절감/압축) | ● | ◐ | ◐ | ◐ | ● | ◐ |
| 4 | **Harness Engineering** (hooks·생명주기) | ● | ◐ | ◐ | ◐ | ● | ◐ |
| 5 | **샌드박싱/권한 보안** | ● | ● | ◐ | ◐ | ◐ | ◐ |
| 6 | **Adaptive/개인화** (사용자와 함께 성장) | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| 7 | **멀티/서브 에이전트 오케스트레이션** | ● | ◐ | ● | ● | ● | ● |
| 8 | **도구 연결성** (MCP·외부 통합) | ● | ● | ● | ● | ◐ | ● |
| 9 | **Skills/확장 프레임워크** | ● | ◐ | ◐ | ● | ● | ● |
| 10 | **멀티모델 라우팅** (작업별 모델 선택) | ◐ | ◐ | ◐ | ● | ● | ◐ |
| 11 | **멀티 서피스/채널** (CLI·IDE·메신저) | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| 12 | **멀티모달** (vision·이미지·음성) | ◐ | ◐ | ● | ◐ | ○ | ● |

## 1-B. 한눈에 보는 비교표 — 확장 고급 기능

| # | 확장 고급 기능 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|---|----------------|:----:|:----:|:----:|:----:|:----:|:----:|
| 13 | **Planning Mode** (plan-then-execute) | ● | ◐ | ● | ◐ | ● | ◐ |
| 14 | **체크포인트/롤백** (rewind·snapshot) | ● | ◐ | ◐ | ○ | ○ | ○ |
| 15 | **백그라운드/장기 실행** (async) | ◐ | ● | ● | ◐ | ◐ | ● |
| 16 | **작업 스케줄링** (cron/scheduled) | ◐ | ◐ | ● | ● | ○ | ● |
| 17 | **브라우저 자동화/Computer Use** | ◐ | ◐ | ● | ● | ○ | ● |
| 18 | **코드 인텔리전스** (LSP/AST) | ◐ | ◐ | ● | ◐ | ● | ◐ |
| 19 | **커스텀 슬래시 커맨드** | ● | ◐ | ◐ | ◐ | ◐ | ◐ |
| 20 | **검증/자가 테스트** (Critic·verify 루프) | ◐ | ◐ | ● | ◐ | ◐ | ◐ |
| 21 | **Git/Worktree 격리** | ● | ◐ | ◐ | ◐ | ◐ | ◐ |
| 22 | **팀/공유 메모리** (협업 자산화) | ◐ | ○ | ◐ | ◐ | ○ | ◐ |

> **참고 — 컨텍스트 창(Max Context)은 표에서 제외.** 컨텍스트 창 크기는 도구의 고정 속성이
> 아니라 *연결된 기반 모델*에 의해 결정된다(멀티모델 라우팅 도구는 모델마다 상이). 따라서
> "OpenClaw=128k" 같은 단정적 수치 대신, Compaction(#3)과 라우팅(#10)으로 평가한다. → §5 참조.

**한 줄 포지셔닝**

| 도구 | 분류 | 핵심 정체성 |
|------|------|-------------|
| **Claude Code** | 범용 | 최소 스캐폴딩 + 최대 운영 하니스. 메모리·압축·hooks·권한·체크포인트가 가장 성숙 |
| **Codex CLI** | 범용 | `AGENTS.md` 표준 + 백그라운드 자동 메모리 요약, `codex exec` 무인 실행, 강한 샌드박스 |
| **Antigravity** | 범용(Agent-first IDE) | Gemini 3 Pro, Mission Control 병렬 에이전트 + Knowledge Base + 내장 브라우저 |
| **OpenClaw** | 특수(로컬 자동화) | 100+ 스킬, 단일 임베디드 런타임, 브라우저/canvas/cron 타입드 툴 |
| **oh-my-openagent** | 특수(토큰 최적 하니스) | "tokenmaxxers"용 하니스, 카테고리별 멀티모델 라우팅, LSP+AST, 5+ 병렬 |
| **Hermes Agent** | 특수(자기개선 장기 실행) | 영속 메모리 + 학습 루프 + cron + 메신저 게이트웨이 다채널 |

---

## 2. 핵심 기능 상세 (#1–#12)

### 2.1 Agentic Memory — 세션 간 영속 메모리
- **Claude Code (●):** 4단계 `CLAUDE.md` 계층 + 대화 중 작성하는 auto-memory를 *불투명
  임베딩이 아닌 버전 관리 가능한 파일*로 저장. [1][7]
- **Codex CLI (●):** `AGENTS.md`(정적) + Memories(생성). 유휴 시 백그라운드 비동기 요약을
  `~/.codex/memories/`에 기록, *2-모델(판단+병합)* 방식, 30일 미사용 pruning. [4][8]
- **Antigravity (●, v2 상향):** **Knowledge Base를 "코어 프리미티브"로 취급** — 유용한
  컨텍스트·코드 스니펫·성공 단계를 저장해 다음 작업을 개선. `.antigravity/brain/`에 계획·
  체크리스트·요약 보관. [3][19][20]
- **OpenClaw (◐):** `AGENTS.md`/`SOUL.md`/`USER.md`를 세션 시작 시 주입. 정적 bootstrap
  파일 기반(자동 누적·요약보다 설정형). [9]
- **oh-my-openagent (◐):** 하니스/오케스트레이션 중심, 메모리는 파일 기반 보조. [5]
- **Hermes Agent (●):** 영속 cross-session 메모리가 정체성, 선호·프로젝트·환경 자동 기억. [10][11][22]

### 2.2 자기개선 학습 루프 (#2)
- **Hermes Agent (●):** *"어려운 문제를 풀면 재사용 가능한 스킬 문서를 작성"* — 폐루프 학습. [10][11]
- **Antigravity (◐):** Knowledge Base가 "과거 작업에서 학습"하나 자동 스킬 승격 폐루프는
  Hermes만큼 명시적이지 않음. [19]
- **Claude Code / Codex (◐):** auto-memory·메모리 병합으로 맥락 누적되나 성공→스킬 자동
  승격은 1급 기능 아님. [1][8]
- **OpenClaw / oh-my-openagent (○):** 자동 스킬 생성을 핵심으로 내세우지 않음.

### 2.3 Context Compaction (#3)
- **Claude Code (●):** **5계층 압축 파이프라인**(Budget reduction → Snip → Microcompact →
  Context collapse → Auto-compact). 저렴한 계층부터 적용, 압축 후 최근 스킬 재첨부. [1][6]
- **oh-my-openagent (●):** *"tokenmaxxers를 위한 하니스"* — 토큰 효율이 설계 정체성. 작업
  스코핑(IntentGate)·임베디드 MCP로 컨텍스트를 좁힘. [5]
- **Codex CLI (◐):** `/compact` 제공하나 `AGENTS.md`에 **32 KiB 상한** → 대형 모노레포에서
  조용한 절단 가능. [4][8]
- **Antigravity / OpenClaw / Hermes (◐):** Artifacts·세션 요약·영속 메모리로 간접 절감,
  문서화된 다계층 파이프라인은 미확인. [3][9][10]

### 2.4 Harness Engineering (#4)
- **Claude Code (●):** *코드 ~1.6%만 AI 결정, 98.4%가 인프라*. **27종 hooks**(PreToolUse/
  PostToolUse/PermissionDenied 등), append-only JSONL 세션. [1]
- **oh-my-openagent (●):** *"복잡한 코드베이스를 위한 유일한 에이전트 하니스"*. IntentGate
  사전 분류, LSP+AST. [5]
- **Codex CLI (◐):** 설정·승인 정책 제공, hooks 생태계는 상대적으로 제한적. [4]
- **Antigravity / OpenClaw / Hermes (◐):** Planning 게이트 / 단일 임베디드 런타임+tool policy /
  state·routing·eval hooks. [3][9][10]

### 2.5 샌드박싱 / 권한 보안 (#5)
- **Claude Code (●):** **7단계 권한 모드**(plan ~ bypassPermissions), deny-first 규칙 평가,
  샌드박싱, resume 시 권한 미복원(보안 설계). [1]
- **Codex CLI (●):** OS 수준 샌드박스(기본 네트워크 차단·워크스페이스 한정 쓰기), 클라우드는
  격리 컨테이너. 3축 제어(approval_policy·sandbox_mode·network_access), `/mode`로 세션 중
  전환. [17][18]
- **Antigravity / OpenClaw / oh-my-openagent / Hermes (◐):** 검토 게이트 / tool policy /
  스코프드 권한 / 로컬 데이터 보존 등 제공하나 다단계 권한 모델은 덜 정형화. [3][9][5][10]

### 2.6 Adaptive / 개인화 (#6)
- **Hermes Agent (●):** *"오래 실행할수록 당신을 더 잘 안다"* — 패턴·선호 자동 학습. [10][11]
- **Claude Code / Codex / Antigravity / OpenClaw (◐):** `CLAUDE.md` 신뢰 공동구축 / Memories
  누적 / Knowledge 피드백 / `USER.md`·`SOUL.md` 명시 개인화(정적). [1][8][12][9]
- **oh-my-openagent (○):** 개인화보다 작업별 모델 라우팅에 집중. [5]

### 2.7 멀티/서브 에이전트 오케스트레이션 (#7)
- **Claude Code (●):** 서브에이전트가 격리 컨텍스트(sidechain)에서 실행, 요약만 반환. [1]
- **Antigravity (●):** Mission Control에서 **Manager·Writer·Critic·Tester** 병렬 + **비동기
  서브에이전트**(블로킹 없이 백그라운드 위임), 최대 5 병렬. [3][19][20][21]
- **oh-my-openagent (●):** Sisyphus·Prometheus·Hephaestus 등 특화 에이전트 **5+ 병렬**
  (연구·구현·검증 동시). [5]
- **OpenClaw (●):** 계획 에이전트 + 실행 에이전트 워크플로, 결과 통합. [13]
- **Hermes Agent (●):** 자체 대화·터미널·Python RPC를 가진 격리 서브에이전트. [10][22]
- **Codex CLI (◐):** 코어는 단일 에이전트, OpenAI Agents SDK로 다중 구성. [2]

### 2.8 도구 연결성 — MCP (#8)
- **Claude Code (●):** MCP(stdio·SSE·HTTP·WebSocket) + Plugins, 계층형 확장. [1]
- **Codex CLI (●):** `codex mcp add`(STDIO·HTTP 인증), Context7·Figma·Playwright·GitHub·
  Sentry 등. [4]
- **Hermes Agent (●):** 40+ 도구. [10][11]
- **OpenClaw (●):** 브라우저·canvas·nodes·cron 타입드 1급 도구(쉘 불필요), 100+ 스킬. [9][13]
- **Antigravity (●):** 에디터+터미널+내장 브라우저+MCP. [3][12]
- **oh-my-openagent (◐):** "임베디드 MCP를 가진 스킬" + LSP+AST, 통합 폭은 스코핑 중심. [5]

### 2.9 Skills / 확장 (#9)
- **Claude Code (●):** `.claude/skills/` + 플러그인. [1]
- **OpenClaw (●):** 스킬 플러그인(100+), `awesome-openclaw-skills`. [13]
- **Hermes Agent (●):** 40+ 스킬, **자동 스킬 생성**, `agentskills.io` 표준 호환. [10][11]
- **oh-my-openagent (●):** 임베디드 MCP 스킬을 작업별 스코프. [5]
- **Codex CLI (◐):** `AGENTS.md` 중심, 스킬 마켓 성격 약함. [4]
- **Antigravity (◐):** Artifacts/플러그인 기반. [3]

### 2.10 멀티모델 라우팅 (#10)
- **oh-my-openagent (●):** 카테고리 라우팅(`ultrabrain`→GPT-5.5 xhigh, `deep`→GPT-5.5,
  `visual-engineering`→Gemini, `quick`→GPT-5.4 Mini). Claude·GPT·Gemini·Kimi·GLM 지원. [5]
- **OpenClaw (●):** 모델 라우팅+멀티 프로바이더(Claude Code·Codex·OpenCode 동일 도구 공유). [13]
- **Hermes Agent (◐) / Claude Code·Codex·Antigravity (◐):** 선호 LLM 연결 / 자사 계열 중심. [10][1][4][12]

### 2.11 멀티 서피스 / 채널 (#11)
- **Hermes Agent (●):** Telegram·Discord·Slack·WhatsApp·Signal·CLI 통합 게이트웨이. [10][11]
- **Claude Code/Codex/Antigravity (◐):** 개발자 서피스(CLI·IDE·web·desktop) 중심. [1][4][3]
- **OpenClaw (◐):** Gateway당 단일 임베디드 런타임. [9]
- **oh-my-openagent (○):** Codex·OpenCode용 CLI 하니스 집중. [5]

### 2.12 멀티모달 — vision·이미지·음성 (#12)
- **Hermes Agent (●):** vision 분석 + 이미지 생성 + TTS. [10][22]
- **Antigravity (●):** Gemini 3 Pro 멀티모달로 스크린샷 기반 UI 버그 시각 분석, **네이티브
  음성 명령**. [3][12][20]
- **Claude Code / Codex (◐):** 이미지 입력 지원. [1][4]
- **OpenClaw (◐):** canvas 도구. [9]
- **oh-my-openagent (○):** 시각 작업은 Gemini로 라우팅하나 자체 멀티모달은 미초점. [5]

---

## 3. 확장 고급 기능 상세 (#13–#22)

- **#13 Planning Mode:** Claude Code는 *read-only 계획 모드*(승인 후 실행)(●) [14][15];
  Antigravity는 **Plan Artifact**를 생성하는 Plan 모드(●) [3][19]; oh-my-openagent는
  Prometheus 플래너(●) [5]; Codex·OpenClaw·Hermes는 프롬프트/스킬 내 계획(◐). [4][13][10]
- **#14 체크포인트/롤백:** Claude Code의 차별점 — 변경 전 자동 스냅샷, `/rewind`·Esc+Esc로
  코드/대화 선택 복원(●) [14][15]. Codex·Antigravity는 git/Artifacts 기반 간접(◐), 나머지 ○.
- **#15 백그라운드/장기 실행:** Codex `codex exec`(cron·CI·exit code)(●) [16]; Antigravity
  비동기 서브에이전트+scheduled tasks(●) [19][20]; Hermes 게이트웨이 무인 장기 실행(●) [22][23];
  Claude Code 백그라운드 작업/Auto Mode(◐) [15]; OpenClaw cron·oh-my-openagent 병렬(◐).
- **#16 작업 스케줄링(cron):** Hermes는 **자연어 cron 스케줄러**(일일 리포트·야간 백업,
  pause/resume/edit)(●) [23]; Antigravity scheduled background tasks(●) [20]; OpenClaw cron
  타입드 툴(●) [9]; Codex `codex exec`+cron/Automations(◐) [16]; Claude Code 외부 cron+hooks(◐);
  oh-my-openagent ○.
- **#17 브라우저 자동화/Computer Use:** Antigravity 내장 Chromium 브라우저 서브에이전트(●) [3][19];
  Hermes 풀 브라우저 자동화(navigate·click·type·screenshot)(●) [10][22]; OpenClaw 브라우저
  타입드 툴(●) [9][13]; Claude Code·Codex는 MCP(Playwright/Chrome DevTools)로 간접(◐) [4];
  oh-my-openagent ○.
- **#18 코드 인텔리전스(LSP/AST):** oh-my-openagent LSP+AST(rename·정의 이동·진단)(●) [5];
  Antigravity IDE 통합(●) [3]; 나머지 텍스트/도구 기반(◐).
- **#19 커스텀 슬래시 커맨드:** Claude Code 빌트인+커스텀(`/init`·`/compact`·`/review` 등)(●)
  [14]; Codex `/mode` 등(◐) [17]; 나머지 ◐.
- **#20 검증/자가 테스트:** Antigravity Critic·Tester 서브에이전트 + Artifacts 검증(●) [3][19];
  OpenClaw "Plan→Execute→Verify→Deliver" 루프(◐) [13]; oh-my-openagent 검증 에이전트(◐) [5];
  나머지 ◐.
- **#21 Git/Worktree 격리:** Claude Code worktree 기반 에이전트 격리(●) [1]; OpenClaw worktree
  전략(◐) [9]; 나머지 git 통합(◐).
- **#22 팀/공유 메모리:** 전반적 약점 — Codex는 *명시적으로 팀 공유·cross-machine 동기화
  미지원*(○) [8]; Claude Code는 커밋되는 project `CLAUDE.md`로 부분 공유(◐) [1]; 나머지 ◐/○.
  → **공통 공백이자 §4의 기회 영역.**

---

## 4. 향후 유사 도구 개발을 위한 아이디어

1. **메모리는 "버전 관리 가능한 파일"로, 관리는 "비동기 2-모델"로.** Claude Code의 투명
   파일 메모리 + Codex의 2-모델 비동기 요약·병합·30일 pruning을 결합한 하이브리드. [1][8]
2. **자기개선 폐루프의 표준화.** Hermes의 "해결→스킬 문서화→재사용"을 `agentskills.io`
   오픈 표준과 결합해 개인 학습을 팀/생태계 자산으로 확산. [10][11]
3. **다계층 컨텍스트 압축을 기본 탑재 + 조용한 실패 금지.** Claude Code 5계층 파이프라인을
   기본기로, Codex의 32 KiB 절단 같은 silent truncation은 명시적 경고로 보완. [1][4]
4. **하니스 우선 + deny-first 보안.** 7단계 권한·27종 hooks·샌드박스를 기본값으로, 위험
   동작은 단계적 승인 + 사후 감사(append-only). [1][5]
5. **작업별 멀티모델 라우팅(벤더 중립).** 작업 유형(빠름/심층/시각/창작)별 최적 모델 자동
   선택으로 비용·품질 동시 최적화. [5]
6. **격리 컨텍스트 기반 병렬 멀티에이전트 + 검증 역할.** 서브에이전트를 격리·요약 반환하되,
   Antigravity처럼 **Critic·Tester 역할**을 분리해 자가 검증 품질을 높임. [1][3][19]
7. **검증 가능한 산출물(Artifacts).** 계획·스크린샷·테스트 결과를 산출해 사람이 전체 diff를
   읽지 않고 신뢰·검증 — 자율성 확대의 핵심. [3][12]
8. **체크포인트/롤백을 1급 기능으로.** Claude Code의 `/rewind`(코드/대화 선택 복원)는 자율
   실행 신뢰의 안전망 — 모든 자동 편집 에이전트의 표준이 되어야. [14][15]
9. **cron/무인 장기 실행 + 다채널 전달.** Hermes의 자연어 cron + 메신저 게이트웨이는 "장기
   실행 에이전트"의 접근성을 높임. 단, 채널 확장 시 권한·샌드박스를 함께 강화. [22][23]
10. **팀/공유 메모리(미개척 기회).** 현재 거의 모든 도구의 공백(Codex는 명시적 미지원).
    개인 메모리를 안전하게 팀 자산으로 동기화/공유하는 표준이 차세대 차별점이 될 수 있음. [8]

---

## 5. 타 Agent 리포트 교차검증 (Gemini `coding_agents_comparison.md` 비판적 참고)

AGENTS.md §7(취합 친화성) 및 사용자 요청에 따라 Gemini 리포트와 교차검증한다.

**합치하는 지점(상호 보강):**
- Harness-first(코드 ~2%), 27종 hooks, Codex 2-모델 비동기 메모리, 5계층 압축, Hermes 폐루프
  학습, oh-my-openagent LSP+AST·토큰 라우팅 — 양 리포트의 핵심 판정이 일치한다.

**비판적으로 보정한 지점:**
1. **"Max Context" 하드 넘버(예: OpenClaw·Hermes ~128k)는 채택하지 않음.** 컨텍스트 창은
   *연결 모델*에 의존하며 멀티모델 라우팅 도구에서는 단일 수치로 못 박기 어렵다. 본 리포트는
   대신 Compaction(#3)·라우팅(#10)으로 평가하고, 표에서 Max Context 행을 제외했다.
2. **Antigravity 메모리 등급 상향(◐→●).** Gemini는 Antigravity Memory를 ◐로 두었으나,
   공식·리뷰 문서가 **Knowledge Base를 "학습을 코어 프리미티브로 취급"**한다고 명시한다.
   이를 반영해 ●로 상향했다. [19][20]
3. **참조의 검증 가능성.** Gemini References 일부는 URL이 없는 일반 명칭(예: "OS Security
   Review")이다. 본 리포트는 AGENTS.md 규칙대로 **확인 가능한 URL**을 모두 부기했다.
4. **Codex 권한 엔진 묘사.** Gemini의 "Starlark 기반 정책 엔진"은 그럴듯하나 1차 출처 확인이
   어려워, 본 리포트는 공식 문서가 보증하는 *3축 제어(approval/sandbox/network)*로 기술했다. [17][18]

---

## 6. 분류 요약

| 축 | 범용 3종 강점 | 특수 3종 강점 |
|----|--------------|--------------|
| 메모리/압축/하니스/보안 성숙도 | Claude Code · Codex | oh-my-openagent(하니스/토큰) |
| 자기개선·개인화 | 상대적 약함(◐) | **Hermes**(●) |
| 멀티모델·벤더 중립 | 자사 계열(◐) | **oh-my-openagent · OpenClaw**(●) |
| 병렬 오케스트레이션·검증 | Antigravity · Claude Code | OpenClaw · oh-my-openagent · Hermes |
| 브라우저·멀티모달·음성 | Antigravity | Hermes · OpenClaw |
| cron/무인 실행·다채널 | Codex(exec) | Hermes(cron+게이트웨이) |
| 체크포인트/롤백 | **Claude Code**(독보) | — |
| 팀/공유 메모리 | 공통 공백(기회) | 공통 공백(기회) |

---

## References

1. *Dive into Claude Code: The Design Space of Today's and Future AI Agent Systems* — arXiv. https://arxiv.org/html/2604.14228v1
2. *Use Codex with the Agents SDK* — OpenAI Developers. https://developers.openai.com/codex/guides/agents-sdk
3. *Getting Started with Google Antigravity* — Codecademy. https://www.codecademy.com/article/how-to-set-up-and-use-google-antigravity
4. *Custom instructions with AGENTS.md / Configuration Reference* — OpenAI Developers (Codex). https://developers.openai.com/codex/guides/agents-md
5. *oh-my-openagent — Overview & Docs* — code-yeongyu/oh-my-openagent (GitHub). https://github.com/code-yeongyu/oh-my-openagent/blob/dev/docs/guide/overview.md
6. *Context engineering: memory, compaction, and tool clearing* — Claude Cookbook. https://platform.claude.com/cookbook/tool-use-context-engineering-context-engineering-tools
7. *Inside Claude Code: The Architecture Behind Tools, Memory, Hooks, and MCP* — Penligent. https://www.penligent.ai/hackinglabs/inside-claude-code-the-architecture-behind-tools-memory-hooks-and-mcp/
8. *Codex CLI Memory: How It Works + What Mem0 Adds* — Mem0. https://mem0.ai/blog/how-memory-works-in-codex-cli
9. *Agent runtime* — OpenClaw Docs. https://docs.openclaw.ai/concepts/agent
10. *Hermes Agent — Open-Source AI Agent with Persistent Memory* — hermes-agent.org. https://hermes-agent.org/
11. *Hermes Agent Guide: What It Is and How to Use It* — Analytics Vidhya. https://www.analyticsvidhya.com/blog/2026/05/hermes-agent-guide/
12. *Google Antigravity Review: Everything You Need to Know* — Amplifi Labs. https://www.amplifilabs.com/post/google-antigravity-review-everything-you-need-to-know-about-googles-ai-first-ide
13. *awesome-openclaw-skills — Coding Agents & IDEs* — VoltAgent (GitHub). https://github.com/VoltAgent/awesome-openclaw-skills/blob/main/categories/coding-agents-and-ides.md
14. *How Claude Code works* — Claude Code Docs. https://code.claude.com/docs/en/how-claude-code-works
15. *24 Claude Code Tips: Plan Mode, Rewind, CLAUDE.md, Skills, Agents, Plugins* — knightli.com. https://knightli.com/en/2026/05/08/claude-code-24-tips-plan-rewind-skills-agents/
16. *Codex CLI Automations and Scheduled Tasks: Background Agent Workflows* — Codex Knowledge Base. https://codex.danielvaughan.com/2026/03/27/codex-cli-automations-scheduled-tasks/
17. *Agent approvals & security* — OpenAI Developers (Codex). https://developers.openai.com/codex/agent-approvals-security
18. *Sandbox* — OpenAI Developers (Codex). https://developers.openai.com/codex/concepts/sandboxing
19. *Build with Google Antigravity, our new agentic development platform* — Google Developers Blog. https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/
20. *Google Antigravity 2.0: Agent-First Dev Platform Has Landed* — Apidog. https://apidog.com/blog/google-antigravity-2/
21. *Agents & Manager* — Antigravity Lab. https://antigravitylab.net/en/articles/agents
22. *Features Overview* — Hermes Agent Docs (Nous Research). https://hermes-agent.nousresearch.com/docs/user-guide/features/overview
23. *Scheduled Tasks (Cron)* — Hermes Agent Docs (Nous Research). https://hermes-agent.nousresearch.com/docs/user-guide/features/cron

추가 참고:
- *Claude Code Guide 2026: 25 Features with Examples* — MarkTechPost. https://www.marktechpost.com/2026/06/14/claude-code-guide-2026-25-features-with-examples-demo/
- *OpenClaw Explained: The Free AI Agent Tool Going Viral* — KDnuggets. https://www.kdnuggets.com/openclaw-explained-the-free-ai-agent-tool-going-viral-already-in-2026
- *Hermes Agent Docs (v0.2.0)* — mudrii/hermes-agent-docs (GitHub). https://github.com/mudrii/hermes-agent-docs
