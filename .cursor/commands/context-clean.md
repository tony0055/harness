# /context-clean — 온톨로지 컨텍스트 청소 (paperthin Combo Ⅰ)

`.cursor/context/ontology.md`(및 지정한 산출물)를 다음 paperthin 파이프라인으로 청소한다. 각 단계는 순서대로, 파괴적 변경은 승인 후에.

1. `/ssotize` — 흩어진 사실을 온톨로지 한 곳으로 통합하고 나머진 참조로 교체.
2. `/re0` — 드리프트된 문서를 패치 말고 clean v0로 재작성.
3. `/debloat` — 패딩·중복·나열을 load-bearing density로 압축(의미 보존).
4. `/reorder` — 하나의 명시된 원칙으로 항목만 재정렬(내용 변경 없음).

전제: paperthin 설치 필요(`npx skills@latest add LilMGenius/paperthin --agent cursor`).
대상 파일이 지정되지 않으면 `.cursor/context/ontology.md`를 기본 대상으로 한다.
