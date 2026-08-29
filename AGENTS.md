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

## 모델 선택

작업 성격에 따라 모델을 고른다. (자세한 표는 `.cursor/rules/model-routing.mdc`)

- 새 프로젝트/MVP 스캐폴딩 → **Grok**
- 작은 수정·반복 패턴 → **Composer**
- 대규모 리팩토링·고위험 로직·정밀 디버깅 → **Claude/GPT로 계획·검수**, 구현은 Composer

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
