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

- skills/nlpm/conventions/ — Claude Code + prompt conventions (refreshable)
- skills/nlpm/patterns/ — NL programming best practices
- skills/nlpm/scoring/ — quality rubric with calibration examples

## Scoring

100-point scale. Start at 100, apply deterministic penalties.
Floor: 0. Ceiling: 100.
Threshold configurable via .claude/nlpm.local.md (default: 70).
