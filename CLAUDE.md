# nlpm

Natural-Language Programming Manager for Claude Code.

## Architecture

Commands orchestrate agents. Agents use skills as reference knowledge.
Each command does one thing — no flags.

## Commands

- commands/ls.md — `/nlpm:ls` — discover + inventory NL artifacts
- commands/score.md — `/nlpm:score` — 100-point quality scoring per artifact
- commands/check.md — `/nlpm:check` — cross-component consistency checks
- commands/fix.md — `/nlpm:fix` — auto-fix fixable issues
- commands/init.md — `/nlpm:init` — initialize project config
- commands/shared/discover.md — artifact discovery patterns (not user-invocable)
- commands/shared/classify.md — artifact type classification (not user-invocable)

## Agents

- agents/scanner.md — haiku, mechanical discovery
- agents/linter.md — sonnet, judgment-based quality analysis

## Skills

### Core (used by linter/scanner agents)
- skills/nlpm/conventions/ — Claude Code + prompt conventions (refreshable)
- skills/nlpm/patterns/ — NL programming patterns + anti-patterns
- skills/nlpm/scoring/ — quality rubric with calibration examples

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

## Scoring

100-point scale. Start at 100, apply deterministic penalties.
Floor: 0. Ceiling: 100.
Threshold configurable via .claude/nlpm.local.md (default: 70).
