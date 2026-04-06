# NLPM Audit: xiaolai/loc-guardian-for-claude
**Date**: 2026-04-06  |  **Artifacts**: 8  |  **Strategy**: single
**Score**: 89/100
**Bugs**: 3  |  **Quality Issues**: 8

## Score Summary
| File | Type | Score | Top Issue |
|------|------|-------|-----------|
| commands/scan.md | command | 70 | Missing `name` frontmatter (-25), missing `allowed-tools` (-5) |
| commands/init.md | command | 73 | Missing `name` frontmatter (-25) |
| .claude-plugin/plugin.json | plugin metadata | 85 | Missing `commands`/`agents` registration arrays (-15) |
| agents/optimizer.md | agent | 91 | Only 1 example (-5), vague terms (-4) |
| skills/loc-optimization/SKILL.md | skill | 96 | Vague "slight variations", "Long switch" (-4) |
| agents/counter.md | agent | 97 | Minor vague "concise" (-2), strong otherwise |
| skills/loc/SKILL.md | skill | 98 | Vague "lengthy explanations" (-2) |
| CLAUDE.md | documentation | 100 | Developer notes file — no structural issues |

## Bugs (PR-worthy)
| # | File | Issue | Impact |
|---|------|-------|--------|
| 1 | commands/scan.md | Missing `name` field in frontmatter | Command may not register correctly; plugin discovery relies on `name` |
| 2 | commands/init.md | Missing `name` field in frontmatter | Same registration risk as scan.md |
| 3 | .claude-plugin/plugin.json | No `commands` or `agents` registration arrays | Plugin installer cannot enumerate the plugin's artifacts; auto-discovery may fail |

## Quality Issues (informational)
| # | File | Issue | Penalty |
|---|------|-------|---------|
| 1 | commands/scan.md | No `allowed-tools` declared — dispatches agents but omits the `Agent` tool | -5 |
| 2 | agents/optimizer.md | Only 1 example block (2+ recommended) | -5 |
| 3 | agents/optimizer.md | "lighter analysis" (Step 3) is vague — what does lighter mean in practice? | -2 |
| 4 | agents/optimizer.md | "most obvious extraction candidate" — "obvious" is a vague quantifier | -2 |
| 5 | commands/init.md | "typically 1-2" files from Glob is an assumption, not an instruction | -2 |
| 6 | skills/loc-optimization/SKILL.md | "Copy-pasted blocks with slight variations" — "slight" is undefined | -2 |
| 7 | skills/loc-optimization/SKILL.md | "Long switch" — length threshold unspecified | -2 |
| 8 | skills/loc/SKILL.md | "no lengthy explanations" in Formatting Rules — "lengthy" is undefined | -2 |

## Cross-Component

**References check (all pass):**
- `commands/scan.md` → `loc-guardian:counter` and `loc-guardian:optimizer` — both agents exist ✓
- `agents/counter.md` → skill `loc-guardian:loc` — exists at `skills/loc/SKILL.md` ✓
- `agents/optimizer.md` → skill `loc-guardian:loc-optimization` — exists at `skills/loc-optimization/SKILL.md` ✓
- Config file `.claude/loc-guardian.local.md` referenced consistently across `CLAUDE.md`, `commands/init.md`, `agents/counter.md`, `agents/optimizer.md`, and `skills/loc-optimization/SKILL.md` ✓
- Verdict line format (`**VERDICT: N over limit, M warnings | limit: L**`) defined in `skills/loc/SKILL.md` and correctly consumed by `commands/scan.md` ✓
- `loc-data` block format defined in `skills/loc/SKILL.md` and correctly consumed by `agents/optimizer.md` ✓

**Skill separation is correct:** counter loads only `loc`, optimizer loads only `loc-optimization`. No cross-contamination.

**One observation:** `commands/scan.md` hardcodes `model: "opus"` in the optimizer dispatch. This overrides the `model: opus` already declared in `agents/optimizer.md` — redundant but not broken. The counter's `model: "haiku"` override in the dispatch is likewise redundant.

## Recommendation

**Submit PRs for bugs 1 and 2** (missing `name` fields in both commands). These are mechanical one-line fixes with no design ambiguity:

```yaml
# commands/scan.md — add to frontmatter:
name: scan

# commands/init.md — add to frontmatter:
name: init
```

**Bug 3 (plugin.json)** — verify against the actual Claude Code plugin schema before filing. If the schema requires `commands`/`agents` arrays, add them; if the plugin system auto-discovers from directory structure, this is not a bug.

**Quality issues** do not warrant PRs on their own. The two strongest candidates for a follow-up quality PR would be: adding a second example to `agents/optimizer.md` and adding `allowed-tools: [Agent]` to `commands/scan.md`. Both are low-risk and improve correctness.

Overall this is a well-architected plugin. The counter→scan→optimizer data-flow contract (verdict line + `loc-data` block) is clean and explicit. The skill separation is sound. The two command `name` omissions are the only structural issues worth filing.
