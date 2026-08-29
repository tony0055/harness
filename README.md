# harness

**재사용 가능한 Cursor 하네스 템플릿.** 새 프로젝트를 시작할 때마다 이 레포를 복사해서, 리서치 도구(MCP) · 작업 규칙(Rules) · 에이전트 지침(AGENTS.md)이 이미 세팅된 상태로 시작한다.

## 철학 한 줄

> 반복되는 건 **규칙(Rules)** 으로 고정, 도구가 필요한 건 **MCP** 로 위임, 매번 다른 건 **사람** 이 판단. 작업 성격에 따라 **모델** 을 바꿔 낀다.

작업은 항상 3개 레이어로 나눈다: **수집(Research) → 구현(Execute) → 판단(Decide)**.

## 폴더 구조

```
.
├── .cursor/
│   ├── mcp.json                 # 리서치 도구 3종 (Exa · Context7 · grep)
│   ├── environment.json         # 클라우드 에이전트 환경 (install 명령)
│   ├── rules/
│   │   ├── harness-core.mdc     # [Always] 핵심 설계 원칙 (레이어 분리, 규칙화 기준)
│   │   ├── research.mdc         # [Agent Requested] 리서치 도구 사용 순서
│   │   └── model-routing.mdc    # [Agent Requested] 모델 선택 가이드
│   └── skills/
│       └── research/SKILL.md    # 수집 레이어 표준 절차(SOP)
└── AGENTS.md                    # 에이전트 지침 (전체 요약)
```

## 리서치 도구 (MCP 3종)

| 도구 | 역할 | 키 필요? |
| --- | --- | --- |
| **Context7** | 라이브러리/프레임워크 공식 문서 | 무료로 시작, rate limit 시 키 |
| **grep** | 실제 GitHub 코드 사용 예시 검색 | 불필요 |
| **Exa** | 넓은 웹 리서치 | 무료로 시작, rate limit 시 키 |

`.cursor/mcp.json`은 **키 없이 바로 작동**한다. 많이 쓰면 rate limit이 걸리니, 그때 API 키를 추가한다.
키를 추가할 땐 파일에 날것으로 박지 말고 `${env:EXA_API_KEY}` / `${env:CONTEXT7_API_KEY}` 형태로 넣고 셸 환경변수로 관리한다.

- Exa 키: `dashboard.exa.ai/api-keys`
- Context7 키: `context7.com/dashboard`

## 사용법

### 1) 새 프로젝트에 적용

- GitHub에서 이 레포를 **Settings → Template repository** 로 지정 → 새 프로젝트는 초록색 **Use this template** 버튼으로 생성.
- 또는 `.cursor/` 폴더와 `AGENTS.md`만 새 프로젝트에 복사.

### 2) 로컬 커서에서 MCP 켜기

프로젝트 레포의 `.cursor/mcp.json`은 레포와 함께 딸려온다. 로컬 Cursor에서:

1. 프로젝트를 Cursor로 열기
2. Cursor 재시작
3. **Settings → Cursor Settings → Tools & MCP** 에서 `exa` / `context7` / `grep` 3개 활성(초록불) 확인

> 모든 프로젝트에서 항상 쓰고 싶으면, 같은 내용을 로컬 글로벌 `~/.cursor/mcp.json` 에도 넣으면 된다.

### 3) 규칙 늘려가기

같은 지시를 두 번 이상 하게 되면 `/Generate Cursor Rules` 로 패턴을 규칙으로 뽑아 `.cursor/rules/` 에 추가한다. 완벽히 미리 설계하지 말고 **반복될 때마다 굳힌다.**

## 모델 선택 요약

- 새 프로젝트/MVP → **Grok**
- 작은 수정·반복 → **Composer**
- 대규모 리팩토링·고위험·정밀 디버깅 → **Claude/GPT로 계획·검수**, 구현은 Composer

자세한 건 `AGENTS.md` 와 `.cursor/rules/model-routing.mdc` 참고.
