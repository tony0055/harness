---
name: context-loop
description: 자율 상태에서도 프로젝트의 "온톨로지(영속 컨텍스트)"가 썩지 않게 유지하는 루프. paperthin 스킬을 조합한 2개 콤보로 컨텍스트를 청소하고 다음 행동/모델을 정한다. 긴 자율 작업, 세션 복귀, 컨텍스트 압축 후 사용.
---

# Context Loop — 영속 온톨로지 컨텍스트 관리 (paperthin 조합)

paperthin 개발자 권장: **paperthin을 조합해 "영속화된 온톨로지 컨텍스트 관리"를 자율 상태에서도 가능한 루프 파이프라인으로 구성한다.**

전제: paperthin이 설치돼 있어야 한다 → `npx skills@latest add LilMGenius/paperthin --agent cursor`

## 온톨로지 파일 (단일 진실 원천)

프로젝트의 살아있는 지식/어휘/결정을 **`.cursor/context/ontology.md` 한 곳**에 모은다. 이게 세션·압축·자율 실행을 가로질러 살아남는 SSOT다. 대화 기억이 아니라 이 파일이 진실이다.

## 콤보 Ⅰ — 컨텍스트 청소 (hygiene)
`/ssotize` → `/re0` → `/debloat` → `/reorder`

1. `/ssotize` — 여기저기 흩어진 사실을 온톨로지 파일 한 곳으로 통합, 나머진 이걸 가리키게.
2. `/re0` — 드리프트로 지저분해진 온톨로지를 패치 말고 clean v0로 재작성.
3. `/debloat` — 패딩·중복·나열 벽을 load-bearing density로 압축(의미 보존).
4. `/reorder` — 항목을 하나의 원칙으로 논리적 재정렬(내용 변경 없이 순서만).

**언제**: 긴 작업 중 주기적으로(예: 큰 단계 완료 시), 컨텍스트 압축 직후, 온톨로지가 지저분해졌다고 느낄 때.

## 콤보 Ⅱ — 다음 수 결정 (decide)
`/nba` → `/modelchk`

1. `/nba` — 라이브 상태를 읽고 "다음 최선의 행동 1개"만 반환(메뉴 X).
2. `/modelchk` — 그 행동에 가장 싼 충분 티어(fast/standard/frontier)+추론강도 산정.

**언제**: 단계 사이, 무엇을 할지 고를 때. 결과는 `model-routing`의 예산 가드를 따른다(프런티어는 승격으로만, 예산 달리면 Cursor 모델로 강등).

## 자율 루프 통합
긴 자율 작업(`autonomous` 규칙)에서:
```
반복:
  Build(구현) → /sip(자가검증)
  큰 단계 끝나면 → 콤보 Ⅰ(온톨로지 청소)
  다음 정할 때 → 콤보 Ⅱ(행동+모델) → model-routing 예산 가드 적용
  세션 복귀/맥락 상실 시 → /catchup 먼저
멈춤 조건: 목표 달성 & /sip 통과 & 온톨로지 최신.
```

핵심: **코드가 아니라 "학습/컨텍스트"가 누적되게 한다**(paperthin `re0-loop` 철학). 잘못된 빌드는 버리고, 온톨로지에 남은 교훈만 이어간다.
