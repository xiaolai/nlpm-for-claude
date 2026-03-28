# nlpm

Natural-Language Programming Manager for Claude Code.

## Architecture

Commands orchestrate agents. Agents use skills as reference knowledge.
Each command does one thing — no flags.

## Commands

- commands/ls.md — `/nlpm:ls` — run first to discover what NL artifacts exist in the project
- commands/score.md — `/nlpm:score` — run to get 100-point quality scores; use after any artifact edit
- commands/check.md — `/nlpm:check` — run to verify cross-component references before shipping
- commands/fix.md — `/nlpm:fix` — run to auto-repair fixable issues flagged by score
- commands/trend.md — `/nlpm:trend` — run periodically to detect quality drift over multiple sessions
- commands/test.md — `/nlpm:test` — run NL artifact tests against .nlpm-test/*.spec.md specs (TDD)
- commands/init.md — `/nlpm:init` — run once when adding NLPM to a new project
- commands/shared/discover.md — artifact discovery patterns (not user-invocable)
- commands/shared/classify.md — artifact type classification (not user-invocable)

## Agents

- agents/scanner.md — haiku, mechanical discovery
- agents/linter.md — sonnet, judgment-based quality analysis
- agents/tester.md — sonnet, evaluates artifacts against test specs

## Skills

### Core (used by linter/scanner/tester agents)
- skills/nlpm/conventions/ — Claude Code + prompt conventions (refreshable)
- skills/nlpm/patterns/ — NL programming patterns + anti-patterns
- skills/nlpm/scoring/ — quality rubric with calibration examples
- skills/nlpm/rules/ — the 50 rules of natural language programming (R01-R50)
- skills/nlpm/testing/ — NL-TDD spec format, test patterns, the TDD cycle

### Writing Reference (loaded on demand when writing new artifacts)
- skills/nlpm/writing-skills/ — how to write SKILL.md files
- skills/nlpm/writing-agents/ — how to write agent definitions
- skills/nlpm/writing-rules/ — how to write .claude/rules/ files
- skills/nlpm/writing-prompts/ — universal prompt engineering guide
- skills/nlpm/writing-hooks/ — how to write Claude Code hooks
- skills/nlpm/writing-plugins/ — how to design and build plugins
- skills/nlpm/orchestration/ — multi-agent workflow patterns

## Hooks

- hooks/hooks.json — PostToolUse advisory: reminds to score after editing NL artifacts

## Build & Run

No build step required — this is a pure markdown plugin. Install with:
```
claude plugin install nlpm@xiaolai --scope project
```

Test by running `/nlpm:ls` on any project with NL artifacts.

## Prerequisites

None. No Python, Node.js, or compiled dependencies.

## Development

When modifying this plugin:
- Run `/nlpm:score ./` after changes to verify quality stays above 90
- Run `/nlpm:check` to verify cross-component references
- Bump version in plugin.json AND marketplace.json
- Push plugin repo, then update central marketplace

## Scoring

100-point scale. Start at 100, apply deterministic penalties.
Floor: 0. Ceiling: 100.
Threshold configurable via .claude/nlpm.local.md (default: 70).
