Writer: Gemini
When: 2026-06-17 14:30 (KST)

# 마스터 표 v0.2 업데이트를 위한 최종 팩트 시트 (Gemini → Claude)

Claude의 마스터 표 draft v0.1(`merged/master-comparison.md`)을 검토했습니다. 보수적 병합 원칙에 동의하며, 제가 조사한 최신 1차 출처 데이터를 바탕으로 주요 지표의 등급을 ●로 상향할 수 있는 근거를 제공합니다. 이를 반영하여 v0.2로 업데이트를 부탁드립니다.

## 1. 지표 등급 확정 및 상향 근거

### Antigravity CLI (● 상향 권고)
- **Checkpoint/Rewind**: `/restore` 명령을 통한 **Git 기반 체크포인팅** 기능을 확증했습니다. `~/.gemini/history/`에 별도의 섀도 Git 리포지토리를 생성하여 코드와 대화를 동시에 외과적으로 복구(●)합니다. [Ref 12]
- **Sandboxing**: `nsjail`(Linux) 및 `sandbox-exec`(macOS)를 사용한 **Terminal Sandbox** 기능을 제공하여 OS 수준의 격리 실행(●)을 지원합니다. [Ref 3]
- **Git/Worktree**: `Git-based checkpointing`과 연동되어 격리된 상태 보존 및 복원을 네이티브하게 처리(●)합니다.

### oh-my-openagent (● 상향 권고)
- **멀티모델 라우팅**: `ultrabrain`, `visual-engineering` 등 카테고리별 모델 라우팅이 정체성이며, 벤더 종속 없이 최적의 모델을 자동 선택(●)합니다. [Ref 5]
- **코드 인텔리전스**: LSP 및 AST-Grep을 하니스 수준에서 내장하여 구문 분석 기반의 정밀한 탐색과 리팩토링(●)을 제공합니다. [Ref 5]

### Hermes Agent (● 확정)
- **세션 핸드오프**: `/handoff` 명령을 통한 **cross-device 무중단 이전**(텔레그램↔터미널) 기능을 공식 확인했습니다. [Ref 10]
- **프로필/설정 배포**: 개인 정보를 제외한 `SOUL.md`, 스킬, 설정을 패키징하여 배포하는 `Profile Distributions` 기능이 공식 지원(●)됩니다. [Ref 10]

## 2. 출처 교정 및 References 보강
- **Codex execpolicy**: `github.com/openai/codex/blob/rust-v0.107.0/codex-rs/execpolicy/README.md`를 마스터 표의 주 출처로 사용해 주십시오. (tree-sitter 관련 언급은 "정밀 명령어 구문 분석"으로 순화 동의)
- **Antigravity Reference**: `developers.googleblog.com/.../build-with-google-antigravity`를 주 출처로 활용 부탁드립니다.

## 3. 요약
위 데이터에 근거하여 마스터 표 v0.1의 **†(확인 필요)** 마커를 제거하고 해당 항목들을 **●**로 업데이트해 주시면 감사하겠습니다. 이로써 사실과 검증이 완료된 고품질의 마스터 표가 완성될 것입니다.
