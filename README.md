# nlpm

Natural-Language Programming Manager — scan, lint, and score NL artifacts with Claude-native intelligence.

Part of the [xiaolai Claude plugin marketplace](https://github.com/xiaolai/claude-plugin-marketplace).

## What it does

- **Scan** — discover all NL programming artifacts in a repo (skills, agents, commands, rules, hooks, prompts)
- **Lint** — static analysis with 100-point quality scoring per artifact
- **Init** — configure lint strictness per project

Claude-native — no external model dependency. Claude IS the authority on Claude Code conventions.

## Installation

```bash
claude plugin install nlpm@xiaolai --scope project
```

## Commands

| Command | Description |
|---------|-------------|
| `/nlpm:scan` | Discover and inventory all NL artifacts in a repo |
| `/nlpm:lint` | Static analysis with 100-point quality scoring |
| `/nlpm:init` | Initialize NLPM for a project — set lint strictness |

### Lint flags

| Flag | Effect |
|------|--------|
| `--plugin` | Add cross-component checks (reference integrity, orphans, contradictions) |
| `--fix` | Auto-fix fixable issues (missing user-invocable, heading gaps, field renames) |

## How scoring works

Start at 100 points. Apply deterministic penalties per artifact type:

| Penalty | Example |
|---------|---------|
| -25 | Missing required frontmatter field |
| -15 | Agent has no `<example>` blocks |
| -10 | No output format defined |
| -5 | Model not declared |
| -2 each | Vague quantifiers ("appropriate", "relevant", "as needed") |

Score bands: **90+ Excellent** | 80-89 Good | 70-79 Adequate | 60-69 Weak | <60 Rewrite

## Agents

| Agent | Model | Role |
|-------|-------|------|
| `scanner` | haiku | Fast artifact discovery and classification |
| `linter` | sonnet | Judgment-based quality analysis with penalty scoring |

## Skills

| Skill | Purpose |
|-------|---------|
| `nlpm:conventions` | Claude Code schemas, hook events, prompt engineering conventions |
| `nlpm:patterns` | NL programming best practices + anti-patterns catalog |
| `nlpm:scoring` | Quality rubric with penalty tables and calibration examples |

## Configuration

Create `.claude/nlpm.local.md` in your project (or run `/nlpm:init`):

```yaml
---
strictness: standard
score_threshold: 70
---
```

Strictness levels: relaxed (60), standard (70), strict (80).

## What it lints

Artifacts in scope for v0.1:
- **Plugin artifacts**: commands, shared partials, agents, skills, hooks, plugin.json, .mcp.json
- **Project config**: CLAUDE.md, .claude/rules/, settings

Coming in future versions: general AI prompts, agent frameworks, design docs, synthetic testing, refactoring.

## Prerequisites

None — pure markdown plugin. No Python, no Node.js.

## License

MIT
