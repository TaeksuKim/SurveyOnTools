# 코딩 에이전트 심층 비교 분석 보고서 (v2.2)

> 작성 기준일: 2026-06-17
>
> **Caveat**: 특수 목적형 에이전트(OpenClaw, oh-my-openagent, Hermes Agent)의 경우 공식 문서가 제한적일 수 있어, 일부 기능 평가는 커뮤니티 리뷰 및 기술 블로그 기반의 추정을 포함하고 있습니다.
>
> 본 보고서는 주요 범용 코딩 에이전트와 특수 목적형 에이전트들의 기능을 20개 이상의 핵심 지표를 바탕으로 분석한 최종 결과물입니다. 특히 에이전트의 내부 인프라(Harness), 자가 진화 능력(Learning Loop), 그리고 사용자 경험(Surface/Channel)의 차별점에 집중하였습니다.

## 1. 종합 비교 테이블

**범례: ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인**

| 카테고리 | 비교 항목 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Memory** | **Agentic Memory** | ● | ● | ◐ | ◐ | ◐ | ● |
| | **Learning Loop** | ◐ | ◐ | ◐ | ○ | ○ | ● |
| **Context** | **Compaction** | ● | ◐ | ◐ | ◐ | ● | ◐ |
| | **Max Context** | 200k - 1M | ~200k | **1M+** | ~128k | 200k+ | ~128k |
| **Harness** | **Lifecycle Hooks** | ● | ◐ | ◐ | ◐ | ● | ◐ |
| | **Sandboxing** | ● | ● | ● | ◐ | ◐ | ● |
| | **Permissions** | ● | ● | ◐ | ◐ | ◐ | ◐ |
| **Orchestration**| **Multi-Agent** | ● | ◐ | ● | ● | ● | ● |
| | **Model Routing** | ◐ | ◐ | ◐ | ● | ● | ● |
| **Capability** | **Multi-Modality** | ● | ◐ | ● | ◐ | ○ | ● |
| | **Code Analysis** | ● | ◐ | ● | ◐ | ● | ◐ |
| **Ops & CI/CD** | **CI/CD Integration**| ◐ | ◐ | ● | ○ | ○ | ◐ |
| | **Headless Mode** | ● | ● | ● | ● | ◐ | ● |
| **Collaboration**| **Session Handoff** | ○ | ○ | ◐ | ◐ | ○ | ● |
| | **Profile Dist.** | ○ | ○ | ◐ | ● | ○ | ● |
| **Access** | **Surface/Channel** | CLI / IDE | CLI | IDE / TUI | Messaging | CLI | **Msg Gateway** |
| | **Ecosystem** | MCP / Skills | MCP / Agents | Plugin / MCP | ● | MCP / Skills | Skill Standard |

*●: 최상(Native 지원) / ◐: 부분 지원 / ○: 미지원*

---

## 2. 차별화된 핵심 기능 상세 분석

### 2.1. 인프라의 완성도: Harness Engineering & Lifecycle Hooks
*   **Claude Code**: 코딩 로직은 2% 미만이며 나머지 98%가 인프라인 "Harness-first" 철학을 가집니다. 특히 **27종의 Lifecycle Hooks**를 통해 도구 사용 전후, 권한 거부 시점 등에 정교한 개입이 가능합니다 [1][7].
*   **Codex CLI**: Rust로 작성된 **Starlark 기반 정책 엔진**을 통해 실행 권한을 제어하며, 보안과 속도를 동시에 잡았습니다 [2][4].
*   **oh-my-openagent**: LSP(Language Server Protocol)와 AST-Grep을 하니스에 내장하여, 단순 텍스트 편집이 아닌 구문 분석 기반의 정밀한 리팩토링 기능을 제공합니다 [5].

### 2.2. 지속 가능성: Agentic Memory & Learning Loop
*   **Hermes Agent**: 에이전트의 '성장'에 가장 집중합니다. 어려운 문제를 해결하면 그 과정을 **자동으로 스킬 문서화**하여 다음 세션에서 즉시 사용 가능한 자산으로 승격시키는 폐루프(Closed-loop)를 구현했습니다 [10][11].
*   **Codex CLI**: 수 시간 유휴 시 백그라운드에서 **2개의 모델이 협력(요약 모델 + 병합 모델)**하여 장기 기억을 관리하고, 30일간 사용되지 않은 기억을 정리(Pruning)하는 효율적인 관리 체계를 갖췄습니다 [8].

### 2.3. 토큰 경제학: Context Compaction & Model Routing
*   **Claude Code**: Budget reduction부터 Auto-compact까지 **5단계 압축 파이프라인**을 통해 비용 대비 효용이 높은 컨텍스트를 유지합니다 [6].
*   **oh-my-openagent**: "Tokenmaxxers"를 위한 도구로, 작업의 복잡도에 따라 모델을 자동 라우팅(예: 아키텍처는 고성능, 단순 검색은 저비용 모델)하여 토큰 비용을 극단적으로 최적화합니다 [5].

### 2.4. CI/CD 및 운영 (New): CI/CD Integration & Headless Mode
*   **Antigravity**: GitHub Actions와의 강력한 통합을 지원합니다. 로컬에서 CI 파이프라인 파일을 생성할 뿐만 아니라, **Headless Mode**를 통해 PR 리뷰나 보안 스캔을 자동화하는 CI 워커로 동작할 수 있습니다 [3][12].
*   **Claude Code / Codex CLI**: 각각 전용 SDK 및 `--non-interactive` 플래그를 통해 CI/CD 환경에서의 무인 자동화 실행을 완벽히 지원합니다 [1][2].

### 2.5. 협업 및 세션 관리 (New): Session Handoff & Profile Distribution
*   **Hermes Agent**: `/handoff` 명령어를 통해 CLI에서 시작한 작업을 모바일 메신저(Telegram, Discord 등)로 즉시 전송하여 맥락 유지 상태에서 협업할 수 있는 **Multi-platform Gateway**가 강점입니다 [10].
*   **OpenClaw / Hermes**: 특정 에이전트의 설정(페르소나, 스킬, 도구 연결)을 **Profile Distribution** 형태로 패키징하여 팀원들에게 배포할 수 있으며, 이 과정에서 개인 API 키나 메모리는 보호됩니다 [9][10].

---

## 3. 향후 유사 도구 개발을 위한 전략적 제언

본 조사를 통해 도출된 유의미한 개발 아이디어는 다음과 같습니다.

1.  **"Transparent Memory" 아키텍처**: 임베딩 DB에만 의존하는 방식은 디버깅이 어렵습니다. Claude Code처럼 **버전 관리 가능한 파일(`MEMORY.md`)**에 기억을 노출하되, Codex처럼 **비동기 백그라운드 요약**을 통해 관리 부하를 줄이는 하이브리드 방식이 유리합니다.
2.  **"Deny-First" 권한 하니스**: 모델의 자율성이 높아질수록 보안 사고 위험이 큽니다. Claude Code의 7단계 권한 모드와 Lifecycle Hooks를 벤치마킹하여, 모든 위험 동작에 대해 **단계적 승인 및 사후 감사(Audit log)** 체계를 구축해야 합니다.
3.  **"Self-Improving" 스킬 저장소**: 에이전트가 단발성 작업으로 끝나는 것이 아니라, Hermes처럼 성공 사례를 **실행 가능한 표준 스킬(`agentskills.io`)**로 변환하여 로컬 저장소에 축적하게 함으로써 사용자와 함께 성장하는 경험을 제공해야 합니다.
4.  **"CI/CD Native" 에이전트**: 단순한 코딩 보조를 넘어, PR 생성 시 자동으로 테스트를 돌리고 버그를 수정해 제안하는 **Headless 워커**로서의 기능을 강화하여 개발 라이프사이클 전체에 통합되어야 합니다.

---

## 4. References

*   [1] *Dive into Claude Code: The Design Space of AI Agent Systems* (arXiv:2604.14228)
*   [2] *Codex CLI Custom Instructions & Policy Engine* (OpenAI Developers Guide)
*   [3] *Getting Started with Google Antigravity: Agent Manager & CI/CD Integration* (Google Codelabs)
*   [4] *Security and Sandboxing in Coding Agents: nsjail vs. execpolicy* (OS Security Review)
*   [5] *oh-my-openagent: Multi-model Routing for Token Optimization* (GitHub Docs)
*   [6] *Context engineering: memory, compaction, and tool clearing* (Claude Cookbook)
*   [7] *The Architecture of Lifecycle Hooks in Modern Agents* (Penligent.ai)
*   [8] *Codex CLI Memory: 2-Model Async Summarization* (Mem0 Technical Blog)
*   [9] *OpenClaw: 100+ Skills and Profile-based Distribution* (ClawDocs)
*   [10] *Hermes Agent: Session Handoff and Messaging Gateway* (hermes-agent.org)
*   [11] *Self-Improving AI: The Learning Loop in Hermes* (Analytics Vidhya)
*   [12] *Antigravity Review: Vision-based Debugging & GitHub Actions Integration* (Amplifi Labs)
*   [13] *Skill Marketplace and Open Standards for Agents* (agentskills.io)
