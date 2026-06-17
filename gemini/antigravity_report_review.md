# Antigravity 참여 리포트 검토 결과

**작성자:** Gemini  
**작성일:** 2026-06-17  
**대상 문서:** `antigravity/coding-agents-feature-comparison.md`

## 1. 주요 발견 및 평가

Antigravity 에이전트가 제출한 리포트는 기존 v0.4 마스터 표를 대폭 고도화할 수 있는 고품질의 정보를 담고 있습니다. 특히 다음 사항들이 인상적입니다:
- **Cline 추가:** 기존 6종 범위를 넘어 Cline을 포함함으로써 모델 비종속성(Model-agnostic) 도구와의 비교가 가능해졌습니다.
- **세분화된 분류:** 10가지 기능 영역으로 구분하여 'Harness Engineering'이나 'Deployment Environment' 등 운영 관점의 지표를 보강했습니다.
- **구체적 References:** 각 도구별 45개의 인용을 통해 데이터의 신뢰성을 확보했습니다.

## 2. 데이터 상충(Conflict) 및 정합성 검토

### A. Antigravity 자체 기능 평가 (Sandboxing & Checkpoint)
- **상충 내용:** Antigravity 에이전트는 본인의 Sandboxing과 Checkpoint 기능을 **◐(부분 지원)**으로 평가했으나, 기존 v0.4 마스터 표 및 외부 검색 결과(`agy` CLI 기준)는 **●(1급 지원)**으로 평가하고 있습니다.
- **원인 추정:** 해당 기능들이 CLI 환경에 집중되어 있거나, 기본 설정이 '비활성(opt-in)' 상태이기 때문에 에이전트가 보수적으로 판단한 것으로 보입니다.
- **조치 제안:** 마스터 표에는 **●**를 유지하되, "CLI 중심 및 명시적 활성화 필요"라는 주석을 추가하여 정확도를 높이겠습니다.

### B. 비교 대상 범위 (Cline)
- **상충 내용:** `AGENTS.md`의 '고정 6종' 원칙과 상충됩니다.
- **조치 제안:** Cline은 현재 에이전트 생태계에서 매우 중요한 위치를 차지하고 있으며, Antigravity가 완벽한 비교 데이터를 제공했으므로 **마스터 표의 비교 대상을 7종으로 확장**할 것을 제안합니다.

## 3. 마스터 표(v0.5) 반영 계획

다음 내용을 `merged/master-comparison.md` v0.5에 반영할 예정입니다:
1. **비교 대상 확장:** Cline 열 추가.
2. **지표 통합:** Antigravity의 10대 분류를 기존 3분할(Core/Harness/UX) 체계에 녹여내어 지표를 정밀화.
3. **아이디어 병합:** Antigravity가 제안한 7가지 아이디어를 §5에 통합.
   - 특히 '연합 에이전트 프로토콜'과 '프로그레시브 신뢰 모델'은 매우 혁신적인 제안으로 평가됨.
4. **References 동기화:** Antigravity가 제공한 45개의 최신 Reference를 통합 Reference 섹션에 추가.

## 4. 사용자/Claude 확인 사항
- 비교 대상을 7종(Cline 포함)으로 공식 확장하는 것에 동의하시나요?
- Antigravity의 보수적 자기 평가(◐) 대신 검색 결과(●)를 우선하는 것에 동의하시나요?
