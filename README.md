# harness (English source-of-truth)

**Reusable Cursor harness template.** Clone it for each new project and start with research tools (MCP), work rules, roles/combos, and agent guidance (`AGENTS.md`) already wired. Lightweight for **Cursor-only + MVP-scale** work.

This is the **English operative version** (the agent reads English; instruction-following is most reliable in English). The Korean learning/reference version lives in a separate repo. The agent **replies to the user in Korean** (set in `harness-core` and `AGENTS.md`).

## One-line philosophy

> Encode the repeated as **Rules**, delegate the tool-driven to **MCP**, leave the case-by-case to the **human**. Switch **models** by task (minding cost).

Always split work into three layers: **Research → Execute → Decide**.

## What was ported (from the OmO / opencodex / paperthin study)

| Source | Ported | Form |
| --- | --- | --- |
| **OmO** | category model routing, specialized agents, autonomous loop | cost-routing rule + 4 roles + autonomous rule |
| **paperthin** | anti-slop low-level design-pattern skills | install via npx + composition combos/loop |
| **opencodex** | (proxy — unneeded for Cursor-only) | not ported |

## Folder structure

```
.
├── .cursor/
│   ├── mcp.json                 # research tools (exa · context7 · grep)
│   ├── environment.json         # cloud-agent environment
│   ├── context/ontology.md      # persistent-context SSOT
│   ├── commands/
│   │   ├── context-clean.md     # /context-clean  Combo I: clean the ontology
│   │   └── next.md              # /next           Combo II: next move + model sizing
│   ├── rules/
│   │   ├── harness-core.mdc     # [Always]          core frame (layers, encoding criteria)
│   │   ├── research.mdc         # [Agent Requested] research tool order
│   │   ├── roles.mdc            # [Agent Requested] four roles (Plan/Explore/Build/Review)
│   │   ├── model-routing.mdc    # [Agent Requested] cost-aware model routing
│   │   └── autonomous.mdc       # [Agent Requested] autonomous execution loop
│   └── skills/
│       ├── research/SKILL.md    # gathering-layer SOP
│       └── context-loop/SKILL.md# persistent ontology context loop (paperthin composition)
└── AGENTS.md                    # agent guidance (summary)
```

## Research tools (MCP)

| Tool | Role | Key needed? |
| --- | --- | --- |
| **Context7** | official library/framework docs | free to start; key on rate limit |
| **grep** | real GitHub code usage search | none |
| **Exa** | broad web research | free to start; key on rate limit |

`.cursor/mcp.json` works keyless. On rate limits, add keys as `${env:EXA_API_KEY}` / `${env:CONTEXT7_API_KEY}` (never raw in the file).

## Install paperthin (external, verified skills)

anti-slop low-level design patterns. Don't reinvent — install as-is:

```
npx skills@latest add LilMGenius/paperthin --agent cursor
```

This harness only **composes** paperthin:
- **Combo I** `/context-clean` = `/ssotize` → `/re0` → `/debloat` → `/reorder` (clean the ontology)
- **Combo II** `/next` = `/nba` → `/modelchk` (next move + cheapest sufficient model)
- **Persistent loop** `context-loop` skill — keeps `.cursor/context/ontology.md` from rotting, even autonomously

## Model selection (cost-aware — Cursor Pro $20)

- **fast** (trivial/repetitive) → Composer / Auto (included)
- **standard** (most implementation / MVP) → Grok (low cost)
- **frontier** (high-risk / tricky debugging / key review) → Claude/GPT, **sparingly, plan/review only**
- **Budget guard**: frontier escalation-only; when budget runs low, drop everything to Cursor-native.

See `AGENTS.md` and `.cursor/rules/model-routing.mdc`.

## Usage

### 1) Apply to a new project
- Set this repo as a **Template repository** on GitHub → create new projects with **Use this template**.
- Or copy the `.cursor/` folder and `AGENTS.md`.

### 2) Local Cursor setup
1. Open the project in Cursor, restart → **Settings → Cursor Settings → Tools & MCP** and confirm `exa`/`context7`/`grep` are green.
2. Install paperthin: `npx skills@latest add LilMGenius/paperthin --agent cursor`
3. (optional) Register the 4 roles as Custom Modes — see `docs/custom-modes.md`.

### 3) Grow the rules
When you give the same instruction twice, run `/Generate Cursor Rules` to extract the pattern into `.cursor/rules/`. Don't design it all up front — **harden as it repeats.**
