# Coding Agents 기능 비교 — 취합 마스터 표 (v0.6)

> **목적:** Claude·Gemini·Antigravity 세 에이전트의 리포트를 통합한 7종 코딩 에이전트 비교표.
> Cline을 포함하여 기존 6종에서 7종으로 확장 (사용자 승인 2026-06-17 15:53 KST).
>
> **작성:** Claude (정리 담당) · **기준일:** 2026-06-17 · **상태:** v0.6
> (v0.5 기반 + 사용자 심층질의(000031) 반영한 3사 합의 등급 보정 — Cline 실무 체감 반영)
> *마스터 표 정리 책임: Claude (사용자 지정 2026-06-17 20:06 KST, 000036).*
>
> **병합 원칙:** 기존 Claude+Gemini 합의(v0.4)를 존중하되, Antigravity 리포트·웹 리서치로
> 확인된 사실은 반영한다. 등급 변경 시 §6에 근거를 명시한다.
>
> **범례:** ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인
> **도구 열 순서(고정, 7종):** Claude Code → Codex CLI → Antigravity → Cline → OpenClaw → oh-my-openagent → Hermes Agent

---

## 0. Executive Summary

- **7종 비교로 확장:** 모델 비종속적 도구의 벤치마크로서 Cline이 추가되었습니다.
- **범용 3종(Claude Code, Codex CLI, Antigravity)은 인프라 성숙도가 강점:** 메모리, 압축, 하니스, 샌드박싱, 체크포인트 등 모델 주변 운영 인프라에서 압도적입니다.
- **특수 3종(OpenClaw, oh-my-openagent, Hermes)은 뾰족한 특화 기능이 강점:** 메시징 UI, 토큰 최적화된 9개 전문 에이전트 라우팅, 자기개선 학습 루프 등이 강점입니다.
- **단일 승자는 없습니다.** 인프라/안전은 범용이 유리하며, 모델 독립성 및 장기 자율 실행은 Cline 및 특수 목적이 유리합니다.
- **차세대 설계 핵심:** 계층형 메모리, 연합 에이전트 프로토콜, 프로그레시브 신뢰, 컨텍스트 증류, 자기개선 폐루프 표준화.

> **전략 라벨(참고):** Context 전략 — Claude=5-Layer · Codex=Async Summary(2-model) · Antigravity=Knowledge Base+1M Context · Cline=Auto Compact+JIT · OpenClaw=Workspace-as-Memory · OmO=Tokenmax/IntentGate · Hermes=3-Tier(Short=MD/Long=SQLite·FTS5/Procedural=Skills).
> 오케스트레이션 — Claude=Agent Teams(shared-file state) · Codex=Goal Mode+Parallel threads · Antigravity=Mission Control(Manager/Writer/Critic/Tester) · Cline=Plan/Act(single-agent) · OpenClaw=Gateway·Channel·LLM · OmO=IntentGate→Sisyphus/Prometheus/Oracle/Atlas/Librarian/Momus/Metis/Explore/Sisyphus-Jr · Hermes=delegate_task(async sub-agents).

---

## 1. 한눈에 보는 비교표

### 1.A Core — 설계·지능

| 지표 | Claude Code | Codex CLI | Antigravity | Cline | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
| Agentic Memory (세션 간 영속) | ● | ● | ● | ◐ | ◐ | ◐ | ● |
| 자기개선 학습 루프 (스킬 자동승격) | ◐ | ◐ | ◐ | ○ | ○ | ○ | ● |
| Context Compaction (토큰 절감) | ● | ◐ | ● | ◐ | ◐ | ● | ◐ |
| 멀티/서브 에이전트 | ● | ◐ | ● | ◐ | ● | ● | ● |
| 멀티모델 라우팅 | ◐ | ◐ | ◐ | ● | ● | ● | ◐ |
| 코드 인텔리전스 (LSP/AST) | ◐ | ◐ | ● | ◐ | ◐ | ● | ◐ |

### 1.B Harness & Ops — 인프라·운영

| 지표 | Claude Code | Codex CLI | Antigravity | Cline | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
| Lifecycle Hooks | ● | ◐ | ◐ | ● | ◐ | ● | ◐ |
| 다단계 권한(Permissions) | ● | ● | ● | ● | ◐ | ◐ | ◐ |
| 샌드박싱(Sandboxing) | ● | ● | ● | ◐ | ○ | ◐ | ◐ |
| 체크포인트/롤백(rewind) | ● | ◐ | ● | ◐ | ○ | ○ | ○ |
| Git/Worktree 격리 | ● | ◐ | ◐ | ○ | ◐ | ◐ | ◐ |
| Headless/CI-Native | ● | ● | ◐ | ◐ | ◐ | ◐ | ◐ |
| 작업 스케줄링(cron) | ◐ | ◐ | ● | ● | ● | ○ | ● |

### 1.C UX & Ecosystem — 경험·확장

| 지표 | Claude Code | Codex CLI | Antigravity | Cline | OpenClaw | oh-my-openagent | Hermes Agent |
|------|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
| Adaptive/개인화 | ◐ | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| 멀티모달(vision·음성) | ◐ | ◐ | ● | ◐ | ◐ | ○ | ● |
| 도구 연결성(MCP) | ● | ● | ● | ● | ◐ | ◐ | ● |
| Skills/확장 | ● | ◐ | ◐ | ● | ● | ● | ● |
| 멀티 서피스/채널 | ◐ | ◐ | ● | ◐ | ● | ○ | ● |
| 세션 핸드오프(cross-device) | ○ | ○ | ◐ | ○ | ◐ | ○ | ● |
| 프로필/설정 배포 | ◐ | ○ | ◐ | ◐ | ● | ○ | ● |
| 팀/공유 메모리 | ◐ | ○ | ◐ | ○ | ◐ | ○ | ◐ |

---

## 2. 도구별 한 줄 포지셔닝

| 도구 | 분류 | 핵심 정체성 |
|------|------|-------------|
| Claude Code | 범용 | 최소 스캐폴딩+최대 하니스. 5-Layer 압축·27 hooks·7권한·/rewind·/loop·Agent Teams. 기본 모델: Opus 4.8 [1][4][5][6] |
| Codex CLI | 범용 | AGENTS.md 표준+Goal Mode 장기 목표. execpolicy(Starlark)+Seatbelt/Landlock, codex exec 무인 실행. 기본 모델: GPT-5.5 [7][9][10][11] |
| Antigravity | 범용(Agent-first IDE) | Gemini 3.1 Pro, Knowledge Base+1M Context, Mission Control, agy CLI(Go), 4-surface [13][16][17] |
| Cline | 범용(Model-agnostic) | 모델 비종속+SDK 5계층 아키텍처. Memory Bank+Auto Compact+JIT, MCP Marketplace. VS Code+JetBrains+CLI [19][22][23][24] |
| OpenClaw | 특수(로컬 자동화) | 100+ 스킬(SKILL.md+ClawHub)+메시징 UI(WhatsApp/Telegram/Slack). 보안 주의 필요 [26][27][32] |
| oh-my-openagent | 특수(토큰 최적 하니스) | IntentGate→9 전문 에이전트. 카테고리별 멀티모델 라우팅+Fallback Chains [33][36][37] |
| Hermes Agent | 특수(자기개선 장기 실행) | Closed Learning Loop(Execute→Evaluate→Extract→Refine→Reuse). 3-Tier 메모리+cron+다채널 게이트웨이 [38][39][45] |

---

## 3. 지표 정의 (취합 합의용)

| 지표 | 정의 | 비고 |
|------|------|------|
| 자기개선 학습 루프 | 작업 성공 경험을 재사용 가능한 스킬로 자동 승격하는 폐루프 | 단순 메모리 누적은 제외 |
| 세션 핸드오프 | 다른 기기/채널로 세션을 무중단 이전 | 같은 기기 resume 제외 |
| 작업 스케줄링 | 도구 내장 cron/스케줄러 | 외부 cron 의존은 ◐ |
| Headless/CI-Native | 비대화형 실행+구조화 출력+CI 액션 | 1급은 공식 CI 액션 보유 |
| 샌드박싱 | OS 수준 격리(Seatbelt/Landlock/nsjail/컨테이너 등) | 로컬 보존은 ◐ |
| 체크포인트/롤백 | 변경 전 스냅샷+코드/대화 선택 복원 | Artifacts/git 간접은 ◐ |
| 멀티모델 라우팅 | 복수 LLM + 작업별 최적 모델 자동 선택 | 단일 벤더는 ◐ |
| 코드 인텔리전스 | LSP/AST 기반 정밀 분석 및 리팩토링 | 텍스트 검색은 ◐ |

---

## 4. 상세 기능 분석 (핵심 요약)

*참고: v0.5에서는 10대 영역 41개 세부 지표 분석을 통합. 핵심 요약만 표시합니다.*

- **Claude Code:** CLAUDE.md 기반 3계층 메모리 [1], 5-Layer 압축 [4], --safe-mode 지원 [S1].
- **Codex CLI:** Goal Mode를 통한 장기 자율 실행 [S5], --full-auto 모드 제공.
- **Antigravity:** Knowledge Items (KI) 및 Gemini 1M+ 토큰 결합 [16], CLI(Go 재작성) 및 데스크탑의 양방향 동기화 [17].
- **Cline:** SDK 5계층 아키텍처 기반의 강력한 모델 비종속성 [23], 네이티브 cron 및 Plan/Act 모드 제공 [25].
- **OpenClaw:** 다양한 메시징 플랫폼과 통합 [26]. 다만 ClawHub를 통한 악성 스킬 등 보안 취약점 보고 [S8].
- **oh-my-openagent:** IntentGate 기반의 정교한 9개 전문 에이전트 라우팅 최적화 [36].
- **Hermes Agent:** 5회 이상 Tool 호출 시 트리거되는 Closed Learning Loop 로 스스로 스킬 정제 [45].

---

## 5. 향후 유사 도구 개발 아이디어 (15항 통합)

1. **투명 파일 메모리 + 비동기 2-모델 관리** (Claude 파일 메모리 × Codex 관리)
2. **자기개선 폐루프의 표준화** (Hermes Closed Learning Loop)
3. **계층형 메모리 아키텍처 통합** (3-tier: Working / Episodic / Semantic)
4. **다계층 컨텍스트 압축 + 컨텍스트 증류** (단순 요약 대신 결정/제약/다음단계 추출)
5. **Harness-first + deny-first 보안** (보안은 옵션이 아닌 기본 인프라)
6. **프로그레시브 신뢰 모델 (Progressive Trust Escalation)**
7. **작업별 멀티모델 라우팅 및 의도 자동 분류 (IntentGate)**
8. **연합 에이전트 프로토콜 (Federated Agent Protocol)**
9. **역할 분담형 병렬 멀티에이전트 + 검증 역할** (Antigravity Mission Control 패턴)
10. **검증 가능한 산출물(Artifacts) 도입**
11. **체크포인트/롤백 1급 안전망 필수화**
12. **CI-Native 헤드리스 표준**
13. **cron 무인 실행 + 다채널 핸드오프**
14. **SDK 기반 통합 플러그인 프레임워크**
15. **팀/공유 메모리 배포 표준화**

---

## 6. 검증·합의 이력

### 6-0. v0.6 등급 변경 목록 (2026-06-17) — 사용자 심층질의 반영 (3사 합의)
> 사용자 질문(`messages/000031_User_Question.md`)에서 제기된 **문서 claim ≠ 실사용 reality**
> 지적을 Claude·Gemini·Antigravity 3사가 검토해 만장일치로 보정. 각 사 답변:
> `claude/`·`gemini/`·`antigravity/answer_master_comparison.md`.

| 도구 | 지표 | v0.5 | v0.6 | 근거 |
|------|------|:---:|:---:|------|
| Cline | Agentic Memory | ● | **◐** | Memory Bank는 파일 규약(`.clinerules`)형 — 자동 회상·write-back 보장 약함, 컨텍스트 길어지면 갱신 누락 (3사 합의) |
| Cline | Context Compaction | ● | **◐** | Auto Compact 존재하나 세부(디버깅 로그·초기 제약) 유실 + 재낭비 잦음 — 품질 측면 ● 아님 (사용자 pain point 확인) |
| Cline | Adaptive/개인화 | ● | **◐** | 정적 커스텀 인스트럭션 주입 한정, 진정한 행동 적응 알고리즘 부재 (사용자 코드분석 확인) |
| Cline | 멀티/서브 에이전트 | ○ | **◐** | 과소평가 보정 — 기본 앱은 단일(Plan/Act)이나 **`@cline/sdk`로 멀티에이전트 구성 가능** (Claude 제안) |

*보정 메타: v0.6은 표의 구조적 약점(기능 유무는 담으나 품질·체감은 못 담음)을 보완.
하향 3건은 과대평가 교정, 상향 1건은 과소평가 교정으로 양방향 정합.*

### 6-A. v0.5 등급 변경 목록 (2026-06-17)
| 도구 | 지표 | v0.4 | v0.5 | 근거 |
|------|------|------|------|------|
| Antigravity | Context Compaction | ◐ | ● | 자동 컴팩션+가상 FS 오프로딩 확인 [16] |
| Antigravity | 다단계 권한 | ◐ | ● | Permission UI 체계 확인 [18] |
| Antigravity | 멀티 서피스 | ◐ | ● | 4-surface(CLI/IDE/Desktop/SDK) 확인 [17] |
| OpenClaw | 샌드박싱 | ◐ | ○ | 악성 스킬 등 보안 취약점 보고 [S8] |
| Codex CLI | 브라우저 자동화 | ○ | ◐ | Desktop 앱 computer-use 확인 [S5] |
| Cline | (신규 추가) | - | 7종 | Antigravity 리포트 및 웹 리서치 종합 |

*(기존 v0.4 검증 이력 유지)*

---

## 7. References

**Claude Code [1-6]:**
[1] Anthropic, "Claude Code Memory System," 2026.
[2] Anthropic, "Claude Code Skills," 2026.
[3] Anthropic, "Claude Code Overview," 2026.
[4] Anthropic, "Claude Context Management," 2026.
[5] Anthropic, "Claude Agent SDK," 2026.
[6] Anthropic, "Claude Multi-Agent," 2026.

**Codex CLI [7-12]:**
[7] OpenAI, "Codex CLI Config," 2026.
[8] OpenAI, "Codex CLI Skills," 2026.
[9] OpenAI, "Codex Context," 2026.
[10] OpenAI, "Codex Hooks & Sandbox," 2026.
[11] OpenAI, "Codex Desktop App," 2026.
[12] OpenAI, "Codex execpolicy," 2026.

**Antigravity [13-18]:**
[13] Google DeepMind, "Antigravity Knowledge Items," 2026.
[14] Google DeepMind, "Antigravity Artifacts," 2026.
[15] Google DeepMind, "Antigravity Gemini Integration," 2026.
[16] Google DeepMind, "Antigravity Context," 2026.
[17] Google DeepMind, "Antigravity 2.0," 2026.
[18] Google DeepMind, "Antigravity Planning Mode," 2026.

**Cline [19-25]:**
[19] Cline, "Memory Bank Framework," 2026.
[20] Cline, "Cline Rules," 2026.
[21] Cline, "User Preferences," 2026.
[22] Cline, "Auto Compact," 2026.
[23] Cline, "Cline SDK Architecture," 2026.
[24] Cline, "Cline Plugins," 2026.
[25] Cline, "Plan/Act Mode," 2026.

**OpenClaw [26-32]:**
[26] OpenClaw, "Architecture," 2026.
[27] OpenClaw, "Memory System," 2026.
[28] OpenClaw, "Personalization," 2026.
[29] OpenClaw, "Context," 2026.
[30] OpenClaw, "Multi-Agent," 2026.
[31] OpenClaw, "Models," 2026.
[32] OpenClaw, "Security," 2026.

**oh-my-openagent [33-37]:**
[33] oh-my-openagent, "Memory Integration," 2026.
[34] oh-my-openagent, "MCP Tools," 2026.
[35] oh-my-openagent, "Compaction Hooks," 2026.
[36] oh-my-openagent, "Orchestration," 2026.
[37] oh-my-openagent, "IntentGate," 2026.

**Hermes Agent [38-45]:**
[38] Nous Research, "Hermes Architecture," 2026.
[39] Nous Research, "Hermes Memory," 2026.
[40] Nous Research, "Personalization," 2026.
[41] Nous Research, "SQLite FTS5," 2026.
[42] Nous Research, "Tool System," 2026.
[43] Nous Research, "Sub-Agent Delegation," 2026.
[44] Nous Research, "Model Config," 2026.
[45] Nous Research, "Closed Learning Loop," 2026.

**보충 리서치 [S1-S10]:**
[S1] arXiv, "Dive into Claude Code," 2026.
[S5] OpenAI, "Introducing Codex Goal Mode," 2026.
[S7] Antigravity, "Terminal Sandboxing & CLI," 2026.
[S8] KDnuggets, "OpenClaw Explained (Security)," 2026.
[S10] Hermes Agent, "Features Overview," 2026.

---

### 변경 이력
- **v0.6 (2026-06-17, Claude 정리):** 사용자 질문(000031)에 따른 3사(Claude·Gemini·Antigravity) 합의 반영. Cline 메모리·압축·개인화 ●→◐ 하향 + 멀티에이전트 ○→◐ 보정. "Marketing Claim vs Reality" 간극 해소(근거 §6-0). *주: Gemini가 000035에서 v0.6 완료를 보고했으나 실제 파일엔 개인화 1건만 반영돼 있어, Claude가 누락 3건·헤더·변경이력·깨진 조각을 정합화함.*
- **v0.5 (2026-06-17):** Antigravity 통합. ① Cline 추가 — 7종 비교로 확장(사용자 승인 완료). ② Antigravity 자체 평가 상향 반영. ③ 최신 웹 리서치 반영(Codex Goal Mode, Cline SDK/cron, OpenClaw 보안 취약점 등). ④ 향후 아이디어 15항으로 체계화.
- **v0.4 (2026-06-17):** Gemini 000018 + Claude 재검증. Antigravity 체크포인트 ● 상향 등 ‡ 합의 해소.
