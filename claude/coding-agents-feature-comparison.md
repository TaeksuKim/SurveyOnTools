# Coding Agents 기능 비교표

> 범용 Coding Agents(**Claude Code**, **Codex CLI**, **Antigravity**)와 특수 목적
> Agents(**OpenClaw**, **oh-my-openagent**, **Hermes Agent**)가 제공하는 **고급(advanced)
> 기능**을 비교한다. 단순 코드 자동완성·파일 편집 같은 기본 기능은 제외하고, 차세대 도구
> 설계에 영향을 주는 기능(에이전트 메모리, 하니스 엔지니어링, 개인화, 도구 연결성, 컨텍스트
> 압축, 멀티 에이전트 오케스트레이션 등)에 초점을 맞춘다.
>
> *작성 기준일: 2026-06-17. 평가는 아래 References에 정리한 공개 문서/리뷰 기준이며,
> 특수 목적 도구 일부는 공식 문서가 제한적이어서 추정이 포함될 수 있다.*

---

## 1. 한눈에 보는 비교표

**범례:** ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인

| # | 고급 기능 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
|---|-----------|:----:|:----:|:----:|:----:|:----:|:----:|
| 1 | **Agentic Memory** (세션 간 영속 메모리) | ● | ● | ◐ | ◐ | ◐ | ● |
| 2 | **자기개선 학습 루프** (실행에서 재사용 스킬 자동 생성) | ◐ | ◐ | ◐ | ○ | ○ | ● |
| 3 | **Context Compaction** (토큰 절감/압축) | ● | ◐ | ◐ | ◐ | ● | ◐ |
| 4 | **Harness Engineering** (hooks·권한·샌드박스·생명주기) | ● | ◐ | ◐ | ◐ | ● | ◐ |
| 5 | **Adaptive/개인화** (사용자와 함께 성장) | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| 6 | **멀티/서브 에이전트 오케스트레이션** | ● | ◐ | ● | ● | ● | ● |
| 7 | **도구 연결성** (MCP·외부 통합) | ● | ● | ● | ● | ◐ | ● |
| 8 | **Skills/확장 프레임워크** | ● | ◐ | ◐ | ● | ● | ● |
| 9 | **멀티모델 라우팅** (작업별 모델 선택) | ◐ | ◐ | ◐ | ● | ● | ◐ |
| 10 | **멀티 서피스/채널 접근** (CLI·IDE·메신저) | ◐ | ◐ | ◐ | ◐ | ○ | ● |

**한 줄 포지셔닝**

| 도구 | 분류 | 핵심 정체성 |
|------|------|-------------|
| **Claude Code** | 범용 | 최소 스캐폴딩 + 최대 운영 하니스. 메모리·압축·hooks·권한이 가장 성숙 |
| **Codex CLI** | 범용 | `AGENTS.md` 표준 + 백그라운드 자동 메모리 요약. MCP 생태계 |
| **Antigravity** | 범용(Agent-first IDE) | Gemini 3 Pro 기반, Agent Manager로 병렬 에이전트 + Artifacts 검증 |
| **OpenClaw** | 특수(로컬 자동화) | 100+ 스킬 플러그인, 단일 임베디드 런타임, 브라우저/cron 타입드 툴 |
| **oh-my-openagent** | 특수(토큰 최적 하니스) | "tokenmaxxers"용 하니스. 카테고리별 멀티모델 라우팅 + 5+ 병렬 |
| **Hermes Agent** | 특수(자기개선 장기 실행) | 영속 메모리 + 학습 루프, 메신저 게이트웨이 다채널 |

---

## 2. 기능별 상세 설명

### 2.1 Agentic Memory — 세션 간 영속 메모리
과거 사용자 행동·프로젝트 맥락을 저장하고 이후 세션에서 활용하는 능력.

- **Claude Code (●):** 4단계 `CLAUDE.md` 계층(global → project → directory → file)에
  더해, 대화 중 에이전트가 직접 작성하는 auto-memory 항목을 *불투명 임베딩이 아닌
  버전 관리 가능한 파일*로 저장한다. [1][7]
- **Codex CLI (●):** 2계층 구조. `AGENTS.md`(정적 지시 계층) + Memories(생성 계층).
  세션이 수 시간 유휴 상태가 되면 **백그라운드에서 비동기로** 대화를 요약해
  `~/.codex/memories/`에 기록한다. *한 모델이 기억할 가치를 판단하고, 두 번째 모델이
  기존 저장소와 병합*하는 2-모델 방식. 30일 미사용 항목은 정리(pruning). [4][8]
- **Antigravity (◐):** `.antigravity/brain/` 폴더에 작업 체크리스트·계획·완료 요약을
  보관하고, Artifacts(구조화 요약)로 맥락을 유지한다. 다만 자동 누적형 장기 메모리는
  상대적으로 덜 성숙하다. [3]
- **OpenClaw (◐):** `AGENTS.md`(운영 지시+"memory"), `SOUL.md`(페르소나), `USER.md`(사용자
  프로필)를 세션 시작 시 시스템 프롬프트에 주입. *정적 bootstrap 파일 기반*이라 자동
  누적·요약보다는 설정형에 가깝다. [9]
- **oh-my-openagent (◐):** 하니스/오케스트레이션 중심이며 메모리는 파일 기반 보조 수단.
  공개 문서상 자동 메모리 요약은 핵심으로 강조되지 않는다. [5]
- **Hermes Agent (●):** 영속 cross-session 메모리가 정체성. *"오래 실행할수록 당신을 더 잘
  안다"* — 선호도·프로젝트·환경을 세션 간 자동 기억한다. [10][11]

### 2.2 자기개선 학습 루프 — 재사용 스킬 자동 생성
어려운 작업을 해결한 뒤 그 방법을 재사용 가능한 산출물로 정착시키는 폐루프.

- **Hermes Agent (●):** 정의적 기능. *"어려운 문제를 풀면 다시는 잊지 않도록 재사용 가능한
  스킬 문서를 작성"*한다. 쓸수록 능력이 누적된다. [10][11]
- **Claude Code / Codex (◐):** auto-memory·메모리 병합으로 맥락은 누적되지만, "성공 사례를
  실행 가능한 스킬로 자동 승격"하는 폐루프는 1급 기능이 아니다. [1][8]
- **나머지 (◐/○):** Antigravity는 Artifacts 재사용으로 부분 지원, OpenClaw/oh-my-openagent는
  자동 스킬 생성을 핵심으로 내세우지 않음.

### 2.3 Context Compaction — 토큰 절감/압축
긴 대화를 고충실도 요약으로 압축해 성능 저하 없이 작업을 이어가는 능력.

- **Claude Code (●):** **5계층 압축 파이프라인**(Budget reduction → Snip → Microcompact →
  Context collapse → Auto-compact)으로 200K–1M 토큰 창을 관리. 각 계층이 비용-효용
  트레이드오프가 다르며 저렴한 계층부터 적용. 자동 압축 후 최근 스킬을 재첨부. [1][6]
- **oh-my-openagent (●):** 스스로를 *"tokenmaxxers를 위한 하니스"*로 정의. 토큰 효율이
  설계 정체성이며 작업 범위 스코핑(IntentGate)·임베디드 MCP로 컨텍스트를 좁힌다. [5]
- **Codex CLI (◐):** 압축 기능과 `/compact`을 제공하나 `AGENTS.md`에 **32 KiB 상한**이 있어
  대형 모노레포에서는 조용한 절단(truncation)이 발생할 수 있다. [4][8]
- **Antigravity / OpenClaw / Hermes (◐):** Artifacts·세션 요약·영속 메모리로 간접적으로
  컨텍스트 부담을 줄이나, 문서화된 다계층 압축 파이프라인은 확인되지 않음. [3][9][10]

### 2.4 Harness Engineering — 권한·hooks·샌드박스·생명주기
모델 주변의 결정론적 운영 인프라. 안전·재현성·통제의 핵심.

- **Claude Code (●):** *코드의 ~1.6%만 AI 결정 로직, 98.4%가 인프라*라는 "최소 스캐폴딩,
  최대 하니스" 철학. **27종 생명주기 hooks**(PreToolUse/PostToolUse/PermissionDenied 등),
  **7단계 권한 모드**(plan ~ bypassPermissions), deny-first 규칙 평가, 샌드박싱, append-only
  JSONL 세션(resume/fork/audit). [1]
- **oh-my-openagent (●):** *"복잡한 코드베이스를 위한 유일한 에이전트 하니스"*를 표방.
  IntentGate(요청 사전 분류), LSP+AST 도구(rename·정의 이동·진단)로 하니스 자체가 정체성. [5]
- **Codex CLI (◐):** 설정 파일, 샌드박스 모드, 승인 정책(approval policy)을 제공하나
  hooks 생태계는 Claude Code 대비 제한적. [4]
- **Antigravity (◐):** Planning Mode·Artifact 검토 게이트로 인간 개입 지점을 제공. [3]
- **OpenClaw (◐):** 단일 임베디드 런타임 + 도구 정책(tool policy) + worktree 전략. [9]
- **Hermes Agent (◐):** state·routing·scheduling·evaluation hooks를 한 패키지로 제공. [10]

### 2.5 Adaptive / 개인화 — 사용자와 함께 성장
사용 이력에 맞춰 도구가 점진적으로 개인화되는 정도.

- **Hermes Agent (●):** *"오래 실행할수록 당신을 더 잘 안다"* — 코딩 패턴·선호·맥락을 자동
  학습하여 재설명 부담을 제거. [10][11]
- **Claude Code (◐):** `CLAUDE.md` 계층 + 시간에 따라 "공동 구축되는(co-constructed)" 신뢰
  관계(권한 상향). 단 명시적 자동 개인화 모델은 아님. [1]
- **Codex CLI (◐):** Memories 누적으로 점진 개인화. [8]
- **Antigravity (◐):** Knowledge/피드백 루프로 사용자 의도에 맞춰 계획을 조정. [12]
- **OpenClaw (◐):** `USER.md`(선호 호칭·프로필) + `SOUL.md`(페르소나)로 명시 개인화하나
  정적 설정 성격. [9]
- **oh-my-openagent (○):** 개인화보다 작업별 최적 모델 라우팅에 집중. [5]

### 2.6 멀티/서브 에이전트 오케스트레이션
- **Claude Code (●):** 서브에이전트가 **격리된 컨텍스트(sidechain)**에서 실행, 요약만 부모로
  반환해 컨텍스트 압력을 관리. 메모리는 공유하지 않음. [1]
- **Antigravity (●):** Agent Manager가 **최대 5개 병렬 에이전트**를 오케스트레이션. [3]
- **oh-my-openagent (●):** Sisyphus(오케스트레이터)·Prometheus(플래너)·Hephaestus(심층 워커)
  등 특화 에이전트가 **5+ 병렬** 실행(연구·구현·검증 동시). [5]
- **OpenClaw (●):** 한 에이전트가 계획, 다른 에이전트들이 실행 후 결과 통합하는 워크플로. [13]
- **Hermes Agent (●):** 병렬 워크스트림용 격리 서브에이전트 스폰. [10]
- **Codex CLI (◐):** 코어는 단일 에이전트이나 OpenAI Agents SDK로 다중 에이전트 파이프라인
  구성 가능. [2]

### 2.7 도구 연결성 — MCP / 외부 통합
- **Claude Code (●):** MCP(stdio·SSE·HTTP·WebSocket) + Plugins. 확장을 *단일 API가 아닌
  컨텍스트 비용이 다른 계층형 메커니즘*으로 제공. [1]
- **Codex CLI (●):** `codex mcp add`로 STDIO·HTTP(인증) 서버 추가. Context7·Figma·Playwright·
  GitHub·Sentry 등 통합. [4]
- **Hermes Agent (●):** 40+ 도구(웹 검색·브라우저 자동화·비전·이미지 생성·TTS). [10][11]
- **OpenClaw (●):** 브라우저·canvas·nodes·cron을 *타입드 1급 도구*로 노출(쉘 불필요),
  100+ 스킬. [9][13]
- **Antigravity (●):** 코드 에디터 + 터미널 + 내장 브라우저 + MCP 지원. [3][12]
- **oh-my-openagent (◐):** "임베디드 MCP를 가진 스킬" + LSP+AST 도구. 통합 폭은 작업
  스코핑 중심. [5]

### 2.8 Skills / 확장 프레임워크
- **Claude Code (●):** `.claude/skills/` 스킬 + 플러그인 번들. [1]
- **OpenClaw (●):** 스킬 플러그인 시스템(100+ 빌트인), `awesome-openclaw-skills` 생태계. [13]
- **Hermes Agent (●):** 40+ 빌트인 스킬, **자동 스킬 생성**, `agentskills.io` 오픈 표준 호환. [10][11]
- **oh-my-openagent (●):** 임베디드 MCP를 가진 스킬을 작업별로 스코프. [5]
- **Codex CLI (◐):** `AGENTS.md` 중심, 스킬 마켓플레이스 성격은 약함. [4]
- **Antigravity (◐):** Artifacts/플러그인 기반 확장. [3]

### 2.9 멀티모델 라우팅
- **oh-my-openagent (●):** 카테고리 라우팅 — `ultrabrain`→GPT-5.5 xhigh, `deep`→GPT-5.5,
  `visual-engineering/artistry`→Gemini, `quick`→GPT-5.4 Mini. Claude·GPT·Gemini·Kimi·GLM
  지원으로 벤더 종속 탈피. [5]
- **OpenClaw (●):** 모델 라우팅 + 멀티 프로바이더. Claude Code·Codex·OpenCode가 동일 도구·
  라우팅·worktree 공유. [9]
- **Claude Code / Codex / Antigravity (◐):** 각각 Claude/OpenAI/Gemini 자사 계열 중심,
  일부 모델 선택 제공. [1][4][12]
- **Hermes Agent (◐):** 선호 LLM을 연결하는 방식. [10]

### 2.10 멀티 서피스 / 채널 접근
- **Hermes Agent (●):** Telegram·Discord·Slack·WhatsApp·Signal·CLI를 **통합 게이트웨이**로
  연결 — 텔레그램에서 시작해 터미널에서 이어받기 가능. [10][11]
- **Claude Code / Codex / Antigravity (◐):** 개발자 서피스(CLI·IDE·web·desktop) 중심,
  메신저 채널은 비초점. [1][4][3]
- **OpenClaw (◐):** Gateway당 단일 임베디드 런타임. [9]
- **oh-my-openagent (○):** Codex·OpenCode를 위한 CLI 하니스에 집중. [5]

---

## 3. 향후 유사 도구 개발을 위한 아이디어

위 비교에서 도출되는, 차세대 코딩 에이전트 설계 시 고려할 시사점:

1. **메모리를 "불투명 임베딩"이 아닌 "버전 관리 가능한 파일"로.** Claude Code·Codex의
   파일 기반 메모리는 감사·공유·수정이 가능하다. 여기에 Codex의 *2-모델 비동기 요약·병합·
   30일 pruning*을 결합하면 신뢰성과 비용을 동시에 잡을 수 있다. [4][8]
2. **자기개선 폐루프의 표준화.** Hermes의 "해결→스킬 문서화→재사용"을 `agentskills.io` 같은
   **오픈 스킬 표준**과 결합하면 개인 학습이 팀/생태계 자산으로 확산된다. [10][11]
3. **다계층 컨텍스트 압축을 기본 탑재.** Claude Code의 5계층 파이프라인처럼 *저렴한 계층부터
   적용하는* 비용-효용 단계화는 모든 장기 실행 에이전트의 기본기가 되어야 한다. Codex의
   32 KiB 절단 같은 *조용한 실패*는 명시적 경고로 보완 필요. [1][4]
4. **하니스 우선 설계(harness-first).** Claude Code(인프라 98.4%)와 oh-my-openagent(하니스가
   정체성)가 보여주듯, 모델 품질만큼 **결정론적 권한·hooks·샌드박스**가 생산성/안전을 가른다.
   deny-first + 인간 에스컬레이션을 기본값으로. [1][5]
5. **작업별 멀티모델 라우팅.** oh-my-openagent의 카테고리 라우팅처럼 *작업 유형(빠름/심층/
   시각/창작)별 최적 모델 선택*은 비용과 품질을 동시에 최적화한다. 단일 벤더 종속을 피할 것. [5]
6. **격리 컨텍스트 기반 병렬 멀티에이전트.** Claude Code(sidechain), Antigravity(5 병렬),
   oh-my-openagent(연구·구현·검증 동시)의 공통 패턴 — 서브에이전트는 *격리 후 요약만 반환*해
   상위 컨텍스트를 보호. [1][3][5]
7. **검증 가능한 산출물(Artifacts).** Antigravity의 계획·스크린샷·브라우저 기록 산출물은
   사람이 전체 diff를 읽지 않고도 신뢰·검증하게 한다 — 팀 협업·자율성 확대의 핵심. [3][12]
8. **개발 서피스를 넘어선 다채널 접근.** Hermes의 메신저 게이트웨이는 "장기 실행 에이전트"의
   접근성을 크게 높인다. 단, 채널 확장 시 **권한·샌드박스 하니스**를 함께 강화해야 한다. [10]

---

## 4. 분류 요약

| 축 | 범용 3종 강점 | 특수 3종 강점 |
|----|--------------|--------------|
| 메모리/압축/하니스 성숙도 | Claude Code · Codex가 우위 | oh-my-openagent(하니스/토큰) |
| 자기개선·개인화 | 상대적 약함(◐) | **Hermes Agent**가 선도(●) |
| 멀티모델·벤더 중립 | 자사 계열 중심(◐) | **oh-my-openagent · OpenClaw**(●) |
| 병렬 오케스트레이션 | Antigravity·Claude Code | OpenClaw·oh-my-openagent·Hermes |
| 접근 채널 폭 | 개발자 서피스 | **Hermes**(메신저 다채널) |

---

## References

1. *Dive into Claude Code: The Design Space of Today's and Future AI Agent Systems* — arXiv. https://arxiv.org/html/2604.14228v1
2. *Use Codex with the Agents SDK* — OpenAI Developers. https://developers.openai.com/codex/guides/agents-sdk
3. *Getting Started with Google Antigravity* — Codecademy / Google Codelabs. https://www.codecademy.com/article/how-to-set-up-and-use-google-antigravity
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

추가 참고:
- *Claude Code Guide 2026: 25 Features with Examples* — MarkTechPost. https://www.marktechpost.com/2026/06/14/claude-code-guide-2026-25-features-with-examples-demo/
- *OpenClaw Explained: The Free AI Agent Tool Going Viral* — KDnuggets. https://www.kdnuggets.com/openclaw-explained-the-free-ai-agent-tool-going-viral-already-in-2026
- *Hermes Agent Docs (v0.2.0)* — mudrii/hermes-agent-docs (GitHub). https://github.com/mudrii/hermes-agent-docs
