---
description: "Show quality score trends over time — track improvements, detect degradation"
argument-hint: "[path]"
allowed-tools: Read, Write, Glob, Task
---

## User Input

```text
$ARGUMENTS
```

## Workflow

### Step 1: Load History

Read `.claude/nlpm-history.json` from the project root. If it doesn't exist, show:
"No score history found. Run `/nlpm:score` to create the first snapshot, then `/nlpm:trend` to track changes over time."

### Step 2: Score Current State

Dispatch the `nlpm:linter` agent to score all artifacts (or artifacts at the given path).

### Step 3: Compare Against History

For each artifact in the current score:
- Find its most recent entry in history
- Compute delta: current_score - historical_score
- Flag: improved (delta > 0), degraded (delta < 0), unchanged (delta == 0), new (no history)

### Step 4: Save Snapshot

Append current scores to `.claude/nlpm-history.json`:

```json
{
  "snapshots": [
    {
      "timestamp": "2026-03-28T10:00:00Z",
      "overall": 85,
      "files": {
        "agents/linter.md": { "score": 92, "type": "agent" },
        "commands/score.md": { "score": 95, "type": "command" }
      }
    }
  ]
}
```

### Step 5: Report

```markdown
NLPM Trend Report

Snapshot: 2026-03-28 (3rd snapshot, 2 previous)

File                              Score   Previous  Delta
--------------------------------------------------------------
agents/linter.md                  95      92        +3 improved
agents/scanner.md                 90      90         0 unchanged
commands/score.md                 95      88        +7 improved
skills/nlpm/scoring/SKILL.md      85      85         0 unchanged
.claude/rules/testing.md          78      82        -4 degraded
commands/fix.md (NEW)             88      --        new

Overall: 88/100 (was 87, +1)

Degraded (needs attention):
  .claude/rules/testing.md  82 → 78 (-4)

Trend: 3 snapshots — 82 → 87 → 88 (improving)
```

### Error Handling

- No history file → prompt to run /nlpm:score first
- Path doesn't exist → error with message
- History file malformed → warn, start fresh history
