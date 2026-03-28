# NLPM User Guide

A practical guide for getting started with NLPM -- the Natural-Language Programming Manager for Claude Code.

---

## Getting Started

### Install

From your project directory:

```bash
claude plugin install nlpm@xiaolai --scope project
```

### First steps

Once installed, three commands tell you everything about the state of your NL artifacts:

```
/nlpm:ls          # discover what NL artifacts you have
/nlpm:score       # score them all on a 100-point scale
/nlpm:fix         # auto-fix the mechanical issues
```

That is the entire onboarding loop. Run those three commands in order, read the report, and you will know exactly where your artifacts stand.

---

## Understanding Your Score

### What 100 means

A score of 100 means the artifact has no detectable issues: every required field is present, no vague language, correct model tier, examples included, output format defined, and no cross-reference problems. It does not mean "perfect prose" -- it means "nothing for the linter to penalize."

### What penalties look like

Scores start at 100 and go down. Every issue has a fixed penalty. Here is a realistic example of an agent dropping from 100 to 73:

```
agents/summarizer.md                agent     73/100

  -15  No <example> blocks (R09 requires minimum 2)
   -5  model not declared
   -5  "relevant" without criteria (vague quantifier, R01)
   -2  "as needed" without criteria (vague quantifier, R01)

  Total penalties: -27
```

The score is deterministic: same artifact, same penalties, same number. There is no subjective "feel" adjustment on scoring -- only on detection of borderline issues (which are labeled as heuristic in the report).

### Score bands

| Score | Band | What it means in practice |
|-------|------|--------------------------|
| 90-100 | Excellent | Ship it. Production-ready with no reservations. |
| 80-89 | Good | Solid work. One or two minor gaps that are safe to defer. |
| 70-79 | Adequate | Functional but has noticeable gaps. Improve before next release. |
| 60-69 | Weak | Below threshold. Significant issues that affect reliability. |
| <60 | Rewrite | Fundamental problems. Start over with the writing skills loaded. |

### Threshold system

The default pass threshold is **70**. Any file scoring below the threshold is flagged in the report. You can change the threshold in `.claude/nlpm.local.md`:

```markdown
---
strictness: strict
score_threshold: 80
---

When linting NL artifacts in this project, use **strict** strictness.
Flag artifacts scoring below **80/100** for improvement.
```

---

## The Six Commands

### 1. /nlpm:ls -- "What NL artifacts do I have?"

**Scenario:** You just cloned a plugin repo and want to understand what is in it before making changes.

```
/nlpm:ls
```

This scans the current directory and reports every NL artifact it finds: commands, agents, skills, rules, hooks, CLAUDE.md files, memory files, plugin manifests, MCP configs, and settings files. For each file it reports line count and estimated token cost (lines x 3.5).

Use it when you inherit a project, onboard to a new repo, or want a quick inventory before a release.

### 2. /nlpm:score -- "How good are my artifacts?"

**Scenario:** You are preparing a release and want to make sure quality is above threshold before pushing.

```
/nlpm:score                    # score everything
/nlpm:score agents/            # score just agents
/nlpm:score skills/core/SKILL.md   # score one file
```

Each file gets a deterministic score. The report shows the score, the issues found, and which rules were violated. High-severity issues are listed first so you know where to focus.

### 3. /nlpm:check -- "Is everything consistent?"

**Scenario:** You renamed a skill directory from `skills/nlpm/linting/` to `skills/nlpm/scoring/` and want to make sure nothing still references the old name.

```
/nlpm:check
```

This runs cross-component checks: broken references between commands and shared partials, agents listing skills that do not exist, hooks pointing to missing scripts, orphaned files that nothing references, and behavioral contradictions between rules. It requires at least 2 artifacts to have something to cross-check.

### 4. /nlpm:fix -- "Fix the mechanical stuff for me"

**Scenario:** Your shared partial is missing `user-invocable: false`, your heading hierarchy jumps from `##` to `####`, and a command that uses `$ARGUMENTS` has no `argument-hint`.

```
/nlpm:fix                       # fix all artifacts
/nlpm:fix agents/reviewer.md    # fix one file
```

The fix command handles mechanical issues automatically: missing frontmatter fields, heading gaps, trailing whitespace, field name mismatches (`tools` where `allowed-tools` is expected). For issues that need judgment (vague descriptions, model tier changes, skill splits), it shows suggestions with diffs and asks for your approval before applying.

Every fix shows a before/after score delta: `agents/reviewer.md  68 -> 93 (+25)`.

### 5. /nlpm:trend -- "Are things getting better or worse?"

**Scenario:** You have been improving your plugin over three weeks and want to see the trajectory, especially before a release.

```
/nlpm:trend
```

On first run, it asks you to create a baseline with `/nlpm:score`. On subsequent runs, it scores all artifacts, compares to previous snapshots stored in `.claude/nlpm-history.json`, and reports improvements, regressions, and unchanged files.

The trend line across snapshots shows the overall direction: `82 -> 87 -> 88 (improving)`. If one file regressed, it calls that out explicitly so you can investigate.

### 6. /nlpm:init -- "Set up NLPM for this project"

**Scenario:** You are starting a new plugin and want to configure quality standards before writing any artifacts.

```
/nlpm:init
```

This scans for existing artifacts, asks you to choose a strictness level (relaxed/standard/strict), and writes `.claude/nlpm.local.md` with your configuration. Run it once at project start and adjust later if needed.

---

## Working with Skills

NLPM ships with 11 skills organized into two groups.

### Core skills (loaded by the linter and scanner agents automatically)

| Skill | What it provides |
|-------|-----------------|
| conventions | Claude Code schemas, hook event names, field naming patterns |
| patterns | NL programming best practices and anti-patterns |
| scoring | Penalty tables, score bands, calibration examples |
| rules | The 50 Rules of Natural Language Programming (R01-R50) |

You never need to load these manually. When you run `/nlpm:score` or `/nlpm:check`, the linter agent loads the relevant core skills as reference knowledge.

### Writing skills (loaded on demand)

| Skill | When it loads |
|-------|--------------|
| writing-skills | When you are writing or improving a SKILL.md file |
| writing-agents | When you are writing or improving an agent definition |
| writing-rules | When you are writing or improving .claude/rules/ files |
| writing-prompts | When you need prompt engineering guidance |
| writing-hooks | When you are writing or improving hooks |
| writing-plugins | When you are designing or building a plugin |
| orchestration | When you need multi-agent workflow patterns |

These load automatically based on what you are doing. If you ask Claude to "write a new agent for dependency scanning," the writing-agents skill loads and guides the output. You do not need to invoke them explicitly.

### The Rules skill

The rules skill contains the 50 Rules of Natural Language Programming (R01-R50). These are the normative reference for what constitutes a well-formed NL artifact. See [RULES.md](RULES.md) for the full standalone reference.

---

## Configuration

### .claude/nlpm.local.md

This is the per-project config file. Create it with `/nlpm:init` or write it manually:

```markdown
---
strictness: standard
score_threshold: 70
---

When linting NL artifacts in this project, use **standard** strictness.
Flag artifacts scoring below **70/100** for improvement.
```

### Strictness levels

| Level | Threshold | What it catches |
|-------|-----------|----------------|
| Relaxed | 60 | Only seriously broken artifacts. Good for early-stage projects where you are still iterating on structure. |
| Standard | 70 | Artifacts that need improvement. The right default for most active projects. |
| Strict | 80 | Anything below good quality. Use for mature plugins where you want to maintain a high bar. |

---

## Tips

**Score early, score often.** Run `/nlpm:score` after writing any new artifact. It takes seconds and catches issues while the context is fresh.

**Use `/nlpm:trend` before releases.** The trend report catches regressions that individual scoring misses -- a file that was 90 last week and is 78 now because someone added vague language during a refactor.

**Do not chase 100.** A score of 85+ is excellent for most artifacts. The last 5-10 points often come from edge cases (a scope note you could add, an extra example block) that may not be worth the effort.

**The vague quantifier rule (R01) is the most common penalty.** Words like "appropriate", "relevant", "as needed", "properly", and "correctly" each cost -2 points. They add up fast. Replace them with measurable criteria: "files matching `src/**/*.ts`" instead of "relevant files."

**Auto-fix handles the mechanical stuff.** Missing `user-invocable: false`, heading hierarchy gaps, missing `argument-hint` -- these are fixed automatically. Focus your energy on the things that need human judgment: descriptions, examples, and scope notes.

**Positive framing over prohibitions (R03).** When writing rules, say "Use X" instead of "Don't use Y." The Pink Elephant effect means Claude sometimes fixates on prohibited things and does them anyway.

---

## Troubleshooting

### "Score seems too low"

Check which penalties hit in the report. Scoring is deterministic -- the same artifact always gets the same score. If a penalty seems wrong, check the penalty tables in the scoring skill. The most common surprise: vague quantifiers stacking up to -20 when the body has many instances of "appropriate", "relevant", etc.

### "Writing skill didn't load"

Skills load based on description triggers. If you expected writing-agents to load but it did not, try using keywords from the skill's description: "write an agent definition", "create a new agent", "improve the agent's examples." The more specific your request, the better Claude matches it to the right skill.

### "Check found orphans that aren't really orphans"

Writing skills are intentionally orphaned -- they are loaded on demand by Claude based on context, not referenced by any command or agent. The check command may flag them. This is expected behavior for on-demand skills.

### "Fix changed something I didn't want"

Auto-fixes only apply to mechanical issues (missing fields, heading gaps). Suggested fixes (model tier changes, example generation, skill splits) always show a diff and ask for your approval before applying. If an auto-fix was wrong, undo it with your editor and file an issue.

### "Trend shows no history"

The trend command needs at least one previous snapshot. Run `/nlpm:score` first to create the baseline, then run `/nlpm:trend` on subsequent scoring sessions.

---

## Further Reading

- [RULES.md](RULES.md) -- The 50 Rules as a standalone reference
- [EXAMPLES.md](EXAMPLES.md) -- Before/after examples showing NLPM improving real artifacts
- [README.md](README.md) -- Full technical reference with penalty tables and architecture
