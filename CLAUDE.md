# nlpm

Natural-Language Programming Manager for Claude Code.

## Architecture

Commands orchestrate agents. Agents use skills as reference knowledge.
Each command does one thing -- no flags (except `--changed` on score).

## Commands

- commands/ls.md -- `/nlpm:ls` -- discover NL artifacts (dispatches scanner)
- commands/score.md -- `/nlpm:score` -- 100-point quality scoring (dispatches scorer + vague-scanner in parallel)
- commands/check.md -- `/nlpm:check` -- cross-component consistency (dispatches checker)
- commands/fix.md -- `/nlpm:fix` -- auto-fix mechanical issues (dispatches scorer)
- commands/trend.md -- `/nlpm:trend` -- track score history over time (dispatches scorer + vague-scanner)
- commands/test.md -- `/nlpm:test` -- run NL-TDD specs (dispatches tester)
- commands/init.md -- `/nlpm:init` -- configure project
- commands/shared/discover.md -- artifact discovery patterns (not user-invocable)
- commands/shared/classify.md -- artifact type classification (not user-invocable)

## Agents

- agents/scanner.md -- haiku, mechanical file discovery
- agents/scorer.md -- sonnet, 100-point quality scoring (skills: scoring, conventions)
- agents/checker.md -- sonnet, cross-component consistency (skills: conventions)
- agents/vague-scanner.md -- haiku, mechanical vague-word counting (no skills)
- agents/tester.md -- sonnet, evaluates artifacts against test specs (skills: testing, conventions, scoring)

## Skills

### Core (loaded by agents)
- skills/nlpm/conventions/ -- Claude Code schemas, hook events, naming patterns
- skills/nlpm/patterns/ -- NL programming patterns + anti-patterns (cross-referenced to rules)
- skills/nlpm/scoring/ -- penalty tables with rule number cross-references
- skills/nlpm/rules/ -- the 50 Rules of Natural Language Programming (R01-R50) -- single source of truth
- skills/nlpm/testing/ -- NL-TDD spec format, test patterns

### Writing Reference (loaded on demand)
- skills/nlpm/writing-skills/ -- how to write SKILL.md files
- skills/nlpm/writing-agents/ -- how to write agent definitions
- skills/nlpm/writing-rules/ -- how to write .claude/rules/ files
- skills/nlpm/writing-prompts/ -- universal prompt engineering guide
- skills/nlpm/writing-hooks/ -- how to write Claude Code hooks
- skills/nlpm/writing-plugins/ -- how to design and build plugins
- skills/nlpm/orchestration/ -- multi-agent workflow patterns

## Hooks

- hooks/hooks.json -- PostToolUse command hook on Write|Edit
- scripts/check-artifact.sh -- classifies written file, emits advisory only for NL artifacts

## Self-Tests

- .nlpm-test/ -- spec files for all 5 agents (dogfooding NL-TDD)

## Build & Run

No build step. Pure markdown plugin. Install with:
```
claude plugin install nlpm@xiaolai --scope project
```

Test by running `/nlpm:ls` on any project with NL artifacts.
Run `/nlpm:test` to verify agent specs pass.

## Prerequisites

None. No Python, Node.js, or compiled dependencies.

## Development

When modifying this plugin:
- Run `/nlpm:score ./` after changes to verify quality stays above 90
- Run `/nlpm:check` to verify cross-component references
- Run `/nlpm:test` to verify agent specs pass
- Bump version in plugin.json AND marketplace.json
- Push plugin repo, then update central marketplace

## Scoring

100-point scale. Start at 100, apply deterministic penalties.
Floor: 0. Ceiling: 100.
Threshold configurable via .claude/nlpm.local.md (default: 70).
Rule overrides supported (suppress, max_penalty, threshold adjustments).

## Auditor (Self-Evolution Pipeline)

The `auditor/` subdirectory contains a GitHub Actions pipeline that discovers, audits, and contributes to Claude Code plugin/skill repos across GitHub — then feeds learnings back into NLPM's rules.

### Workflows (.github/workflows/auditor-*.yml)

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| auditor-discover | Weekly cron / manual | Find repos with 500+ stars and 5+ NL artifacts |
| auditor-audit | Issue labeled `audit-ready` | Score artifacts via claude-code-action (triage + batched) |
| auditor-contribute | Issue labeled `contribute-approved` | Fork, PR for verified bugs only |
| auditor-track | Daily cron | Check PR merge status |
| auditor-case-study | Issue labeled `case-study-ready` | Write article, self-review, polish, cover image |
| auditor-daily-report | Daily cron | Pipeline state, rule frequency, rejection patterns |

### Data (auditor/)

| Path | Purpose |
|------|---------|
| auditor/registry/repos.json | Tracking database |
| auditor/feedback/log.json | Rule stats, PR outcomes — the self-evolution data |
| auditor/audits/ | Per-repo scoring reports |
| auditor/reports/ | Daily reports |
| auditor/logs/events.jsonl | Structured event log |

### The Loop

audit → contribute → track outcomes → feedback log → update NLPM rules → audit better
