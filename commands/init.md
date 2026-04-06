---
name: init
description: "Initialize NLPM for this project — detect artifacts, set lint strictness"
allowed-tools: Read, Write, Glob, AskUserQuestion
---

## Workflow

### Step 1: Check Existing Config

Read `.claude/nlpm.local.md`. If exists, show current settings and ask: "Reconfigure? (yes/no)". If no → stop.

### Step 2: Scan

Run artifact discovery (same as /nlpm:ls) to show what's in the project.

### Step 3: Ask Strictness

```
AskUserQuestion:
  question: "What lint strictness level?"
  header: "Strictness"
  options:
    - label: "Relaxed"
      description: "Threshold 60 — only flag seriously broken artifacts"
    - label: "Standard (Recommended)"
      description: "Threshold 70 — flag artifacts that need improvement"
    - label: "Strict"
      description: "Threshold 80 — flag anything below good quality"
```

### Step 4: Write Config

Create `.claude/` directory if needed. Write `.claude/nlpm.local.md`:

```markdown
---
# NLPM Configuration
strictness: {chosen}
score_threshold: {60|70|80}
---

# NLPM Settings

When linting NL artifacts in this project, use **{strictness}** strictness.
Flag artifacts scoring below **{threshold}/100** for improvement.
```

### Step 5: Update .gitignore

Append the following to `.gitignore` (skip lines already present):

```
# nlpm generated artifacts
.claude/nlpm-history.json
```

### Step 6: Confirm

```
NLPM initialized for this project.
  Strictness: {standard}
  Threshold: {70}/100
  Artifacts found: {N}
  Config: .claude/nlpm.local.md

Run /nlpm:score to assess your artifacts.
```

**Error handling:**
- No artifacts found → still create config, note "No artifacts found yet"
- `.claude/` directory doesn't exist → create it
