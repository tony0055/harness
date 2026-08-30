# harness

**재사용 가능한 Cursor 하네스 템플릿.** 새 프로젝트를 시작할 때마다 이 레포를 복사해서, 리서치 도구(MCP) · 작업 규칙(Rules) · 역할·콤보 · 에이전트 지침(AGENTS.md)이 이미 세팅된 상태로 시작한다. **Cursor-only + MVP 규모**에 맞춰 경량화했다.

## 철학 한 줄

> 반복되는 건 **규칙(Rules)** 으로 고정, 도구가 필요한 건 **MCP** 로 위임, 매번 다른 건 **사람** 이 판단. 작업 성격에 따라 **모델** 을 (비용을 아끼며) 바꿔 낀다.

작업은 항상 3개 레이어로 나눈다: **수집(Research) → 구현(Execute) → 판단(Decide)**.

## 무엇을 이식했나 (OmO / opencodex / paperthin 조사 결과)

| 소스 | 이식한 것 | 형태 |
| --- | --- | --- |
| **OmO** | 카테고리 모델 라우팅, 특화 에이전트, 자율 루프 | 비용 라우팅 규칙 + 4역할 + autonomous 규칙 |
| **paperthin** | anti-slop 저수준 설계 패턴 스킬 | 직접 설치(npx) + 조합 콤보/루프 |
| **opencodex** | (프록시 — Cursor-only엔 불필요) | 미이식 |

## 폴더 구조

```
.
├── .cursor/
│   ├── mcp.json                 # 리서치 도구 3종 (Exa · Context7 · grep)
│   ├── environment.json         # 클라우드 에이전트 환경
│   ├── context/ontology.md      # 영속 컨텍스트 SSOT (프로젝트 지식/결정)
│   ├── commands/
│   │   ├── context-clean.md     # /context-clean  콤보Ⅰ: 온톨로지 청소
│   │   └── next.md              # /next           콤보Ⅱ: 다음 수 + 모델 산정
│   ├── rules/
│   │   ├── harness-core.mdc     # [Always]          핵심 원칙 (레이어 분리, 규칙화 기준)
│   │   ├── research.mdc         # [Agent Requested] 리서치 도구 사용 순서
│   │   ├── roles.mdc            # [Agent Requested] 역할 4종 (Plan/Explore/Build/Review)
│   │   ├── model-routing.mdc    # [Agent Requested] 비용 인지형 모델 라우팅
│   │   └── autonomous.mdc       # [Agent Requested] 자율 실행 루프
│   └── skills/
│       ├── research/SKILL.md    # 수집 레이어 SOP
│       └── context-loop/SKILL.md# 영속 온톨로지 컨텍스트 루프 (paperthin 조합)
└── AGENTS.md                    # 에이전트 지침 (전체 요약)
```

## 리서치 도구 (MCP 3종)

| 도구 | 역할 | 키 필요? |
| --- | --- | --- |
| **Context7** | 라이브러리/프레임워크 공식 문서 | 무료로 시작, rate limit 시 키 |
| **grep** | 실제 GitHub 코드 사용 예시 검색 | 불필요 |
| **Exa** | 넓은 웹 리서치 | 무료로 시작, rate limit 시 키 |

`.cursor/mcp.json`은 **키 없이 바로 작동**한다. rate limit 시 `${env:EXA_API_KEY}` / `${env:CONTEXT7_API_KEY}` 형태로 키 추가(파일에 날것 금지).

## paperthin 설치 (외부 검증된 스킬)

anti-slop 저수준 설계 패턴. 바퀴 재발명 말고 그대로 설치:

```
npx skills@latest add LilMGenius/paperthin --agent cursor
```

이 하네스는 paperthin을 **조합**만 한다:
- **콤보 Ⅰ** `/context-clean` = `/ssotize` → `/re0` → `/debloat` → `/reorder` (온톨로지 청소)
- **콤보 Ⅱ** `/next` = `/nba` → `/modelchk` (다음 수 + 가장 싼 충분 모델)
- **영속 루프** `context-loop` 스킬 — 자율 상태에서도 `.cursor/context/ontology.md`가 썩지 않게 유지

## 모델 선택 (비용 인지형 — Cursor Pro $20)

- **fast** = 기본값 → Cursor 네이티브(Grok / Composer). 토큰이 넉넉하니 **대부분의 구현·스캐폴딩·MVP까지 여기서**.
- **standard** = Usage 70%+ 또는 요청 시 → 계속 Cursor 모델이지만 **아껴서**(추론강도 down).
- **frontier** = 승격으로만 → Claude/GPT, 고위험·정밀 디버깅·핵심 검수만. **절대 fast 아님.**
- 요청하면 언제든 티어 변경.

자세한 건 `AGENTS.md`, `.cursor/rules/model-routing.mdc` 참고.

## 사용법

### 1) 새 프로젝트에 적용
- GitHub에서 이 레포를 **Settings → Template repository** 로 지정 → **Use this template** 로 새 프로젝트 생성.
- 또는 `.cursor/` 폴더와 `AGENTS.md`만 복사.

### 2) 로컬 커서 세팅
1. 프로젝트를 Cursor로 열고 재시작 → **Settings → Cursor Settings → Tools & MCP** 에서 `exa`/`context7`/`grep` 초록불 확인.
2. paperthin 설치: `npx skills@latest add LilMGenius/paperthin --agent cursor`
3. (선택) `roles.mdc`의 4역할을 Custom Modes로 등록.

### 3) 규칙 늘려가기
같은 지시를 두 번 이상 하게 되면 `/Generate Cursor Rules` 로 패턴을 규칙으로 뽑아 `.cursor/rules/` 에 추가. 완벽히 미리 설계 말고 **반복될 때마다 굳힌다.**
