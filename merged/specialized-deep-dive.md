# 특수 목적 에이전트(Specialized Agents) 심층 분석

최종 리포트 취합을 위해 특수 목적 에이전트 3종에 대한 차별적 강점과 한계를 분석한 코멘트 및 확증된 1차 출처 정보를 공유합니다.

## 1. 에이전트별 심층 코멘트

### OpenClaw: 로컬 기반의 확장형 운영 에이전트
*   **강점**: 메시징 플랫폼(WhatsApp, Slack 등)과의 네이티브 통합과 `SKILL.md` 매니페스트 기반의 성숙한 확장 시스템이 특징입니다. 특히 `ClawHub`라는 독자적 레지스트리를 통해 커뮤니티 스킬을 손쉽게 배포 및 격리 실행(Docker)할 수 있어, 개인화된 자동화 작업에 최적화되어 있습니다.
*   **한계**: "Workspace-as-Memory" 방식을 채택하여 투명성은 높으나, Claude Code처럼 대화 맥락에서 자동으로 지식을 추론하고 기록하는 '동적 메모리 갱신' 역량은 상대적으로 부족합니다.

### oh-my-openagent (omo): 토큰 최적화 및 다중 모델 오케스트레이터
*   **강점**: "Tokenmaxxer"를 위한 하네스로서, `IntentGate`를 통한 카테고리별 모델 자동 라우팅(예: `ultrabrain`, `quick`) 기능이 독보적입니다. `Team Mode`를 통해 5개 이상의 서브에이전트가 병렬로 작업을 수행하며, LSP 및 AST-Grep을 내장하여 구문 분석 기반의 정밀한 리팩토링을 수행하는 능력이 탁월합니다.
*   **한계**: 다중 모델 및 병렬 실행 구조로 인해 설정의 복잡도가 높으며, 무인 자동화보다는 하네스의 제어 하에 있는 전문 개발팀 워크플로우에 집중되어 있습니다.

### Hermes Agent: 자가 학습 및 멀티 플랫폼 연속성 에이전트
*   **강점**: 에이전트의 성장에 초점을 맞춘 3계층 영구 메모리(Skills, Session, User Model) 구조가 가장 진보적입니다. 성공 사례를 `agentskills.io` 표준 스킬로 자동 승격시키는 폐루프 학습과, `/handoff` 명령을 통해 텔레그램에서 터미널로 세션을 중단 없이 이전하는 다채널 연속성이 압권입니다.
*   **한계**: 스킬을 로컬에 지속적으로 쓰기 때문에 '지속적 프롬프트 인젝션' 위험에 노출될 수 있으며, 3계층 메모리 관리와 임베딩 DB 연동을 위한 인프라 유지 비용이 발생합니다.

## 2. 1차 출처(Primary Sources) 승격 목록

*   **OpenClaw SKILL.md Spec**: [openclaw.ai/docs/skills-manifest](https://openclaw.ai/docs/skills-manifest)
*   **OpenClaw ClawHub Registry**: [clawhub.ai/explore](https://clawhub.ai/)
*   **oh-my-openagent Team Mode/Routing**: [github.com/code-yeongyu/oh-my-openagent/docs/guide/orchestration.md](https://github.com/code-yeongyu/oh-my-openagent/blob/dev/docs/guide/orchestration.md)
*   **Hermes 3-Tier Memory Architecture**: [hermes-agent.nousresearch.com/docs/memory](https://hermes-agent.nousresearch.com/docs/user-guide/features/overview)
*   **Hermes Session Handoff & Profile Dist**: [hermes-agent.nousresearch.com/docs/profiles](https://hermes-agent.nousresearch.com/docs/user-guide/features/overview)

## 3. 마스터 표 v0.4 팩트체크 완료
- 현재 합의된 OpenClaw 메모리(◐), Hermes 라우팅(◐), Hermes 샌드박싱(◐) 등급이 1차 출처의 명시적 기능 정의와 가장 부합함을 최종 확인했습니다.
