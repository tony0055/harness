# AGENTS.md — Harness Agent Guide

Reusable Cursor harness template. Lightweight for Cursor-only, MVP-scale work. Setup and usage: `README.md`.

**Reply to the user in Korean.** Rules and reasoning stay in English; user-facing replies are Korean.

## Always

- **Split into layers**: Research (Explore) → Execute (Plan · Build · Review) → Decide (human). Judgment — topic, direction, values — is the human's: not rule-encoded, not run autonomously. (`harness-core`)
- **Cost first**: default to Cursor-native (Composer / Auto / Grok). Frontier (Claude / GPT) is escalation-only for high-risk logic or key review; when budget runs low, drop everything back to Cursor-native. Start cheap. (`model-routing`)
- **Evidence first**: tool-verifiable facts are verified, not recalled; every claim carries a source. (`research`)

## Pointer map

| When you need | Read |
| --- | --- |
| Thinking frame | `rules/harness-core.mdc` (Always) |
| Research (tool order, output format) | `rules/research.mdc`, `skills/research` |
| Role work (Plan/Explore/Build/Review) | `rules/roles.mdc` |
| Model / cost choice | `rules/model-routing.mdc` |
| Long autonomous work | `rules/autonomous.mdc` |
| Persistent context | `skills/context-loop`, `/context-clean`, `/next` |
| Research MCP tools | `.cursor/mcp.json` (exa · context7 · grep) |

## paperthin

The combos (`/context-clean`, `/next`) call paperthin skills. Install once: `npx skills@latest add LilMGenius/paperthin --agent cursor` (details in README).

## Growing rules

When you give the same instruction twice, run `/Generate Cursor Rules` to extract the pattern into `.cursor/rules/`. Write rules as **"trigger → action → output format"**. Types: always-same = Always (`alwaysApply:true`); file-specific = `globs`; situational = Agent Requested (`description`); judgment = not encoded.

## Constraints

- Tool-verifiable facts (APIs, versions): verified, never recalled from memory.
- Judgment (topic, direction, values): the human decides; the agent supplies evidence.
- Secrets (keys, tokens): never in files, logs, or commits.
- Git: no arbitrary branch switching or force-push on `main`.
