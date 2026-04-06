---
name: test
description: "Run NL artifact tests — evaluate artifacts against .nlpm-test/*.spec.md specifications (TDD for natural language programming)"
argument-hint: "[spec-path]"
allowed-tools: Read, Glob, Grep, Task
---

## User Input

```text
$ARGUMENTS
```

## Workflow

### Step 1: Discover Specs

| Input | Behavior |
|-------|----------|
| (empty) | Glob for `.nlpm-test/*.spec.md` in cwd |
| path to a .spec.md file | Test that single spec |
| path to a directory | Glob for `*.spec.md` in that directory |

If no specs found → "No test specs found. Create specs in `.nlpm-test/` directory. See `skills/nlpm/testing/SKILL.md` for the spec format."

Display discovered specs:
```
Found {N} spec(s):
  .nlpm-test/my-agent.spec.md → agents/my-agent.md
  .nlpm-test/core-skill.spec.md → skills/core/SKILL.md
```

### Step 2: Load Config

Read `.claude/nlpm.local.md` if exists. Extract `score_threshold` (default: 70). This is used as the fallback `min_score` when specs don't specify one.

### Step 3: Run Tests

For each spec, dispatch the `nlpm:tester` agent with:
- The spec file content
- The artifact file content (if it exists)
- The scoring rubric reference

Batch specs in groups of up to 3 (each spec requires reading 2 files + analysis).

### Step 4: Report

```markdown
NLPM Test Report

Spec                              Artifact                    Result   Checks
─────────────────────────────────────────────────────────────────────────────────
{for each spec}

Overall: {passed} passed, {failed} failed, {red} red

{if any RED:}
RED (write these artifacts next):
  {artifact_path} — spec exists but artifact doesn't

{if any FAIL:}
FAIL (fix these):
  1. {artifact_path} — {specific failure description}

{if all PASS:}
All specs pass. GREEN.
```

### Error Handling

- Spec has no `artifact:` frontmatter → "Spec missing `artifact:` field: {spec_path}"
- Spec references invalid type → "Unknown artifact type '{type}' in {spec_path}. Valid: agent, skill, command, rule, hook, prompt"
- Malformed YAML frontmatter in spec → "Malformed spec: {spec_path}"
