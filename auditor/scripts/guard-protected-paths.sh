#!/bin/bash
# Guard: block commits that modify NLPM's core artifacts.
# Run before every git add/commit in auditor workflows.
# Exit 1 if protected files were modified.

PROTECTED_PATHS=(
  "skills/"
  "agents/"
  "commands/"
  "hooks/"
  "CLAUDE.md"
  "README.md"
  "RULES.md"
  "EXAMPLES.md"
  ".claude-plugin/"
  ".nlpm-test/"
)

VIOLATIONS=()

for path in "${PROTECTED_PATHS[@]}"; do
  CHANGED=$(git diff --name-only HEAD -- "$path" 2>/dev/null)
  STAGED=$(git diff --cached --name-only -- "$path" 2>/dev/null)

  if [ -n "$CHANGED" ] || [ -n "$STAGED" ]; then
    VIOLATIONS+=("$path")
    echo "VIOLATION: protected path modified: $path"
    [ -n "$CHANGED" ] && echo "  unstaged: $CHANGED"
    [ -n "$STAGED" ] && echo "  staged: $STAGED"
  fi
done

if [ ${#VIOLATIONS[@]} -gt 0 ]; then
  echo ""
  echo "BLOCKED: ${#VIOLATIONS[@]} protected path(s) were modified."
  echo "Auditor workflows must NEVER modify NLPM's core artifacts."
  echo "Only auditor/ and case-studies/ may be written by the pipeline."
  echo ""
  echo "If this is intentional (human-initiated rule update), run:"
  echo "  git add <file> && git commit  (manually, outside the workflow)"
  exit 1
fi

echo "Guard passed: no protected paths modified."
exit 0
