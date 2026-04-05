# nlpm

Natural-Language Programming Manager -- discover, score, check, and fix NL artifacts with Claude-native intelligence.

Part of the [xiaolai Claude plugin marketplace](https://github.com/xiaolai/claude-plugin-marketplace).

## What it does

NLPM treats natural language artifacts as **programs that can be linted**. Just as ESLint scores JavaScript and ruff scores Python, NLPM scores the markdown files that drive AI behavior: skills, agents, commands, rules, hooks, prompts, CLAUDE.md, and memory files.

Seven commands, each doing one thing:

| Command | What it does |
|---------|-------------|
| `/nlpm:ls` | Discover and inventory all NL artifacts in a repo |
| `/nlpm:score` | Score artifact quality (100-point scale) |
| `/nlpm:check` | Cross-component consistency checks |
| `/nlpm:fix` | Auto-fix fixable issues |
| `/nlpm:trend` | Track quality score trends over time |
| `/nlpm:test` | Run NL artifact tests against spec files (TDD) |
| `/nlpm:init` | Initialize NLPM for a project |

Claude-native -- no Codex, no external models, no API keys, no runtime dependencies.

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
/nlpm:score --changed       # score only git-changed files
/nlpm:check                 # check cross-component consistency
/nlpm:fix                   # auto-fix what's fixable
/nlpm:trend                 # track score history over time
/nlpm:test                  # run NL-TDD specs
```

## Scoring System

Scores start at 100 and go down. Every issue has a fixed penalty. The score is deterministic: same artifact, same penalties, same number.

| Score | Band | Meaning |
|-------|------|---------|
| 90-100 | Excellent | Production-ready |
| 80-89 | Good | Minor gaps |
| 70-79 | Adequate | Meets threshold, should improve |
| 60-69 | Weak | Below threshold |
| <60 | Rewrite | Fundamental problems |

Default pass threshold: 70. Configure in `.claude/nlpm.local.md`.

See `skills/nlpm/scoring/SKILL.md` for the full penalty tables. See `skills/nlpm/rules/SKILL.md` for the 50 Rules of Natural Language Programming.

## What it scores

13 artifact types across 3 categories:

| Category | Artifacts |
|----------|-----------|
| A: Plugin | commands, shared partials, agents, skills, hooks, plugin.json, .mcp.json |
| B: Project | CLAUDE.md, .claude/rules/, settings files |
| F: Memory | ~/.claude/projects/*/memory/*.md |

## NL-TDD

Write test specs BEFORE writing artifacts:

```
1. Write spec:    .nlpm-test/my-agent.spec.md
2. /nlpm:test     -> RED (artifact doesn't exist)
3. Write artifact: agents/my-agent.md
4. /nlpm:test     -> check trigger accuracy, output format, score
5. /nlpm:score    -> verify quality score
6. Iterate        -> fix until GREEN
```

See `skills/nlpm/testing/SKILL.md` for the full spec format.

## Configuration

Create `.claude/nlpm.local.md` (or run `/nlpm:init`):

```yaml
---
strictness: standard
score_threshold: 70
rule_overrides:
  R09: { min_examples: 1 }      # require only 1 example block
  R05: { threshold: 600 }       # allow skills up to 600 lines
  R23: { budget: 800 }          # increase rules budget
---
```

| Level | Threshold | Effect |
|-------|-----------|--------|
| Relaxed | 60 | Only flag seriously broken artifacts |
| Standard | 70 | Flag artifacts that need improvement |
| Strict | 80 | Flag anything below good quality |

## Continuous Enforcement

NLPM ships a `PostToolUse` hook that fires when you write or edit files. A shell script (`scripts/check-artifact.sh`) classifies the file -- if it's an NL artifact, Claude reminds you to run `/nlpm:score`. Non-NL files produce no output.

This is advisory -- it does not block writes. For blocking enforcement, use a `PreToolUse` hook (see tdd-guardian for an example).

## Architecture

```
commands/           User-facing commands (7 + 2 shared partials)
  ls.md             Discover artifacts -> dispatches scanner
  score.md          Score quality -> dispatches scorer + vague-scanner in parallel
  check.md          Cross-component checks -> dispatches checker
  fix.md            Auto-fix issues -> dispatches scorer
  trend.md          Track score history -> dispatches scorer + vague-scanner
  test.md           Run NL-TDD specs -> dispatches tester
  init.md           Configure project
  shared/
    discover.md     Artifact path patterns (not user-invocable)
    classify.md     Type classification rules (not user-invocable)

agents/             Dispatched by commands (5 agents)
  scanner.md        haiku -- fast artifact discovery
  scorer.md         sonnet -- 100-point quality scoring
  checker.md        sonnet -- cross-component consistency
  vague-scanner.md  haiku -- mechanical vague-word counting
  tester.md         sonnet -- evaluates artifacts against test specs

skills/nlpm/        Knowledge base (12 skills)

  Core (loaded by agents):
  conventions/      Claude Code schemas, hook events, naming patterns
  patterns/         NL programming best practices + anti-patterns
  scoring/          Penalty tables with rule number cross-references
  rules/            The 50 Rules of Natural Language Programming (R01-R50)
  testing/          NL-TDD spec format, test patterns

  Writing Reference (loaded on demand):
  writing-skills/   How to write SKILL.md files
  writing-agents/   How to write agent definitions
  writing-rules/    How to write .claude/rules/ files
  writing-prompts/  Universal prompt engineering guide
  writing-hooks/    How to write Claude Code hooks
  writing-plugins/  How to design and build plugins
  orchestration/    Multi-agent workflow patterns

hooks/
  hooks.json        PostToolUse advisory (command type + check-artifact.sh)

scripts/
  check-artifact.sh NL artifact classifier for the PostToolUse hook

.nlpm-test/         Self-test specs (dogfooding NL-TDD)
```

## Tips

- **Score early, score often.** Run `/nlpm:score` after writing any new artifact.
- **Use `--changed` for speed.** `score --changed` only scores git-modified files.
- **Use `/nlpm:trend` before releases.** Catches regressions that individual scoring misses.
- **Do not chase 100.** 85+ is excellent. The last 5-10 points are diminishing returns.
- **R01 is the most common penalty.** "appropriate", "relevant", "as needed" each cost -2. Replace with measurable criteria.
- **Auto-fix handles the mechanical stuff.** Focus your energy on descriptions, examples, and scope notes.

## Troubleshooting

**"Score seems too low"** -- Check which penalties hit. Scoring is deterministic. Vague quantifiers stack up fast.

**"Writing skill didn't load"** -- Use keywords from the skill's description: "write an agent definition", "create a new agent".

**"Check found orphans that aren't really orphans"** -- Writing skills are on-demand (loaded by Claude, not referenced by agents). This is expected.

**"Trend shows no history"** -- Run `/nlpm:score` first to create the baseline snapshot.

## Roadmap

| Version | Status | What it adds |
|---------|--------|-------------|
| v0.1.0 | Shipped | ls, score, init |
| v0.2.0 | Shipped | check, fix, CLAUDE.md deep scoring, memory artifacts |
| v0.3.0 | Shipped | settings.json validation, hook command safety |
| v0.4.0 | Shipped | Trend tracking, /nlpm:trend command |
| v0.5.0 | Shipped | NL-TDD: /nlpm:test, tester agent, testing skill |
| v0.6.0 | Shipped | Expanded auto-fix, cross-plugin prep |
| v0.7.0 | Current | Agent split (scorer/checker/vague-scanner), working hooks, self-test specs, git-aware scoring, rule overrides, deduplication |

## Prerequisites

None. Pure markdown plugin -- no Python, no Node.js, no compiled dependencies.

## License

MIT
