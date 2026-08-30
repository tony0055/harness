# /next — next best action + model sizing (paperthin Combo II)

Read live state, decide the next move, then pick the cheapest sufficient model.

1. `/nba` — read the current cycle state and return the single next best action (no menu/checklist).
2. `/modelchk` — size the capability tier (fast/standard/frontier) and reasoning effort that action needs.

Then apply the **budget guard** from the `model-routing` rule:
- Escalate to frontier (Claude/GPT) only when `modelchk` says it's truly needed.
- When budget/tokens run low, degrade everything to Cursor-native (Composer/Auto/Grok).

Prereq: paperthin installed (`npx skills@latest add LilMGenius/paperthin --agent cursor`).
