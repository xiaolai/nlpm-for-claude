---
description: "Lint natural language programming artifacts — static analysis with 100-point quality scoring"
argument-hint: "[path] [--plugin] [--fix]"
allowed-tools: Read, Write, Edit, Glob, Grep, Task, AskUserQuestion
---

## User Input

```text
$ARGUMENTS
```

## Workflow

### Step 1: Load Config

Read `.claude/nlpm.local.md` if it exists. Extract `score_threshold` from the YAML frontmatter (default: 70 if file doesn't exist or field is missing).

### Step 2: Parse Arguments

| Input | Behavior |
|-------|----------|
| (empty) | Lint all Category A+B artifacts in cwd |
| directory path | Lint all artifacts under that directory |
| file path | Lint that single file |
| `--plugin` | Add cross-component checks after individual linting |
| `--fix` | Auto-fix fixable issues after linting |

### Step 3: Discover Artifacts

If path is a directory: use `commands/shared/discover.md` to find all NL artifacts.
If path is a file: use `commands/shared/classify.md` to determine its type.

If no artifacts found → "No NL programming artifacts found."

### Step 4: Lint Artifacts

Batch artifacts into groups of up to 5. For each batch, dispatch the `nlpm:linter` agent with:
- The artifact contents (read each file)
- The artifact types (from classify.md)
- Reference to nlpm:conventions and nlpm:scoring skills

Collect results: per-artifact score + issue list.

### Step 5: Cross-Component Checks (if --plugin)

Dispatch one additional `nlpm:linter` call with ALL artifacts and the instruction to perform cross-component analysis:
- Check all literal path references resolve to existing files
- Check agent frontmatter `skills:` entries reference existing skills
- Check for orphaned components (defined but never referenced)
- Check for behavioral contradictions

### Step 6: Auto-Fix (if --fix)

For each auto-fixable issue:
- Missing `user-invocable: false` on shared partials → add to frontmatter
- `tools` field where `allowed-tools` expected → rename field
- Heading hierarchy gaps → insert missing heading levels
- Trailing whitespace → strip

After fixes, re-lint the fixed files and show updated scores.

NOT auto-fixable (list but don't modify):
- Vague descriptions, missing examples, model selection, contradictions

### Step 7: Report

```markdown
NLPM Lint Report

File                              Type      Score   Issues
───────────────────────────────────────────────────────────
{for each file}

Overall: {avg_score}/100 — {EXCELLENT|GOOD|ADEQUATE|WEAK|REWRITE}    [threshold: {score_threshold}]
  High: {N} | Medium: {N} | Low: {N}
  Below threshold: {N} files

Top issues:
  1. [{SEVERITY}] {file}:{line} — {issue} ({penalty})
  2. ...

Score guide: 90+ Excellent | 80-89 Good | 70-79 Adequate | 60-69 Weak | <60 Rewrite
```

**Error handling:**
- File unreadable → skip with warning: "Skipped {path}: unreadable"
- Malformed YAML frontmatter → score penalty -25, continue analysis on body
- Empty file → score 0, issue: "Empty file"
