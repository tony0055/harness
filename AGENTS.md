# AGENTS.md — 하네스 에이전트 지침

이 레포는 **재사용 가능한 Cursor 하네스 템플릿**이다. 새 프로젝트를 시작할 때 이 레포를 복사(또는 `.cursor/` + `AGENTS.md`만 복사)해서 쓴다. 에이전트는 아래 지침을 따른다.

## 핵심 철학: 레이어를 나눠서 일한다

모든 작업을 3개 레이어로 분리해서 처리한다. (자세한 건 `.cursor/rules/harness-core.mdc`)

1. **수집(Research)** → MCP 도구에 위임 (Exa / Context7 / grep)
2. **구현(Execute)** → 규칙 + 코드 실행
3. **판단(Decide)** → 사람이 결정. 규칙화하지 않는다.

## 리서치 도구 (MCP)

`.cursor/mcp.json`에 3종이 등록돼 있다.

- **Context7** — 라이브러리/프레임워크 공식 문서·정확한 API
- **grep** — 실제 GitHub 코드에서 사용 예시 검색
- **Exa** — 넓은 웹 리서치

사용 순서와 출력 형식은 `.cursor/rules/research.mdc` / `.cursor/skills/research/SKILL.md` 참고.

> 참고: `.cursor/mcp.json`은 키 없이 바로 작동한다. rate limit이 걸리면 API 키를 추가한다. 키는 절대 파일에 날것으로 박지 말고 `${env:EXA_API_KEY}`, `${env:CONTEXT7_API_KEY}` 형태로 넣고 셸 환경변수로 관리한다.

## 모델 선택 (비용 인지형 — Cursor Pro $20 예산)

전제: **Cursor Pro = 월 $20 포함.** GPT/Claude(프런티어)는 이 예산을 빠르게 태운다. (자세한 규칙: `.cursor/rules/model-routing.mdc`)

- **fast**(사소·반복) → Composer / Auto (포함)
- **standard**(대부분 구현·MVP) → **Grok** (저비용)
- **frontier**(고위험 로직·정밀 디버깅·핵심 검수) → Claude/GPT **아껴서, 계획·검수 짧은 구간만**
- **예산 가드**: 프런티어는 "승격"으로만. **예산/토큰 달리면 전부 Cursor 네이티브(Composer/Auto/Grok)로 강등.** 의심되면 싸게 시작.

## 역할 4종 (Plan / Explore / Build / Review)

OmO의 특화 에이전트를 MVP용 4역할로 압축했다. 각 역할이 쓰는 paperthin 스킬·모델 티어는 `.cursor/rules/roles.mdc` 참조. Cursor Custom Modes로 승격 권장.

- **Plan**: `/readchk` `/hate` `/feynman` `/modelchk` (계획·검수)
- **Explore**: 리서치 MCP + explore 서브에이전트 + `/factchk` `/catchup` (탐색)
- **Build**: `/aim` `/autobahn` `/sip` (구현)
- **Review**: `/shower` `/re0` `/debloat` `/ssotize` `/sip` (검수·정리)

## paperthin (외부 검증된 스킬 — 직접 설치)

anti-slop 저수준 설계 패턴 스킬 모음. 바퀴를 재발명하지 말고 그대로 설치해서 쓴다:

```
npx skills@latest add LilMGenius/paperthin --agent cursor
```

이 하네스는 paperthin을 **조합**하는 계층만 직접 만든다:

- **영속 온톨로지 컨텍스트 루프** → `.cursor/skills/context-loop/SKILL.md` (`.cursor/context/ontology.md`가 SSOT)
- **콤보 Ⅰ (컨텍스트 청소)** → `/context-clean` = `/ssotize` → `/re0` → `/debloat` → `/reorder`
- **콤보 Ⅱ (다음 수 결정)** → `/next` = `/nba` → `/modelchk`

## 자율 실행

긴 자율 작업은 `.cursor/rules/autonomous.mdc`의 루프를 따른다: 다음 수(`/next`) → 예산 가드 → 구현 → `/sip` 자가검증 → 큰 단계마다 `/context-clean`. 목표 달성 & `/sip` 통과 & 온톨로지 최신일 때 멈춘다.

## 판단 레이어는 자율로 넘기지 않기

주제 선정·방향 결정·가치판단은 규칙화하지도, 자율 루프로 밀지도 않는다. 근거만 제시하고 사람에게 넘긴다. 고위험 로직(인증·결제·보안)은 Plan 역할에서 frontier로 검수 후 진행.

## 규칙을 늘리는 법

같은 지시를 두 번 이상 하게 되면 `/Generate Cursor Rules`로 패턴을 `.mdc`로 뽑아 `.cursor/rules/`에 추가한다. 이때 규칙 종류를 정한다:

- 매번 똑같음 → `alwaysApply: true` (Always)
- 특정 파일에서만 → `globs` 지정 (Auto Attached)
- 상황 따라 필요 → `description` 채우고 `alwaysApply: false` (Agent Requested)
- 가치판단·매번 다름 → **규칙화하지 않음**

## 하지 말 것

- 도구로 확인 가능한 사실(API·버전 등)을 기억에만 의존해 단정하지 않는다.
- 주제 선정·방향 결정 등 가치판단을 대신 내리지 않는다. 근거만 제시하고 사람에게 넘긴다.
- API 키·토큰을 파일/로그/커밋에 노출하지 않는다.
- `main`에서 임의로 브랜치를 옮기거나 force push하지 않는다.

## 이 템플릿을 새 프로젝트에 적용하는 법

1. GitHub에서 이 레포를 **Template repository**로 지정 → 새 프로젝트는 **Use this template**로 생성.
2. (또는) `.cursor/` 폴더와 `AGENTS.md`만 새 프로젝트에 복사.
3. 프로젝트에 맞게 `.cursor/environment.json`의 `install` 명령만 교체.
4. 프로젝트 도메인 규칙을 `.cursor/rules/`에 추가해 나간다.
