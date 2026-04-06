---
name: score
description: "Score NL programming artifacts — 100-point quality analysis per file"
argument-hint: "[path]"
allowed-tools: Read, Glob, Grep, Bash, Task
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
| --changed | Score only files changed since last commit (uses `git diff --name-only HEAD`) |

If `--changed` is present: run `git diff --name-only HEAD` to get changed files, then filter through `commands/shared/classify.md` to keep only NL artifacts. Skip the full discovery step.

### Step 3: Discover Artifacts

If path is a directory: use `commands/shared/discover.md` to find all NL artifacts.
If path is a file: use `commands/shared/classify.md` to determine its type.

If no artifacts found → "No NL programming artifacts found."

### Step 4: Score Artifacts

Dispatch two agents in parallel for each batch of up to 5 artifacts:

1. **`nlpm:scorer`** -- scores each artifact on the 100-point rubric (penalties, structure, heuristics)
2. **`nlpm:vague-scanner`** -- counts vague quantifier words mechanically (fast, haiku)

The scorer incorporates the vague-scanner's word counts into its penalty calculation. If the vague-scanner reports counts that differ from the scorer's own detection, use the vague-scanner's counts (deterministic grep is more reliable than heuristic detection for word counting).

Pass to both agents:
- The artifact contents (read each file)
- The artifact types (from classify.md)
- Any rule overrides from the config (if `rule_overrides` is present in `.claude/nlpm.local.md`)

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

If `.claude/nlpm-history.json` does not exist, skip this step. Run `/nlpm:trend` to initialize tracking — it creates the history file on first run.
