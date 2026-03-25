---
description: "Auto-fix fixable issues in NL artifacts — missing fields, heading gaps, field renames"
argument-hint: "[path]"
allowed-tools: Read, Write, Edit, Glob, Grep, Task
---

## User Input

```text
$ARGUMENTS
```

## Workflow

### Step 1: Score First

Run the same scoring logic as `/nlpm:score` on the target path. Collect all issues.

### Step 2: Classify Issues

Separate issues into auto-fixable and not-auto-fixable:

**Auto-fixable (will be applied):**
- Missing `user-invocable: false` on shared partials → add to frontmatter
- `tools` field where `allowed-tools` expected → rename field
- Heading hierarchy gaps (## → ####) → insert missing ### level
- Trailing whitespace → strip

**NOT auto-fixable (reported but not modified):**
- Vague descriptions (what should the trigger phrases be?)
- Missing `<example>` blocks (what scenarios?)
- Model selection (haiku vs sonnet vs opus?)
- Behavioral contradictions (which artifact is right?)
- Scope boundaries, output formats, error handling

### Step 3: Apply Fixes

For each auto-fixable issue:
1. Read the file
2. Apply the fix using Edit tool
3. Log: "Fixed: {file}:{line} — {what was changed}"

### Step 4: Re-Score

Re-run scoring on all fixed files to compute new scores.

### Step 5: Report

```markdown
NLPM Fix Report

Fixed {N} issues in {M} files:
  {file}:{line} — added user-invocable: false (+25 points)
  {file}:{line} — renamed tools → allowed-tools (+0 points, consistency)
  {file}:{line} — inserted missing ### heading (+0 points)

Not auto-fixable ({N} issues remain):
  [{SEVERITY}] {file}:{line} — {issue} (requires human judgment)

Score changes:
  {file}   {old_score} → {new_score}  (+{delta})

Overall: {old_avg} → {new_avg}
```

**Error handling:**
- No fixable issues found → "All issues require human judgment. Run /nlpm:score to see details."
- File not writable → skip with warning
