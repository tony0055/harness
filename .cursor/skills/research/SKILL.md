---
name: research
description: Gather facts with Exa + Context7 + grep and report them with sources. Use for investigating a library, fact-checking, or finding real usage examples.
---

# Research Skill (gathering layer SOP)

The standard procedure for the "gather information" layer. Keep it separate from judgment and implementation.

## When to use
- You need the exact usage of a library/API you haven't used before.
- You need real examples of how others implemented a feature.
- You need broad web research — concepts, comparisons, recent developments.

## Procedure
1. **Break the question into verifiable parts.** ("What's a good library?" → "candidate libraries for X + current usage of each")
2. **Pick the tool** (order per the `research` rule):
   - official docs / exact API → **Context7** (`get-library-docs`)
   - real code examples → **grep** (`searchGitHub`)
   - broad web / concepts / comparisons → **Exa** (`web_search_exa`)
3. **Cross-check.** Verify important facts against at least two sources (docs + real code).
4. **Report.** Conclusion first → evidence → source links. State unverified items explicitly.

## Output format
```
## Conclusion
- (core answer, 1–3 lines)

## Evidence
- claim A — source: <link/path>
- claim B — source: <link/path>

## Unverified / caution
- (what couldn't be verified, or needs a human decision)
```

## Boundary
- Research gathers **facts only**. Decisions ("so let's go with this topic") go to the human (Decide layer).
- Don't assert tool-verifiable facts from memory.
