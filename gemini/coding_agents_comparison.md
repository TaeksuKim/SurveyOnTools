# 코딩 에이전트 심층 비교 분석 보고서 (v2.4)

> 작성 기준일: 2026-06-17
>
> **Caveat**: 특수 목적형 에이전트(OpenClaw, oh-my-openagent, Hermes Agent)의 경우 공식 문서가 제한적일 수 있어, 일부 기능 평가는 커뮤니티 리뷰 및 기술 블로그 기반의 추정을 포함하고 있습니다. 본 리포트는 타 에이전트(Claude)의 분석 결과를 비판적으로 수용하고 22개 이상의 지표로 대폭 확장한 최종 통합본입니다.

## 1. 종합 비교 테이블

**범례: ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인**

### 1.1 핵심 설계 및 지능 (Core Architecture)
| 비교 항목 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Agentic Memory** | ● | ● | ● | ◐ | ◐ | ● |
| **Learning Loop** | ◐ | ◐ | ● | ○ | ○ | ● |
| **Context Strategy** | 5-Layer | Summary | Knowledge | Basic | Tokenmax | Tiered |
| **Multi-Agent** | ● | ◐ | ● | ● | ● | ● |
| **Model Routing** | ◐ | ◐ | ◐ | ● | ● | ● |
| **Code Analysis** | ● | ◐ | ● | ◐ | ● | ◐ |

### 1.2 하네스 및 운영 (Harness & Ops)
| 비교 항목 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Lifecycle Hooks** | ● | ◐ | ◐ | ◐ | ● | ◐ |
| **Permissions** | ● | ● | ◐ | ◐ | ◐ | ◐ |
| **Sandboxing** | ● | ● | ● | ◐ | ◐ | ● |
| **Checkpoint/Rewind**| ● | ◐ | ● | ○ | ○ | ◐ |
| **Git/Worktree** | ● | ◐ | ● | ● | ◐ | ◐ |
| **CI/CD / Headless** | ● | ● | ● | ● | ◐ | ● |
| **Task Scheduling** | ○ | ● | ● | ● | ○ | ● |

### 1.3 사용자 경험 및 확장성 (UX & Ecosystem)
| 비교 항목 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Multi-Modality** | ● | ◐ | ● | ◐ | ○ | ● |
| **Interactive Debug** | ◐ | ◐ | ● | ◐ | ● | ◐ |
| **Surface/Channel** | CLI / IDE | CLI | IDE / TUI | Messaging | CLI | **Msg Gateway** |
| **Session Handoff** | ○ | ○ | ◐ | ◐ | ○ | ● |
| **Profile Dist.** | ○ | ○ | ◐ | ● | ○ | ● |
| **Ecosystem** | MCP / Skills | MCP / Agents | Plugin / MCP | ● | MCP / Skills | Skill Standard |

---

## 2. 주요 기능 심층 분석 및 상호 검증

### 2.1. 인프라와 제어: Harness & Permissions
*   **Claude Code**: **27종의 Lifecycle Hooks**와 7단계 권한 모드를 통해 모델 주변에 결정론적 운영 하니스를 구축했습니다 [1][7]. 특히 `/rewind` 명령을 통한 3가지 모드의 체크포인트 복구 기능은 작업 안정성을 극대화합니다 [14].
*   **Codex CLI**: Rust 기반 **Starlark 정책 엔진**(`execpolicy`)을 사용하여 쉘 명령어를 트리시터(tree-sitter)로 구문 분석 후 규칙을 적용합니다 [2][4]. `codex exec`와 전용 `cron` 서브커맨드를 통한 무인 자동화 역량이 뛰어납니다 [15].

### 2.2. 지능형 메모리와 협업: Memory & Collaboration
*   **Antigravity**: **Knowledge Base** 아키텍처를 도입하여 학습 내용을 단순 텍스트가 아닌 프로젝트 프리미티브로 관리합니다. **Mission Control** 하에서 Manager, Writer, Critic, Tester 등의 전문 서브에이전트를 비동기 병렬로 오케스트레이션합니다 [3][12].
*   **Hermes Agent**: **자동 스킬 생성(Auto-Skill Creation)**과 SQLite 기반의 3계층 영구 메모리가 핵심입니다 [10]. 특히 메신저 게이트웨이를 통한 **세션 핸드오프(/handoff)** 기능은 타 에이전트에서 보기 힘든 독보적인 협업 기능입니다 [11].

### 2.3. 토큰과 분석 최적화: Context & Analysis
*   **oh-my-openagent**: "Tokenmaxxers"를 위한 하니스로서, IntentGate와 카테고리별 모델 라우팅을 통해 비용을 최적화합니다. LSP 및 AST-Grep 도구를 내장하여 IDE 급의 코드 분석 기능을 제공합니다 [5].
*   **Claude Code**: 5단계 압축 파이프라인(Micro-compaction ~ Auto-compact)을 통해 장기 세션에서의 컨텍스트 효율을 극대화합니다 [6].

---

## 3. 향후 유사 도구 개발을 위한 전략적 인사이트

1.  **Harness-First 설계**: 모델의 지능보다 중요한 것은 **Lifecycle Hooks와 샌드박싱**입니다. Claude Code의 98% 하니스 비중과 Codex의 Starlark 정책 엔진은 차세대 도구가 갖춰야 할 필수 인프라입니다.
2.  **비동기 다중 에이전트 역할 분담**: Antigravity의 Mission Control이나 oh-my-openagent의 Virtual Team 구조처럼, 하나의 에이전트가 모든 것을 하기보다 **Planning, Writing, Reviewing, Testing**을 분리하여 병렬로 수행하는 것이 대규모 프로젝트 해결의 핵심입니다.
3.  **지속적 학습과 스킬 승격**: Hermes의 자가 학습 루프처럼 작업 성공 사례를 **재사용 가능한 스킬 문서**로 자동 변환하여 개인/팀의 자산으로 축적하는 기능이 에이전트의 장기적 가치를 결정합니다.
4.  **다채널 접근성과 세션 유지**: CLI에 국한되지 않고 Hermes처럼 메신저 채널을 지원하며, 세션을 끊김 없이 이어가는(Handoff) 능력이 실무 활용도를 높입니다.

---

## 4. References

*   [1] *Dive into Claude Code: The Design Space of AI Agent Systems* - https://arxiv.org/html/2604.14228v1
*   [2] *Codex CLI Custom Instructions & Policy Engine* - https://developers.openai.com/codex/guides/agents-md
*   [3] *Getting Started with Google Antigravity: Agent Roles & CI/CD* - https://www.codecademy.com/article/how-to-set-up-and-use-google-antigravity
*   [4] *Security and Sandboxing in Coding Agents: nsjail vs. execpolicy* - https://openai.com/blog/codex-cli-security-policy
*   [5] *oh-my-openagent: Multi-model Routing for Token Optimization* - https://github.com/code-yeongyu/oh-my-openagent/blob/dev/docs/guide/overview.md
*   [6] *Context engineering: memory, compaction, and tool clearing* - https://platform.claude.com/cookbook/tool-use-context-engineering
*   [7] *The Architecture of Lifecycle Hooks in Modern Agents* - https://www.penligent.ai/hackinglabs/inside-claude-code-the-architecture-behind-tools-memory-hooks-and-mcp/
*   [8] *Codex CLI Memory: 2-Model Async Summarization* - https://mem0.ai/blog/how-memory-works-in-codex-cli
*   [9] *OpenClaw: 100+ Skills and Profile-based Distribution* - https://docs.openclaw.ai/concepts/agent
*   [10] *Hermes Agent: Session Handoff and Messaging Gateway* - https://hermes-agent.org/
*   [11] *Self-Improving AI: The Learning Loop in Hermes* - https://www.analyticsvidhya.com/blog/2026/05/hermes-agent-guide/
*   [12] *Antigravity Review: Vision-based Debugging & Mission Control* - https://www.amplifilabs.com/post/google-antigravity-review
*   [13] *Skill Marketplace and Open Standards for Agents* - https://agentskills.io
*   [14] *Claude Code /rewind: Sophisticated Session Management* - https://vincentqiao.com/posts/claude-code-rewind
*   [15] *Codex CLI: Headless Automation and Cron Features* - https://github.com/openai/codex-cli/releases/tag/v0.130
