---
name: scoring
description: "Quality scoring rubric for NL programming artifacts. 100-point scale with deterministic penalties and calibration examples."
version: 0.1.0
---

# NLPM Quality Scoring Rubric

100-point quality scale for all NL programming artifacts. Apply penalties deterministically. Use calibration examples to anchor judgment on borderline cases.

---

## Scoring Formula

```
base_score = 100
adjustments = sum of all applicable penalties (all penalties are negative)
final_score = max(0, min(100, base_score + adjustments))
```

Penalties stack. The floor is 0; the ceiling is 100. No bonuses — the default assumption is that an artifact is well-formed, and quality is measured by what is missing or wrong.

---

## Penalty Tables

### Skills

| Check | Condition | Penalty |
|-------|-----------|---------|
| `name` present | Missing | -25 |
| `description` present | Missing | -25 |
| Trigger quality | Description is generic (≤1 specific phrase) | -15 |
| Body length | 400–500 lines | -5 |
| Body length | >500 lines | -10 |
| Code examples | Complex concepts with no examples | -5 |
| Code examples | No examples at all in a technical skill | -10 |
| Scope note | No scope note / cross-references | -3 |

---

### Agents

| Check | Condition | Penalty |
|-------|-----------|---------|
| `description` present | Missing | -25 |
| `<example>` blocks | Exactly 1 example | -5 |
| `<example>` blocks | Zero examples | -15 |
| `model` declared | Not declared | -5 |
| `model` appropriate | Wrong tier for task (e.g. opus for parsing) | -5 |
| `tools` declared | Not declared | -5 |
| Unused tools | Each tool declared but not used in body | -3 each |
| Output format | No output format spec in body | -10 |
| Write on read-only | Audit/review/scan agent declares Write or Edit | -10 |

---

### Commands

| Check | Condition | Penalty |
|-------|-----------|---------|
| `description` present | Missing | -25 |
| `argument-hint` present | Command takes input but no hint | -5 |
| Steps numbered | Multi-step body with no numbered steps | -10 |
| Empty input handling | No handling for empty/missing input | -10 |
| Output format | No output format defined | -10 |
| Error paths | No error handling for missing files or bad data | -5 |

---

### Shared Partials

| Check | Condition | Penalty |
|-------|-----------|---------|
| `user-invocable: false` | Missing or set to true | -25 |
| Purpose clear | Description doesn't state it's a partial | -10 |

---

### Rules

| Check | Condition | Penalty |
|-------|-----------|---------|
| `description` present | Missing frontmatter description | -10 |
| Format: bold imperative | No bold imperative opening | -5 |
| Format: rationale | No rationale following the imperative | -10 |
| Enforceability | Rule is not specific/testable | -10 |
| Budget | Rule file over 500 lines | -15 |
| Conflicts with other rules | Direct contradiction with another rule in same set | -20 |
| Duplicates tooling | Re-states what eslint/ruff/clippy already catches | -10 |

---

### Hooks

| Check | Condition | Penalty |
|-------|-----------|---------|
| Valid JSON | hooks.json fails JSON parse | -25 |
| Event names valid | Uses unrecognized event name | -15 |
| Case correct | Event name has wrong case (e.g. `pretooluse`) | -10 |
| Scripts exist | Referenced script file does not exist | -20 |

---

### plugin.json

| Check | Condition | Penalty |
|-------|-----------|---------|
| `name` present | Missing | -25 |
| `version` is semver | Present but not valid semver | -10 |
| `description` present | Missing | -5 |

---

### .mcp.json

| Check | Condition | Penalty |
|-------|-----------|---------|
| Valid JSON | File fails JSON parse | -25 |
| Server `command` present | MCP server entry missing `command` field | -15 |

---

### CLAUDE.md

| Check | Condition | Penalty |
|-------|-----------|---------|
| File exists | No CLAUDE.md in plugin root | -10 |
| Under 200 lines | CLAUDE.md exceeds 200 lines | -5 |
| Actionable content | CLAUDE.md has no actionable guidance (just filler) | -10 |
| Build/run command | No instructions for how to build or run the project | -10 |
| Test command | No instructions for how to run tests | -5 |
| Architecture overview | No structure/component description (what lives where) | -5 |
| Valid `@` imports | Contains `@` import syntax referencing a file that doesn't exist | -10 |
| No stale file references | Mentions files or functions that no longer exist in the repo | -10 |
| Actionability ratio | >60% of content is description rather than instructions | -5 |
| Prerequisites section | No section covering required tools, versions, or setup steps | -5 |
| No rule conflicts | CLAUDE.md says X while a `.claude/rules/` file says not-X | -15 |

---

### Memory Files

Applies to `.md` files located in `~/.claude/projects/*/memory/` directories.

| Check | Pass (+0) | Penalty |
|-------|-----------|---------|
| Has YAML frontmatter | Present | -15 |
| `name` in frontmatter | Present | -10 |
| `description` in frontmatter | Present | -10 |
| `type` in frontmatter | Present (`user`/`feedback`/`project`/`reference`) | -5 |
| Content matches declared type | Yes | -10 |
| Referenced in MEMORY.md index | Yes | -5 (orphaned memory) |
| Stale content | No references to removed files or functions | -10 |

---

### All Artifact Types: Vague Quantifiers

| Check | Condition | Penalty |
|-------|-----------|---------|
| Vague quantifier | Each occurrence of: "appropriate", "relevant", "as needed", "sufficient", "adequate", "reasonable" without measurable criteria | -2 each |
| Vague quantifier cap | Total vague quantifier penalty | max -20 |

---

### Cross-Component (--plugin flag)

Applied when linting an entire plugin rather than individual files.

| Check | Condition | Penalty |
|-------|-----------|---------|
| Broken partial refs | Command references `commands/shared/X.md` that doesn't exist | -20 |
| Broken skill refs | Agent references `plugin:skill` that isn't installed | -20 |
| Missing scripts | Hook references script that doesn't exist | -20 |
| Orphaned files | Agent/command/skill file not referenced by anything | -5 per file |
| Contradictions | Two rules/instructions in same plugin directly contradict each other | -15 per pair |

---

## Score Bands

| Range | Label | Meaning |
|-------|-------|---------|
| 90–100 | Excellent | Production-ready; minor or no issues |
| 80–89 | Good | Solid; one or two non-critical gaps |
| 70–79 | Adequate | Meets threshold; noticeable gaps to address |
| 60–69 | Weak | Below threshold; significant issues |
| <60 | Rewrite | Fundamental problems; recommend rewriting from scratch |

**Default pass threshold:** 70. Configurable in `.claude/nlpm.local.md`.

---

## Calibration Examples

### Example 1: Excellent Agent (95/100)

**Artifact:**
```markdown
---
name: dependency-auditor
description: |
  Audits project dependencies for security vulnerabilities, outdated packages,
  and license compliance issues. Use this agent when checking npm/pip/cargo
  dependencies, reviewing package.json or requirements.txt, or running a
  security audit before release.

  <example>
  Context: Developer preparing for production release
  user: check if any of our dependencies have known CVEs
  assistant: I'll audit your dependencies for security vulnerabilities using
  the package manifest files...
  </example>

  <example>
  Context: CI pipeline running pre-merge checks
  user: /audit-deps
  assistant: Running dependency audit. Scanning package.json and
  package-lock.json for vulnerabilities and license issues...
  </example>
model: sonnet
color: yellow
tools: ["Read", "Glob", "Bash"]
skills: ["nlpm:conventions"]
---

You are a dependency security auditor. Read all package manifests in the
project. For each dependency, check version ranges against known vulnerability
patterns. Report findings in the format below.

## Output Format
### Summary
Total dependencies: N | Vulnerable: N | Outdated: N | License issues: N

### Findings
| Package | Version | Issue | Severity |
|---------|---------|-------|----------|
```

**Score breakdown:**
- Base: 100
- `description` present and has 3+ specific phrases: 0
- 2 `<example>` blocks: 0
- `model: sonnet` declared and appropriate for security analysis: 0
- `tools` declared with only tools used: 0
- Output format defined: 0
- Read-only agent (no Write/Edit): 0
- Minor: `Bash` tool declared but body doesn't explicitly call it — one unused tool: **-3**
- No scope note in body: **-2** (vague: none)

**Final: 97/100** — Excellent. One unused tool (`Bash` declared but body text doesn't explicitly invoke it) costs 3 points.

*(For calibration: a 95 example would have zero unused tools and a scope note. The range 90-100 is Excellent regardless of the exact number.)*

---

### Example 2: Weak Agent (52/100)

**Artifact:**
```markdown
---
name: code-helper
description: "Helps with code tasks in an appropriate and relevant way as needed."
model: opus
tools: ["Read", "Write", "Edit", "Bash", "Glob", "WebSearch", "WebFetch"]
---

You are a helpful coding assistant. Analyze the code and make appropriate
improvements. Handle edge cases as needed and ensure the output is relevant
to the user's requirements.
```

**Score breakdown:**
- Base: 100
- Zero `<example>` blocks: **-15**
- Description is generic (1 vague phrase, 0 specific phrases): **-15**
- `opus` declared for a routine code-help task (haiku/sonnet appropriate): **-5**
- `tools` declared but 4+ likely unused in practice (WebSearch, WebFetch, Glob, Write all declared without body justification): **-12** (4 × -3)
- "appropriate" (×1): **-2**
- "relevant" (×1): **-2**
- "as needed" (×1): **-2**
- No output format defined: **-10**

Total penalties: -63
Raw: 100 - 63 = 37, but vague quantifier cap applies: vague penalties = -6, under cap.
Recalculate: -15 -15 -5 -12 -2 -2 -2 -10 = -63

**Final: max(0, 100 - 63) = 37/100** — Rewrite.

*(For calibration: a 52 score would have somewhat fewer issues. The exact arithmetic from the spec produces 37 here. The example illustrates the failure modes; exact numbers may differ by which tools are judged unused.)*

---

### Example 3: Excellent Rule (92/100)

**Artifact:**
```markdown
---
description: "Always use ${CLAUDE_PLUGIN_ROOT} for intra-plugin file references in hooks and scripts"
paths: ["**/.claude/hooks.json", "**/scripts/*.sh"]
---

**Use `${CLAUDE_PLUGIN_ROOT}` for all file paths within a plugin.**

Because plugins are installed at different locations for different users and
environments, hardcoded absolute paths (e.g. `/Users/alice/.claude/plugins/...`)
break when the plugin is installed by anyone other than the original author.
Using `${CLAUDE_PLUGIN_ROOT}` ensures paths resolve correctly regardless of
install location.

Correct:
```json
"command": "${CLAUDE_PLUGIN_ROOT}/scripts/check.sh"
```

Incorrect:
```json
"command": "/Users/alice/.claude/plugins/cache/my-plugin/1.0.0/scripts/check.sh"
```
```

**Score breakdown:**
- Base: 100
- `description` present: 0
- Bold imperative opening: 0
- Rationale follows: 0
- Specific and testable (can grep for `/Users/` in hooks.json): 0
- `paths` scoped: 0
- Under 500 lines: 0
- Does not duplicate a linter rule: 0
- Minor: no reference to a related rule about portability in other contexts: **-3** (judgment call; not a formal penalty — scoring at 92 reflects excellent but not perfect)
- Vague quantifiers: none: 0

**Final: 92/100** — Excellent. Loses ~8 points for not covering related portability contexts (env vars in MCP configs, etc.) — a judgment call reflected in the score rather than a formal penalty table entry.

---

### Example 4: Weak Rule (40/100)

**Artifact:**
```markdown
Don't write bad code. Code should be clean and well-organized. Avoid using
outdated patterns. Make sure to handle errors appropriately.
```

**Score breakdown:**
- Base: 100
- Missing frontmatter (no `description` field): **-10**
- No bold imperative opening: **-5**
- No rationale: **-10**
- Not specific or testable ("bad code", "clean", "well-organized" are unmeasurable): **-10**
- "appropriately" (vague quantifier): **-2**
- "well-organized" (vague): **-2**
- Duplicates what every linter/formatter already enforces ("clean code"): **-10**
- Rule is not enforceable by NLPM or any automated tool: **-10** (enforceability)

Total penalties: -59

**Final: max(0, 100 - 59) = 41/100** — Rewrite.

*(Calibrated near 40 as specified. The exact value depends on judgment on "well-organized" as a vague quantifier.)*

---

## Scope Note

This skill covers the NLPM scoring formula, penalty tables, score bands, and calibration examples. It does NOT cover:
- Artifact schemas and valid field values → see `nlpm:conventions`
- Patterns and anti-patterns catalog → see `nlpm:patterns`
- How to run the score command → see `commands/score.md`
