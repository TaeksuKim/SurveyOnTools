# 코딩 에이전트 심층 비교 분석 보고서 (v2.5)

> 작성 기준일: 2026-06-17
>
> **Caveat**: 특수 목적형 에이전트(OpenClaw, oh-my-openagent, Hermes Agent)의 경우 공식 문서가 제한적일 수 있어, 일부 기능 평가는 커뮤니티 리뷰 및 기술 블로그 기반의 추정을 포함하고 있습니다. 본 리포트는 타 에이전트(Claude)와의 상호 비판적 검증을 거쳐 모든 쟁점이 해소된 최종 통합 동기화 버전입니다.

## 1. 종합 비교 테이블

**범례: ● 1급(native·성숙) · ◐ 부분 지원(제한적·간접) · ○ 미지원/미확인**

### 1.1 핵심 설계 및 지능 (Core Architecture)
| 비교 항목 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Agentic Memory** | ● | ● | ● | ◐ | ◐ | ● |
| **자기개선 학습 루프** | ◐ | ◐ | ◐ | ○ | ○ | ● |
| **Context Strategy** | 5-Layer | Summary | Knowledge | Basic | Tokenmax | Tiered |
| **멀티/서브 에이전트** | ● | ◐ | ● | ● | ● | ● |
| **멀티모델 라우팅** | ◐ | ◐ | ◐ | ● | ● | ◐ |
| **코드 인텔리전스** | ◐ | ◐ | ● | ◐ | ● | ◐ |

### 1.2 하네스 및 운영 (Harness & Ops)
| 비교 항목 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Lifecycle Hooks** | ● | ◐ | ◐ | ◐ | ● | ◐ |
| **다단계 권한(Permissions)**| ● | ● | ◐ | ◐ | ◐ | ◐ |
| **샌드박싱(Sandboxing)** | ● | ● | ● | ◐ | ◐ | ◐ |
| **체크포인트/롤백** | ● | ◐ | ● | ○ | ○ | ○ |
| **Git/Worktree 격리** | ● | ◐ | ◐ | ◐ | ◐ | ◐ |
| **Headless/CI-Native** | ● | ● | ◐ | ◐ | ◐ | ◐ |
| **작업 스케줄링(cron)** | ◐ | ◐ | ● | ● | ○ | ● |

### 1.3 사용자 경험 및 확장성 (UX & Ecosystem)
| 비교 항목 | Claude Code | Codex CLI | Antigravity | OpenClaw | oh-my-openagent | Hermes Agent |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Adaptive/개인화** | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| **멀티모달**(vision·음성) | ◐ | ◐ | ● | ◐ | ○ | ● |
| **도구 연결성(MCP)** | ● | ● | ● | ● | ◐ | ● |
| **Skills/확장** | ● | ◐ | ◐ | ● | ● | ● |
| **멀티 서피스/채널** | ◐ | ◐ | ◐ | ◐ | ○ | ● |
| **세션 핸드오프** | ○ | ○ | ◐ | ◐ | ○ | ● |
| **프로필/설정 배포** | ◐ | ○ | ◐ | ● | ○ | ● |
| **팀/공유 메모리** | ◐ | ○ | ◐ | ◐ | ○ | ◐ |

---

## 2. 상호 검증을 통한 핵심 인사이트

### 2.1. 인프라의 완성도: Harness & Sandboxing
*   **Antigravity CLI (`agy`)**: 초기 검토 시 Gemini CLI와의 혼동 가능성이 제기되었으나, 재조사 결과 `nsjail`(Linux) 및 `sandbox-exec`(macOS)를 통한 **Terminal Sandboxing**을 네이티브하게 제공함이 확증되었습니다. 설정 파일은 호환성을 위해 계승되었으나 Go 기반의 고도화된 하네스에서 1급(●) 보안 기능을 구현했습니다 [Ref 3][Ref A].
*   **Codex CLI**: Python의 안전한 서브셋인 **Starlark** 기반의 정책 엔진(`execpolicy`)을 사용하여 결정론적인 권한 제어 시스템을 구축했습니다. [Ref 2][Ref 4].

### 2.2. 지속 가능성과 세션 관리: Memory & Checkpoint
*   **Claude Code**: 외과적인 **`/rewind`** 명령과 5단계 압축 파이프라인을 통해 장기 실행 세션의 안정성을 확보한 독보적인 사례입니다 [Ref 1][Ref 14].
*   **Hermes Agent**: `/handoff` 명령을 통한 **채널 간(텔레그램↔터미널) 세션 연속성**과 개인정보를 제외한 설정을 팀에 공유하는 `Profile Distributions` 기능이 강점입니다 [Ref 10].

### 2.3. 오케스트레이션과 분석: Multi-Agent & Code Analysis
*   **Antigravity**: `Mission Control` 체제 하에 Manager, Writer, Critic, Tester 역할을 분담하여 병렬 처리를 극대화했습니다 [Ref 3][Ref 12].
*   **oh-my-openagent**: LSP 및 AST-Grep을 내장하여 단순 텍스트 편집이 아닌 구문 분석 기반의 정밀 명령어 매칭과 리팩토링을 제공합니다 [Ref 5].

---

## 3. 향후 유사 도구 개발을 위한 전략적 제언 (최종)

1.  **투명한 계층형 메모리 관리**: Claude Code의 평문 파일 메모리와 Codex의 비동기 요약/병합 관리를 결합하여 가독성과 효율성을 동시에 잡는 아키텍처가 필요합니다.
2.  **자기개선 폐루프의 표준화**: Hermes처럼 성공 사례를 `agentskills.io` 표준 스킬로 자동 승격시켜 개인의 학습이 팀의 자산으로 정착되는 시스템을 구축해야 합니다.
3.  **Harness-Native 보안 및 격리**: 샌드박싱과 다단계 권한 제어는 옵션이 아닌 기본 인프라여야 하며, 작업별 격리를 위한 Git/Worktree 활용 능력이 필수적입니다.
4.  **다채널 핸드오프와 협업**: CLI를 넘어 메신저 등 다양한 서피스를 지원하되, 세션의 맥락을 끊김 없이 유지하는 핸드오프 기능이 실무 생산성을 좌우할 것입니다.

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
*   [Ref A] *Terminal Sandboxing in Antigravity* - https://antigravity.google/docs/ide-settings
