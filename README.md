# nlpm

Natural-Language Programming Manager — discover, score, check, and fix NL artifacts with Claude-native intelligence.

Part of the [xiaolai Claude plugin marketplace](https://github.com/xiaolai/claude-plugin-marketplace).

## Table of Contents

- [What it does](#what-it-does)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
- [What it scores](#what-it-scores)
- [Scoring System](#scoring-system)
- [Penalty Reference](#penalty-reference)
- [Configuration](#configuration)
- [Continuous Enforcement](#continuous-enforcement)
- [Architecture](#architecture)
- [Roadmap](#roadmap)
- [Prerequisites](#prerequisites)

## What it does

NLPM treats natural language artifacts as **programs that can be linted**. Just as ESLint scores JavaScript and ruff scores Python, NLPM scores the markdown files that drive AI behavior: skills, agents, commands, rules, hooks, prompts, CLAUDE.md, and memory files.

Five commands, each doing one thing:

| Command | What it does |
|---------|-------------|
| `/nlpm:ls` | Discover and inventory all NL artifacts in a repo |
| `/nlpm:score` | Score artifact quality (100-point scale) |
| `/nlpm:check` | Cross-component consistency checks |
| `/nlpm:fix` | Auto-fix fixable issues |
| `/nlpm:init` | Initialize NLPM for a project |

Claude-native — no Codex, no external models, no API keys, no runtime dependencies.

## Installation

```bash
# Project scope (recommended)
claude plugin install nlpm@xiaolai --scope project

# Global (all projects)
claude plugin install nlpm@xiaolai --scope user
```

## Quick Start

```
/nlpm:ls                    # see what NL artifacts you have
/nlpm:score                 # score them all
/nlpm:score agents/         # score just agents
/nlpm:check                 # check cross-component consistency
/nlpm:fix                   # auto-fix what's fixable
```

Example output:

```
NLPM Score Report

File                              Type      Score   Issues
-------------------------------------------------------------
agents/parser.md                  agent     92/100  1 med
agents/summarizer.md              agent     73/100  1 high, 2 med
skills/core/SKILL.md              skill     78/100  1 high, 2 med
commands/process.md               command   95/100  1 low
.claude/rules/testing.md          rule      88/100  1 med
plugin.json                       manifest  100/100 --
CLAUDE.md                         config    82/100  2 med

Overall: 85/100 -- GOOD    [threshold: 70]
  High: 2 | Medium: 5 | Low: 1
  Below threshold: 0 files

Top issues:
  1. [HIGH] agents/summarizer.md:2 -- no <example> blocks (-15)
  2. [HIGH] skills/core/SKILL.md:3 -- description too generic (-15)
  3. [MED]  .claude/rules/testing.md:12 -- "properly" without criteria (-2)
```

## Commands

### /nlpm:ls

Discover and inventory all NL artifacts in a repo.

```
/nlpm:ls                          # scan current directory
/nlpm:ls ~/github/my-project/     # scan a specific repo
```

Discovers artifacts across 3 categories:

| Category | What it finds |
|----------|--------------|
| A: Plugin artifacts | commands, shared partials, agents, skills, hooks, plugin.json, .mcp.json, .lsp.json |
| B: Project config | CLAUDE.md (root + subdirectories), .claude/rules/, settings, user commands |
| F: Memory files | ~/.claude/projects/*/memory/*.md, MEMORY.md index |

Reports: file count, line count, estimated token cost (lines x 3.5).

### /nlpm:score

Score individual artifacts on a 100-point quality scale.

```
/nlpm:score                       # score all artifacts in cwd
/nlpm:score agents/               # score a directory
/nlpm:score skills/core/SKILL.md  # score a single file
```

Each file gets a deterministic score: start at 100, subtract penalties for issues found. Every penalty has a fixed point value — no subjective judgment on scoring, only on detection.

Score bands:

| Score | Band | Meaning |
|-------|------|---------|
| 90-100 | Excellent | Production-ready |
| 80-89 | Good | Minor gaps |
| 70-79 | Adequate | Meets threshold, should improve |
| 60-69 | Weak | Below threshold, significant issues |
| <60 | Rewrite | Fundamental problems |

Files scoring below the project threshold (default: 70) are flagged.

### /nlpm:check

Cross-component consistency checks. Requires 2+ artifacts.

```
/nlpm:check                       # check all artifacts in cwd
/nlpm:check ~/github/my-plugin/   # check a specific directory
```

Checks:

| Check | What it catches |
|-------|----------------|
| Reference integrity | Command references a shared partial that doesn't exist |
| Skill references | Agent lists a skill in frontmatter that isn't found |
| Script references | Hook references a script that doesn't exist |
| Orphaned components | Shared partial defined but never referenced by any command |
| Behavioral contradictions | Command says "always do X", a referenced partial says "never do X" |
| Terminology drift | Same concept called different names across artifacts |

### /nlpm:fix

Auto-fix mechanical issues. Scores before and after to show improvement.

```
/nlpm:fix                         # fix all artifacts in cwd
/nlpm:fix agents/reviewer.md      # fix a specific file
```

What it fixes automatically:
- Missing `user-invocable: false` on shared partials
- `tools` field where `allowed-tools` is expected
- Heading hierarchy gaps (## followed by #### with no ###)
- Trailing whitespace

What it reports but doesn't fix (requires human judgment):
- Vague descriptions
- Missing `<example>` blocks
- Model selection
- Behavioral contradictions

Shows score delta per file: `agents/reviewer.md  68 -> 93 (+25)`

### /nlpm:init

Configure NLPM for a project.

```
/nlpm:init
```

1. Scans for existing artifacts
2. Asks for strictness level (relaxed/standard/strict)
3. Writes `.claude/nlpm.local.md` config

## What it scores

NLPM scores 12 artifact types across 3 categories:

### Category A: Plugin Artifacts

| Artifact | File pattern | Penalties |
|----------|-------------|-----------|
| Commands | `commands/*.md` | 6 checks: description, argument-hint, numbered steps, empty input, output format, error paths |
| Shared partials | `commands/shared/*.md` | 2 checks: user-invocable false, purpose clear |
| Agents | `agents/*.md` | 8 checks: description, examples, model, model tier, tools, unused tools, output format, write-on-readonly |
| Skills | `skills/**/SKILL.md` | 6 checks: name, description, trigger quality, body length, code examples, scope note |
| Hooks | `hooks/*.json` | 4 checks: valid JSON, event names, case-correct, script existence |
| Plugin manifest | `.claude-plugin/plugin.json` | 3 checks: name, version semver, description |
| MCP config | `.mcp.json` | 2 checks: valid JSON, server command |

### Category B: Project Config

| Artifact | File pattern | Penalties |
|----------|-------------|-----------|
| CLAUDE.md | `**/CLAUDE.md` | 11 checks: existence, length, actionability, build commands, test commands, architecture, @imports, stale refs, actionability ratio, prerequisites, rule conflicts |
| Rules | `.claude/rules/*.md` | 7 checks: description, format, rationale, enforceability, budget, conflicts, tooling duplication |
| Settings | `.claude/settings*.json` | Discovered but not scored (v0.3) |

### Category F: Memory

| Artifact | File pattern | Penalties |
|----------|-------------|-----------|
| Memory files | `memory/*.md` | 7 checks: frontmatter, name, description, type, content-type match, MEMORY.md reference, staleness |

### All Types

| Check | Penalty |
|-------|---------|
| Vague quantifier ("appropriate", "relevant", "as needed", etc.) without criteria | -2 each, max -20 |

## Scoring System

### Formula

```
score = max(0, min(100, 100 + sum_of_penalties))
```

All penalties are negative. No bonuses. The assumption is that a well-formed artifact scores 100; quality is measured by what's missing or wrong.

### How detection works

Some checks are **deterministic** (field presence, JSON validity, line count) and always produce the same result. Others are **heuristic** (ambiguity detection, model appropriateness, "is this rule enforceable?") and labeled as such in the report.

Heuristic: the linter uses a simple test for "mechanical task" — if the agent body has <20 lines of instructions AND no judgment phrases ("evaluate", "decide", "judge", "assess quality", "determine if"), the task is mechanical and should use haiku.

### Calibration

The scoring skill includes 4 worked examples that anchor the linter's judgment:

| Example | Score | Why |
|---------|-------|-----|
| Excellent agent | 95 | 2 examples, correct model, specific tools, output format |
| Weak agent | 52 | No examples (-15), vague desc (-15), opus for simple (-5), too many tools (-10) |
| Excellent rule | 92 | Path-scoped, imperative + rationale, specific, testable |
| Weak rule | 40 | No frontmatter (-10), prohibition (-10), vague (-4), not testable (-10) |

## Penalty Reference

### Quick reference (most impactful)

| Penalty | Points | Applies to |
|---------|--------|-----------|
| Missing required frontmatter | -25 | commands, agents, skills, shared partials, hooks, manifests |
| No `<example>` blocks | -15 | agents |
| Generic description | -15 | skills |
| Conflicts with rules | -15 | CLAUDE.md |
| Cross-component contradiction | -15 | --check |
| No output format | -10 | commands, agents |
| No empty input handling | -10 | commands |
| No numbered steps | -10 | commands |
| Write/Edit on read-only agent | -10 | agents |
| Prohibition without alternative | -10 | rules |
| Rule not enforceable | -10 | rules |
| Stale file references | -10 | CLAUDE.md, memory |
| Invalid @import path | -10 | CLAUDE.md |
| No build/run command | -10 | CLAUDE.md |
| Broken cross-reference | -20 | --check |
| Rule conflicts with other rule | -20 | rules |
| Missing hook script | -20 | hooks |

### Full tables

See `skills/nlpm/scoring/SKILL.md` for complete penalty tables per artifact type.

## Configuration

### Project config

Create `.claude/nlpm.local.md` (or run `/nlpm:init`):

```markdown
---
strictness: standard
score_threshold: 70
---

When linting NL artifacts in this project, use **standard** strictness.
Flag artifacts scoring below **70/100** for improvement.
```

### Strictness levels

| Level | Threshold | Effect |
|-------|-----------|--------|
| Relaxed | 60 | Only flag seriously broken artifacts |
| Standard | 70 | Flag artifacts that need improvement |
| Strict | 80 | Flag anything below good quality |

## Continuous Enforcement

NLPM ships a `PostToolUse` hook that activates automatically when installed. When you write or edit a file that matches an NL artifact pattern (commands, agents, skills, rules, hooks, CLAUDE.md), Claude reminds you to run `/nlpm:score` on it.

This is advisory — it doesn't block writes. For blocking enforcement, use a `PreToolUse` hook with a custom script (see tdd-guardian for an example of blocking hooks).

## Architecture

```
commands/           User-facing commands
  ls.md             Discover artifacts
  score.md          Score quality
  check.md          Cross-component checks
  fix.md            Auto-fix issues
  init.md           Configure project
  shared/
    discover.md     Artifact path patterns (not user-invocable)
    classify.md     Type classification rules (not user-invocable)

agents/             Dispatched by commands
  scanner.md        haiku — fast artifact discovery
  linter.md         sonnet — judgment-based scoring

skills/nlpm/        Knowledge base
  conventions/      Claude Code schemas, hook events, naming patterns
  patterns/         NL programming best practices + anti-patterns
  scoring/          Penalty tables, calibration examples

hooks/
  hooks.json        PostToolUse advisory reminder
```

**Why sonnet for the linter?** Several checks require judgment — ambiguity detection, model appropriateness assessment, "is this rule enforceable?" These are heuristic assessments that haiku handles poorly. The linter labels heuristic findings explicitly so users know which assessments involved judgment.

**Why haiku for the scanner?** Discovery is mechanical: glob for file patterns, parse YAML frontmatter, count lines. No judgment needed.

## Roadmap

| Version | Status | What it adds |
|---------|--------|-------------|
| v0.1.0 | Shipped | ls, score (was lint), init |
| v0.2.0 | Current | check, fix, CLAUDE.md deep scoring, memory artifacts, lint-on-save hook |
| v0.3.0 | Planned | settings.json validation, hook command safety, expanded auto-fix |
| v0.4.0 | Planned | Trend tracking (.claude/nlpm-history.json), /nlpm:trend command |
| v0.5.0 | Planned | Cross-plugin scanning, ecosystem-wide duplicate detection |

## Prerequisites

None. Pure markdown plugin — no Python, no Node.js, no compiled dependencies.

## License

MIT
