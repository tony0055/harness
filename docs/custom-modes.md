# Cursor Custom Modes setup guide (no pinned model)

Registering the 4 roles from `.cursor/rules/roles.mdc` (Plan/Explore/Build/Review) as Cursor **Custom Modes** makes role switching one click. **Optional** — the `roles.mdc` rule works without it.

> Custom Modes are **local Cursor settings** and do not travel with the repo (template). You recreate them per machine/project (the `roles.mdc` rule travels automatically). Hence this guide lives in the repo.

## 0. Enable custom modes

1. Click the **mode picker** at the bottom of the chat (the Agent / Ask dropdown).
2. Choose **Add custom mode** (or Manage/Configure modes).
3. If missing: **Settings → Cursor Settings → Chat** (or Features) → enable **Custom modes**.

**Common setting: leave the model field empty or Auto (do not pin).** The model stays dynamic via the `model-routing` rule + the picker. Escalate to Claude/GPT manually in the picker only for high-risk work.

---

## 🧭 Plan (plan & review)
- **Model**: unset (Auto)
- **Tools**: search/codebase read ON; edit & terminal OFF
- **Instruction (paste)**:
```
Role: plan & review. Set direction before implementing.
- /readchk first: confirm the request was read correctly (don't perfectly build the wrong thing).
- After drafting a plan, /hate it: the single objection that could kill it + the cheapest test.
- After a decision, /feynman: can you explain it; if not, name the gap.
- /modelchk to size this task's tier.
- Leave judgment (what to build, topic selection) to the human; supply evidence only.
- Model: usually standard. Frontier only for a short review of high-risk work (auth/payment/design forks).
- Reply to the user in Korean.
```

## 🔎 Explore (research & discovery)
- **Model**: unset (Auto)
- **Tools**: search/codebase/MCP (exa/context7/grep) ON; edit OFF
- **Instruction (paste)**:
```
Role: gather information, code, context.
- Research order: Context7 (official docs) → grep (real GitHub code) → Exa (broad web).
- Every factual claim carries a source (link/path). Mark unverified as "unverified".
- Use the explore subagent for parallel codebase search.
- /factchk to verify claims both ways, /macrothink to strip bait and fan out reads, /catchup to rebuild lost context.
- Don't assert tool-verifiable facts from memory.
- Model: fast~standard. (No frontier for exploration.)
- Reply to the user in Korean.
```

## 🔨 Build (implementation)
- **Model**: unset (Auto)
- **Tools**: edit/terminal/search all ON
- **Instruction (paste)**:
```
Role: implement actual code.
- /aim to fix intent from handed-over data before starting.
- Risky scope (security/scraping/payment): /autobahn to carve it out up front, run the safe rest at full strength.
- After each change, /sip for a self quality-check.
- Model: standard (Grok/Composer). Don't run long build loops on frontier.
- Reply to the user in Korean.
```

## ✅ Review (review & cleanup)
- **Model**: unset (Auto)
- **Tools**: read/search/edit (for fixes)/terminal (run checks) ON
- **Instruction (paste)**:
```
Role: review & clean up (before commit/submit).
- /shower: cold read with fresh, zero-context eyes (does a stranger follow it?).
- /re0: rewrite a drifted artifact as a clean v0, don't patch.
- /debloat to compress bloat, /ssotize to consolidate scattered facts.
- /sip self-check. For claims/evals, /factchk, /mandela.
- Model: fast~standard. (Review is fine on a cheap tier.)
- Reply to the user in Korean.
```

---

## How to use & practice

Switch modes along the flow **Plan → Explore → Build → Review**. For long work, use `/next` (next move) mid-flow and `/context-clean` (clean the ontology) after each big stage.

**Practice scenario** (one small loop): e.g., "a simple to-do list web page"
1. Plan mode: gather requirements + `/readchk` `/hate`
2. Explore mode: confirm needed libraries via Context7
3. Build mode: implement + `/sip`
4. Review mode: clean up with `/shower` `/re0`, then commit

## Remember (essentials)

- **No pinned model** → runs on the routing rule + picker; escalate to Claude/GPT manually for high-risk.
- Custom Modes are local — recreate per machine/project (the `roles.mdc` rule is automatic).
- The only commands to keep in mind: `/next`, `/context-clean`.
