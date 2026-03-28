---
description: "Discover and inventory all natural language programming artifacts in a repository"
argument-hint: "[repo-path]"
allowed-tools: Read, Glob, Grep, Task
---

## User Input

```text
$ARGUMENTS
```

## Workflow

### Step 1: Determine Path

| Input | Path |
|-------|------|
| (empty) | current working directory |
| directory path | use that path |
| file path | ERROR: "Expected a directory. Use /nlpm:score for individual files." |
| nonexistent path | ERROR: "Directory not found: {path}" |

### Step 2: Discover Artifacts

Dispatch the `nlpm:scanner` agent with the target directory. The scanner follows the discovery patterns from `commands/shared/discover.md` to find all Category A (plugin) and Category B (project config) artifacts.

### Step 3: Display Report

Show the scanner's inventory report. If no artifacts found: "No NL programming artifacts found in {path}."
