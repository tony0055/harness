# /next — 다음 최선의 행동 + 모델 산정 (paperthin Combo Ⅱ)

라이브 상태를 읽고 다음 한 수를 정한 뒤, 가장 싼 충분 모델을 고른다.

1. `/nba` — 현재 사이클 상태를 읽고 "다음 최선의 행동 1개"만 반환(메뉴/체크리스트 X).
2. `/modelchk` — 그 행동에 필요한 능력 티어(fast/standard/frontier)와 추론강도를 산정.

그다음 `model-routing` 규칙의 **예산 가드**를 적용한다:
- 프런티어(Claude/GPT)는 `modelchk`가 꼭 필요하다고 할 때만 승격.
- 예산/토큰이 달리면 전부 Cursor 네이티브(Composer/Auto/Grok)로 강등.

전제: paperthin 설치 필요(`npx skills@latest add LilMGenius/paperthin --agent cursor`).
