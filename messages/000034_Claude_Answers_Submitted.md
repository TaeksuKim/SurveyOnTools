Writer: Claude
When: 2026-06-17 19:10 (KST)

# 사용자 질문(000031)에 대한 Claude 답변 완료

사용자님께서 `000031_User_Question.md`에 남기신 10개 질문에 대한 답변을 지시대로
제 폴더에 작성했습니다.

- **답변 파일:** `claude/answer_master_comparison.md`

## 작성 방식
- Gemini(`gemini/answer_master_comparison.md`)·Antigravity(`antigravity/answer_master_comparison.md`)
  두 답변을 **비판적으로 참고**하고, Claude 고유 관점을 더했습니다.
- AGENTS.md §6에 따라 **개념 설명**(권한·샌드박싱·rewind·라우팅)과 **제품별 구현 주장**
  (출처 제한)을 구분하고, 추정 부분에 caveat를 명시했습니다.

## 핵심 결론
1. **Cline 과대평가 3건 하향에 3사 만장일치 동의** — Agentic Memory ●→◐,
   Context Compaction ●→◐, Adaptive/개인화 ●→◐. 모두 "문서 claim ≠ 실사용 reality"
   사례로, 사용자님 체감·코드분석이 정확합니다.
2. **반대 방향 보정 1건 추가 제안** — Cline 멀티/서브 에이전트는 오히려 **과소평가**일 수
   있어 **○→◐**(기본 앱은 단일, **SDK로 멀티에이전트 구성 가능**) 권고. 사용자님이
   지적하신 "Cline SDK 멀티에이전트 특징"을 반영한 항목입니다.
3. **개념 질의 정리** — 다단계 권한(위험도별 모드+규칙), Git/Worktree(코드 보호) vs
   샌드박싱(시스템 보호), rewind(파일+대화 복원) vs Cline checkpoint(파일만),
   멀티모델 라우팅(자동 모델 전환), 멀티서피스/채널, 개인화 vs 자기개선 학습루프 구분.

## 미세 보정 (타 답변 대비)
- Gemini의 "Cline은 Git 없으면 checkpoint 작동 불가" 단정은, Cline 자체 스냅샷 경로를
  고려해 **"Git 연동 시 견고"로 순화** 권장.

## 다음
- 위 v0.6 등급 수정안(Cline 메모리/압축/개인화 ◐ 하향 + 멀티에이전트 ◐ 상향)을
  사용자님이 승인하시면, 제가 `merged/master-comparison.md`에 반영하고 §6 변경이력에
  근거와 함께 기록하겠습니다.
- 자율 루프는 사용자 지시 기준 수동 1회 진행 원칙을 유지합니다.
