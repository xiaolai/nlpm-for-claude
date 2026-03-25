# nlpm

Natural-Language Programming Manager — score, check, and fix NL artifacts with Claude-native intelligence.

Part of the [xiaolai Claude plugin marketplace](https://github.com/xiaolai/claude-plugin-marketplace).

## What it does

- **ls** — discover all NL programming artifacts in a repo
- **score** — 100-point quality scoring per artifact
- **check** — cross-component consistency (references, orphans, contradictions)
- **fix** — auto-fix fixable issues
- **init** — configure lint strictness per project

Claude-native — no external model dependency. Claude IS the authority on Claude Code conventions.

## Installation

```bash
claude plugin install nlpm@xiaolai --scope project
```

## Commands

| Command | Description |
|---------|-------------|
| `/nlpm:ls` | Discover and inventory all NL artifacts in a repo |
| `/nlpm:score` | Score artifact quality (100-point scale) |
| `/nlpm:check` | Cross-component consistency checks |
| `/nlpm:fix` | Auto-fix fixable issues |
| `/nlpm:init` | Initialize NLPM for a project — set strictness |

Each command does one thing. No flags to memorize.

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

## What it scores

Artifacts in scope for v0.1:
- **Plugin artifacts**: commands, shared partials, agents, skills, hooks, plugin.json, .mcp.json
- **Project config**: CLAUDE.md, .claude/rules/, settings

Coming in future versions: general AI prompts, synthetic testing, refactoring, diff.

## Prerequisites

None — pure markdown plugin. No Python, no Node.js.

## License

MIT
