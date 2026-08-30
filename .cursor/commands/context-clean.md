# /context-clean — clean the ontology context (paperthin Combo I)

Clean `.cursor/context/ontology.md` (and any specified artifact) with this paperthin pipeline. Run each step in order; destructive changes only after approval.

1. `/ssotize` — consolidate scattered facts into the ontology; replace the rest with references.
2. `/re0` — rewrite the drifted doc as a clean v0, not another patch.
3. `/debloat` — compress padding/duplication/enumeration to load-bearing density (meaning preserved).
4. `/reorder` — realign items under one stated principle (order only; no content change).

Prereq: paperthin installed (`npx skills@latest add LilMGenius/paperthin --agent cursor`).
If no target file is given, default to `.cursor/context/ontology.md`.
