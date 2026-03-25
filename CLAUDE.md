# nlpm

Natural-Language Programming Manager for Claude Code.

## Architecture

Commands orchestrate agents. Agents use skills as reference knowledge.

v0.1: scan (discover artifacts) → lint (score quality) → init (configure)

## Components

- commands/scan.md — discover + inventory NL artifacts
- commands/lint.md — static analysis with 100-point scoring
- commands/init.md — initialize project config
- commands/shared/discover.md — artifact discovery patterns
- commands/shared/classify.md — artifact type classification
- agents/scanner.md — haiku, mechanical discovery
- agents/linter.md — sonnet, judgment-based analysis
- skills/nlpm/conventions/ — Claude Code + prompt conventions
- skills/nlpm/patterns/ — NL programming best practices
- skills/nlpm/scoring/ — quality rubric with calibration examples

## Scoring

100-point scale. Start at 100, apply deterministic penalties.
Floor: 0. Ceiling: 100.
Threshold configurable via .claude/nlpm.local.md (default: 70).
