# NLPM Audit: xiaolai/loc-guardian-for-claude
**Date**: 2026-04-06  |  **Artifacts**: 8  |  **Strategy**: single
**Score**: 97/100
**Bugs**: 0  |  **Quality Issues**: 5

## Score Summary
| File | Type | Score | Top Issue |
|------|------|-------|-----------|
| agents/optimizer.md | agent | 91 | Single example; vague quantifiers "lighter", "obvious" |
| commands/scan.md | command | 95 | Missing `allowed-tools` declaration |
| CLAUDE.md | docs | 95 | No frontmatter (expected for docs; minor) |
| agents/counter.md | agent | 98 | Vague quantifier "concise" |
| commands/init.md | command | 98 | No issues of note |
| .claude-plugin/plugin.json | manifest | 100 | None |
| skills/loc-optimization/SKILL.md | skill | 100 | None |
| skills/loc/SKILL.md | skill | 100 | None |

## Bugs (PR-worthy)
None found. All cross-component references resolve correctly, no missing required frontmatter on agents or skills, no tools called outside declared tool lists.

| # | File | Issue | Impact |
|---|------|-------|--------|

## Quality Issues (informational)
| # | File | Issue | Penalty |
|---|------|-------|---------|
| 1 | commands/scan.md | Missing `allowed-tools` declaration — command dispatches agents but no tool list is declared, leaving access unconstrained | -5 |
| 2 | agents/optimizer.md | Only one example (and it omits a `user:` turn — shows only the assistant side, no triggering user message) | -5 |
| 3 | agents/optimizer.md | Vague quantifier "lighter analysis" in Step 3 — no criteria for what lighter means | -2 |
| 4 | agents/optimizer.md | Vague quantifier "most obvious extraction candidate" in Step 3 — no definition of obvious | -2 |
| 5 | agents/counter.md | Vague quantifier "Keep the output concise" in Rules — no guidance on what concise means | -2 |

## Cross-Component
All references check out:

- `commands/scan.md` dispatches `loc-guardian:counter` and `loc-guardian:optimizer` — both agents exist with matching `name` fields.
- `agents/counter.md` loads skill `loc-guardian:loc` — `skills/loc/SKILL.md` exists with `name: loc`.
- `agents/optimizer.md` loads skill `loc-guardian:loc-optimization` — `skills/loc-optimization/SKILL.md` exists with `name: loc-optimization`.
- `scan.md` passes model overrides (`haiku`, `opus`) that match the agents' declared models — no drift.
- `counter.md` references "mapping from your LOC skill", "test directories", and "artifact excludes" — all are defined explicitly in `skills/loc/SKILL.md`.
- `optimizer.md` references config file format (`.claude/loc-guardian.local.md`) — fully specified in `skills/loc-optimization/SKILL.md` and correctly created by `commands/init.md`.
- `CLAUDE.md` describes the two-agent pipeline and data flow accurately — matches the actual agent implementations.

No orphaned components, no broken references, no contradictions between CLAUDE.md description and actual artifact behavior.

## Recommendation
No PRs warranted. This plugin is well-built with near-perfect cross-component consistency. The five quality deductions are all minor:

- **scan.md missing `allowed-tools`**: Worth a one-line fix (`allowed-tools: Agent`) if the project follows strict command conventions, but functionally harmless since scan.md contains no direct tool calls.
- **optimizer.md single example**: Adding a second example showing the full input/output (including a proper `user:` turn) would improve agent reliability. Low-effort, moderate value.
- **Vague quantifiers**: All three instances ("lighter", "obvious", "concise") are in rules/guidance sections — substituting specific criteria (e.g., "one suggestion per WARN file" instead of "lighter analysis") would harden the agents against model interpretation variance.

Overall, loc-guardian-for-claude is a high-quality plugin. The architecture is clean, skill separation is deliberate and correct, data flow between counter and optimizer is well-specified, and all config/format contracts are consistently documented.
