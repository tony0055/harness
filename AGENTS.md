# AGENTS.md — 하네스 에이전트 지침

재사용 가능한 Cursor 하네스 템플릿. Cursor-only + MVP 규모에 맞춰 경량화. 셋업·상세 사용법은 `README.md`.

## 항상 지키는 원칙

- **레이어로 나눈다**: 수집(Explore) → 구현(Plan·Build·Review) → 판단(사람). 판단(주제·방향·가치)은 규칙화·자율 실행하지 않고 사람에게. (`harness-core`)
- **비용 우선**: 기본은 Cursor 네이티브(Composer/Auto/Grok). 프런티어(Claude/GPT)는 고위험·핵심 검수에만 승격, 예산 달리면 전부 Cursor 모델로 강등. (`model-routing`)
- **근거 우선**: 도구로 확인 가능한 사실을 기억에 의존해 단정하지 않고, 출처를 붙인다. (`research`)

## 포인터 맵

| 필요할 때 | 본다 |
| --- | --- |
| 사고 프레임 | `rules/harness-core.mdc` (Always) |
| 리서치(도구 순서·출력 형식) | `rules/research.mdc`, `skills/research` |
| 역할별 작업 (Plan/Explore/Build/Review) | `rules/roles.mdc` |
| 모델·비용 선택 | `rules/model-routing.mdc` |
| 긴 자율 작업 | `rules/autonomous.mdc` |
| 영속 컨텍스트 유지 | `skills/context-loop`, `/context-clean`, `/next` |
| 리서치 MCP 도구 | `.cursor/mcp.json` (exa · context7 · grep) |

## paperthin

콤보(`/context-clean`, `/next`)가 쓰는 스킬은 외부 설치가 필요하다: `npx skills@latest add LilMGenius/paperthin --agent cursor` (상세는 README).

## 규칙 늘리는 법

같은 지시를 두 번 이상 하게 되면 `/Generate Cursor Rules`로 패턴을 `.mdc`로 뽑아 `.cursor/rules/`에 추가한다. 규칙은 **"트리거 → 동작 → 출력 형식"** 으로 쓴다. 종류: 매번 똑같음=Always(`alwaysApply:true`), 특정 파일=`globs`, 상황 따라=Agent Requested(`description`), 가치판단=규칙화 안 함.

## 하지 말 것

- 도구로 확인 가능한 사실(API·버전 등)을 기억에만 의존해 단정.
- 주제·방향·가치판단을 대신 결정 (근거만 제시하고 사람에게).
- API 키·토큰을 파일/로그/커밋에 노출.
- `main`에서 임의 브랜치 이동·force push.
