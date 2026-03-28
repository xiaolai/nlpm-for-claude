---
description: "Score NL programming artifacts — 100-point quality analysis per file"
argument-hint: "[path]"
allowed-tools: Read, Glob, Grep, Task
---

## User Input

```text
$ARGUMENTS
```

## Workflow

### Step 1: Load Config

Read `.claude/nlpm.local.md` if it exists. Extract `score_threshold` (default: 70).

### Step 2: Parse Arguments

| Input | Behavior |
|-------|----------|
| (empty) | Score all Category A+B artifacts in cwd |
| directory path | Score all artifacts under that directory |
| file path | Score that single file |

### Step 3: Discover Artifacts

If path is a directory: use `commands/shared/discover.md` to find all NL artifacts.
If path is a file: use `commands/shared/classify.md` to determine its type.

If no artifacts found → "No NL programming artifacts found."

### Step 4: Score Artifacts

Batch artifacts into groups of up to 5. For each batch, dispatch the `nlpm:linter` agent with:
- The artifact contents (read each file)
- The artifact types (from classify.md)
- Reference to nlpm:conventions and nlpm:scoring skills

Collect results: per-artifact score + issue list.

### Step 5: Report

```markdown
NLPM Score Report

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

### Step 6: Update History (if tracking)

If `.claude/nlpm-history.json` exists, append a new snapshot with the current scores. Do not create the file if it doesn't exist — use `/nlpm:trend` to start tracking.
