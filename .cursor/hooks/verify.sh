#!/usr/bin/env bash
# Fail-open verification hook (Cursor `stop`): runs any available linter once the
# agent finishes a task, so lint issues surface without a manual step.
# Observe-only by design — it never blocks and always exits 0. Auto-detects the
# stack; if no linter is found it stays silent. Requires a Trusted workspace.
set +e
say() { printf '[verify] %s\n' "$1" >&2; }
ran=0

# Node: run the "lint" script if package.json defines one
if [ -f package.json ] && grep -q '"lint"' package.json 2>/dev/null; then
  ran=1
  if   [ -f pnpm-lock.yaml ] && command -v pnpm >/dev/null 2>&1; then say "pnpm run lint"; pnpm run -s lint
  elif [ -f yarn.lock ]     && command -v yarn >/dev/null 2>&1; then say "yarn lint";     yarn -s lint
  else say "npm run lint"; npm run --silent lint
  fi
fi

# Python: ruff if available and any .py files exist
if command -v ruff >/dev/null 2>&1 && \
   [ -n "$(find . -name '*.py' -not -path '*/node_modules/*' -not -path '*/.git/*' 2>/dev/null | head -1)" ]; then
  ran=1; say "ruff check ."; ruff check .
fi

[ "$ran" = 0 ] && say "no linter detected — skipped"
exit 0
