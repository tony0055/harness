---
name: context-loop
description: Keep the project's "ontology" (persistent context) from rotting, even in autonomous runs. Two paperthin combos clean the context and pick the next move/model. Use for long autonomous work, session re-entry, or after context compaction.
---

# Context Loop — persistent ontology context management (paperthin composition)

paperthin author's guidance: **compose paperthin into a persistent, ontology-context-managing loop pipeline that works even in the autonomous state.**

Prereq: paperthin installed → `npx skills@latest add LilMGenius/paperthin --agent cursor`

## Ontology file (single source of truth)

Keep the project's living knowledge/vocabulary/decisions in **one place: `.cursor/context/ontology.md`**. This is the SSOT that survives across sessions, compaction, and autonomous runs. The file is the truth, not conversation memory.

## Combo I — clean context (hygiene)
`/ssotize` → `/re0` → `/debloat` → `/reorder`

1. `/ssotize` — consolidate scattered facts into the ontology file; point the rest at it.
2. `/re0` — rewrite the drifted ontology as a clean v0, not another patch.
3. `/debloat` — compress padding/duplication/enumeration to load-bearing density (meaning preserved).
4. `/reorder` — realign items under one stated principle (order only; no rewording).

**When**: periodically during long work (e.g., after a big stage), right after context compaction, or when the ontology feels messy.

## Combo II — decide next move
`/nba` → `/modelchk`

1. `/nba` — read live state, return the single next best action (not a menu).
2. `/modelchk` — size the cheapest sufficient tier (fast/standard/frontier) + reasoning effort for it.

**When**: between stages, choosing what to do next. Apply the `model-routing` budget guard (frontier escalation-only; degrade to Cursor-native when low).

## Autonomous integration
In long autonomous work (`autonomous` rule):
```
repeat:
  Build → /sip (self-check)
  after a big stage → Combo I (clean the ontology)
  when deciding next → Combo II (action + model) → apply model-routing budget guard
  on re-entry / lost context → /catchup first
stop when: goal met && /sip passes && ontology current.
```

Core: accumulate **learning/context, not code** (paperthin `re0-loop`). Drop wrong builds; carry only the lessons left in the ontology.
