# NLPM Audit: anthropics/claude-plugins-official
**Date**: 2026-04-06  |  **Artifacts**: 103  |  **Strategy**: progressive
**NL Score**: 96/100
**Security**: REVIEW
**Bugs**: 4  |  **Quality Issues**: 16  |  **Security Findings**: 7

## NL Score Summary

| File | Type | Score | Top Issue |
|------|------|-------|-----------|
| plugins/skill-creator/skills/skill-creator/agents/grader.md | agent | 30 | No YAML frontmatter — name, description, model, examples all missing |
| plugins/skill-creator/skills/skill-creator/agents/analyzer.md | agent | 30 | No YAML frontmatter — name, description, model, examples all missing |
| plugins/skill-creator/skills/skill-creator/agents/comparator.md | agent | 30 | No YAML frontmatter — name, description, model, examples all missing |
| plugins/code-simplifier/agents/code-simplifier.md | agent | 75 | No examples in description (-15), no output format section (-10) |
| plugins/agent-sdk-dev/agents/agent-sdk-verifier-ts.md | agent | 85 | No example blocks in description (-15) |
| plugins/agent-sdk-dev/agents/agent-sdk-verifier-py.md | agent | 85 | No example blocks in description (-15) |
| plugins/feature-dev/agents/code-architect.md | agent | 85 | One-sentence description, no examples (-15) |
| plugins/feature-dev/agents/code-reviewer.md | agent | 85 | One-sentence description, no examples (-15) |
| plugins/feature-dev/agents/code-explorer.md | agent | 85 | One-sentence description, no examples (-15) |
| plugins/hookify/hooks/hooks.json | hook | 90 | No matchers on any event — triggers on all tool calls (low) |
| plugins/plugin-dev/agents/agent-creator.md | agent | 91 | Trailing junk text appended (quality); vague "appropriate" |
| plugins/plugin-dev/agents/plugin-validator.md | agent | 93 | Trailing stale conversation text appended after closing ``` |
| plugins/plugin-dev/agents/skill-reviewer.md | agent | 93 | Trailing stale conversation text appended |
| plugins/pr-review-toolkit/agents/type-design-analyzer.md | agent | 94 | Invalid color value 'pink' (not in allowed set) |
| plugins/code-review/commands/code-review.md | command | 95 | No empty input handling (no argument-hint for PR number) |
| plugins/ralph-loop/commands/help.md | command | 95 | Missing allowed-tools |
| plugins/agent-sdk-dev/commands/new-sdk-app.md | command | 95 | Missing allowed-tools |
| plugins/feature-dev/commands/feature-dev.md | command | 95 | Missing allowed-tools |
| plugins/commit-commands/commands/clean_gone.md | command | 95 | Missing allowed-tools |
| plugins/frontend-design/skills/frontend-design/SKILL.md | skill | 95 | Description uses "Use this skill when" (second-person trigger, not third-person) |
| plugins/pr-review-toolkit/agents/comment-analyzer.md | agent | 96 | Vague "sufficient", "appropriate" (-4) |
| plugins/pr-review-toolkit/agents/silent-failure-hunter.md | agent | 96 | Vague "appropriate" x2 (-4) |
| plugins/pr-review-toolkit/agents/pr-test-analyzer.md | agent | 96 | Vague "adequate", "appropriate" (-4) |
| plugins/pr-review-toolkit/agents/code-simplifier.md | agent | 88 | No output format section (-10); vague "significant" (-2) |
| plugins/hookify/commands/hookify.md | command | 98 | Vague "appropriate" (-2) |
| plugins/plugin-dev/commands/create-plugin.md | command | 98 | Vague "appropriate" (-2) |
| plugins/pr-review-toolkit/commands/review-pr.md | command | 98 | Vague "applicable" (-2) |
| plugins/hookify/agents/conversation-analyzer.md | agent | 98 | Minor: vague "relevant" (-2) |
| plugins/pr-review-toolkit/agents/code-reviewer.md | agent | 98 | Vague "significant" (-2) |
| plugins/hookify/commands/list.md | command | 100 | None |
| plugins/hookify/commands/configure.md | command | 100 | None |
| plugins/hookify/commands/help.md | command | 100 | None |
| plugins/ralph-loop/commands/cancel-ralph.md | command | 100 | None |
| plugins/ralph-loop/commands/ralph-loop.md | command | 100 | None |
| plugins/claude-md-management/commands/revise-claude-md.md | command | 100 | None |
| plugins/commit-commands/commands/commit.md | command | 100 | None |
| plugins/commit-commands/commands/commit-push-pr.md | command | 100 | None |
| plugins/example-plugin/commands/example-command.md | command | 100 | None |
| external_plugins/imessage/skills/access/SKILL.md | skill | 100 | None |
| external_plugins/imessage/skills/configure/SKILL.md | skill | 100 | None |
| external_plugins/discord/skills/access/SKILL.md | skill | 100 | None |
| external_plugins/discord/skills/configure/SKILL.md | skill | 100 | None |
| external_plugins/telegram/skills/access/SKILL.md | skill | 100 | None |
| external_plugins/telegram/skills/configure/SKILL.md | skill | 100 | None |
| plugins/plugin-dev/skills/plugin-settings/SKILL.md | skill | 100 | None |
| plugins/plugin-dev/skills/agent-development/SKILL.md | skill | 100 | None |
| plugins/plugin-dev/skills/mcp-integration/SKILL.md | skill | 100 | None |
| plugins/plugin-dev/skills/command-development/SKILL.md | skill | 100 | None |
| plugins/plugin-dev/skills/plugin-structure/SKILL.md | skill | 100 | None |
| plugins/plugin-dev/skills/hook-development/SKILL.md | skill | 100 | None |
| plugins/plugin-dev/skills/skill-development/SKILL.md | skill | 100 | None |
| plugins/skill-creator/skills/skill-creator/SKILL.md | skill | 100 | None |
| plugins/hookify/skills/writing-rules/SKILL.md | skill | 100 | None |
| plugins/math-olympiad/skills/math-olympiad/SKILL.md | skill | 100 | None |
| plugins/claude-md-management/skills/claude-md-improver/SKILL.md | skill | 100 | None |
| plugins/claude-code-setup/skills/claude-automation-recommender/SKILL.md | skill | 100 | None |
| plugins/mcp-server-dev/skills/build-mcp-server/SKILL.md | skill | 100 | None |
| plugins/mcp-server-dev/skills/build-mcp-app/SKILL.md | skill | 100 | None |
| plugins/mcp-server-dev/skills/build-mcpb/SKILL.md | skill | 100 | None |
| plugins/playground/skills/playground/SKILL.md | skill | 100 | None |
| plugins/example-plugin/skills/example-skill/SKILL.md | skill | 100 | None |
| plugins/example-plugin/skills/example-command/SKILL.md | skill | 100 | None |
| plugins/learning-output-style/hooks/hooks.json | hook | 100 | None |
| plugins/security-guidance/hooks/hooks.json | hook | 100 | None |
| plugins/ralph-loop/hooks/hooks.json | hook | 100 | None |
| plugins/explanatory-output-style/hooks/hooks.json | hook | 100 | None |
| external_plugins/serena/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/context7/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/slack/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/imessage/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/fakechat/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/laravel-boost/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/discord/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/terraform/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/gitlab/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/greptile/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/asana/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/playwright/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/firebase/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/linear/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/telegram/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/supabase/.claude-plugin/plugin.json | manifest | 100 | None |
| external_plugins/github/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/learning-output-style/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/plugin-dev/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/skill-creator/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/pr-review-toolkit/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/hookify/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/math-olympiad/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/code-review/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/security-guidance/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/ralph-loop/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/explanatory-output-style/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/agent-sdk-dev/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/frontend-design/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/claude-md-management/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/claude-code-setup/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/feature-dev/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/mcp-server-dev/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/playground/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/commit-commands/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/example-plugin/.claude-plugin/plugin.json | manifest | 100 | None |
| plugins/code-simplifier/.claude-plugin/plugin.json | manifest | 100 | None |

**Score computation**: agents 80.7 avg (19) + commands 98.2 avg (17) + skills 99.8 avg (25) + hooks 98.0 avg (5) + manifests 100.0 avg (37) = weighted total 9887/103 = **96/100**.

## Security Scan

| Severity | Count |
|----------|-------|
| Critical | 0 |
| High | 0 |
| Medium | 4 |
| Low | 3 |

### Execution Surface Inventory

| Surface | Files |
|---------|-------|
| Hook JSON configs | plugins/learning-output-style/hooks/hooks.json, plugins/hookify/hooks/hooks.json, plugins/security-guidance/hooks/hooks.json, plugins/ralph-loop/hooks/hooks.json, plugins/explanatory-output-style/hooks/hooks.json |
| Hook scripts (Python) | plugins/hookify/hooks/pretooluse.py, posttooluse.py, stop.py, userpromptsubmit.py; plugins/security-guidance/hooks/security_reminder_hook.py |
| Hook scripts (Bash) | plugins/ralph-loop/hooks/stop-hook.sh |
| Plugin scripts (Bash) | plugins/plugin-dev/skills/*/scripts/*.sh (6 scripts), plugins/math-olympiad/skills/math-olympiad/scripts/*.sh (2), plugins/ralph-loop/scripts/setup-ralph-loop.sh |
| Plugin scripts (Python) | plugins/skill-creator/skills/skill-creator/scripts/*.py (8 scripts) |
| CI scripts (TypeScript) | .github/scripts/check-marketplace-sorted.ts, validate-frontmatter.ts, validate-marketplace.ts |
| MCP configs (.mcp.json) | 18 files across external_plugins/* and plugins/example-plugin/ |
| Package manifests | external_plugins/discord/package.json, external_plugins/telegram/package.json, external_plugins/imessage/package.json, external_plugins/fakechat/package.json |

### Security Findings

| # | Severity | File | Line | Pattern | Description |
|---|----------|------|------|---------|-------------|
| 1 | Medium | external_plugins/discord/package.json | 8 | Runtime `bun install` in start script | `"start": "bun install --no-summary && bun server.ts"` — installs dependencies at server startup using `^`-prefixed (unpinned minor) versions, creating supply-chain exposure on every MCP server launch |
| 2 | Medium | external_plugins/telegram/package.json | 8 | Runtime `bun install` in start script | Same pattern as discord — runtime install of unpinned packages each start |
| 3 | Medium | external_plugins/imessage/package.json | 8 | Runtime `bun install` in start script | Same pattern |
| 4 | Medium | external_plugins/fakechat/package.json | 8 | Runtime `bun install` in start script | Same pattern |
| 5 | Low | plugins/security-guidance/hooks/security_reminder_hook.py | 14 | Debug log to world-readable `/tmp` | `DEBUG_LOG_FILE = "/tmp/security-warnings-log.txt"` — appends session events to a globally readable path; could leak hook trigger context to other local users |
| 6 | Low | plugins/security-guidance/hooks/security_reminder_hook.py | 129 | File writes outside repo to `~/.claude/` | `get_state_file()` writes session state to `~/.claude/security_warnings_state_<session_id>.json`; files accumulate and are never cleaned up |
| 7 | Low | plugins/hookify/hooks/hooks.json | 1 | Verbose hook triggering — no matchers | PreToolUse, PostToolUse, Stop, and UserPromptSubmit all fire on every tool use with no `matcher` field, adding latency overhead for every operation in sessions with this plugin enabled |

## Bugs (PR-worthy)

| # | File | Issue | Impact |
|---|------|-------|--------|
| 1 | plugins/skill-creator/skills/skill-creator/agents/grader.md | No YAML frontmatter — name, description, model all absent | Claude Code cannot register this as an agent; it will be silently ignored by auto-discovery; skill-creator's grading workflow fails |
| 2 | plugins/skill-creator/skills/skill-creator/agents/analyzer.md | No YAML frontmatter | Same — post-hoc analysis workflow broken |
| 3 | plugins/skill-creator/skills/skill-creator/agents/comparator.md | No YAML frontmatter | Same — blind comparison workflow broken |
| 4 | plugins/pr-review-toolkit/agents/type-design-analyzer.md | `color: pink` is not in the allowed set (blue, cyan, green, yellow, magenta, red) | Registration may fail or display incorrectly depending on host validation |

## Security Fixes (PR-worthy, Medium/Low only)

| # | File | Issue | Suggested Fix |
|---|------|-------|---------------|
| 1 | external_plugins/discord/package.json (and telegram, imessage, fakechat) | `bun install` runs at MCP server startup using `^`-version deps | Pin all dependency versions exactly (remove `^`) and pre-install at publish time; or generate a `bun.lock` and use `bun install --frozen-lockfile` to prevent silent upgrades |
| 2 | plugins/security-guidance/hooks/security_reminder_hook.py | Debug log writes to world-readable `/tmp/security-warnings-log.txt` | Use `tempfile.mkstemp()` with mode 0o600 or disable debug logging in production; add a cleanup routine for stale `~/.claude/security_warnings_state_*` files |
| 3 | plugins/hookify/hooks/hooks.json | No matchers — all 4 hooks fire on every tool use/prompt | Add `"matcher": "Edit|Write|MultiEdit"` for file-operation hooks; restrict UserPromptSubmit and Stop hooks with appropriate matchers to reduce overhead |

## Quality Issues (informational)

| # | File | Issue | Penalty |
|---|------|-------|---------|
| 1 | plugins/plugin-dev/agents/plugin-validator.md | Stale conversation text appended after closing ``` on line 182: "Excellent work! The agent-development skill is now complete…" leaked from a prior session | -5 |
| 2 | plugins/plugin-dev/agents/skill-reviewer.md | Trailing stale text: "This agent helps users create high-quality skills…" appended after closing ``` | -5 |
| 3 | plugins/plugin-dev/agents/agent-creator.md | Trailing stale text: "This agent automates agent creation…" appended after closing ``` | -5 |
| 4 | plugins/pr-review-toolkit/agents/code-simplifier.md | No output format section — "document only significant changes" is not a structured format; vague "significant" | -12 |
| 5 | plugins/code-simplifier/agents/code-simplifier.md | Zero example blocks in description (-15); no output format section (-10) | -25 |
| 6 | plugins/agent-sdk-dev/agents/agent-sdk-verifier-ts.md | Description has no `<example>` blocks; agent-triggering relies entirely on text phrasing | -15 |
| 7 | plugins/agent-sdk-dev/agents/agent-sdk-verifier-py.md | Same — no example blocks | -15 |
| 8 | plugins/feature-dev/agents/code-architect.md | One-sentence description, no examples; triggering accuracy will be low | -15 |
| 9 | plugins/feature-dev/agents/code-reviewer.md | One-sentence description, no examples | -15 |
| 10 | plugins/feature-dev/agents/code-explorer.md | One-sentence description, no examples | -15 |
| 11 | plugins/ralph-loop/commands/help.md | No `allowed-tools` frontmatter field | -5 |
| 12 | plugins/agent-sdk-dev/commands/new-sdk-app.md | No `allowed-tools` — command uses WebFetch, Bash, Write, etc. without pre-approval | -5 |
| 13 | plugins/feature-dev/commands/feature-dev.md | No `allowed-tools` | -5 |
| 14 | plugins/commit-commands/commands/clean_gone.md | No `allowed-tools` despite executing Bash git commands | -5 |
| 15 | plugins/frontend-design/skills/frontend-design/SKILL.md | Description uses second-person trigger "Use this skill when the user asks…" instead of required third-person "This skill should be used when…" | -5 |
| 16 | plugins/hookify/hooks/hooks.json | Missing `matcher` fields on all 4 hook events causes every hook to fire on all tool calls and prompts | -10 |

## Cross-Component

**Broken internal references (agent files without frontmatter):**
The `plugins/skill-creator/skills/skill-creator/SKILL.md` references `agents/grader.md`, `agents/comparator.md`, and `agents/analyzer.md` (e.g., "Read `agents/grader.md` when you need to spawn the relevant subagent"). These are called by name in skill-creator's orchestration logic. Because the three agent files have no frontmatter, they cannot auto-register. The SKILL.md's spawning instructions will still work (it can pass the file content as a prompt to a general-purpose agent), but any platform-level auto-discovery of these as named agents fails. Fix: add minimal frontmatter to each.

**Duplicate code-simplifier agents:**
`plugins/pr-review-toolkit/agents/code-simplifier.md` and `plugins/code-simplifier/agents/code-simplifier.md` both declare `name: code-simplifier` with nearly identical content (the pr-review-toolkit version has richer examples and more prescriptive standards). If both plugins are installed simultaneously, the second registration will shadow or conflict with the first. The standalone `code-simplifier` plugin's agent is the weaker version (no examples, no output format). The pr-review-toolkit version should be considered authoritative.

**Duplicate code-reviewer agents:**
`plugins/pr-review-toolkit/agents/code-reviewer.md` and `plugins/feature-dev/agents/code-reviewer.md` both declare `name: code-reviewer`. Same shadowing risk when both plugins are active.

**plugin-dev agent trailing text:**
Three agents in `plugins/plugin-dev/agents/` (plugin-validator, skill-reviewer, agent-creator) all have stale conversation text appended after their final code block. This appears to be an authoring artifact where session output was accidentally included in the file. The text does not affect parsing (it follows the closing ```), but it pollutes the system prompt and may confuse Claude about the agent's scope.

**Missing hooks matcher:**
`plugins/hookify/hooks/hooks.json` fires on all events with no matchers. When hookify is installed alongside other hook-heavy plugins (e.g., security-guidance), every tool call incurs 5 hook executions (4 hookify + 1 security). This was verified against the actual hooks.json content.

## Recommendation

REVIEW — submit NL fix PRs for bugs and quality issues; flag MEDIUM security findings in a separate issue.

**Priority PR 1 — Bug fixes (blocking):**
Add YAML frontmatter to `agents/grader.md`, `agents/analyzer.md`, `agents/comparator.md` in skill-creator. Fix `color: pink` → `color: cyan` in type-design-analyzer.

**Priority PR 2 — Quality: add examples to description-less agents:**
`agent-sdk-verifier-ts`, `agent-sdk-verifier-py`, `code-architect`, `code-reviewer`, `code-explorer` (feature-dev), and the standalone `code-simplifier` all lack `<example>` blocks. Add 2 examples each.

**Priority PR 3 — Strip trailing junk from plugin-dev agents:**
Remove the stale conversation text appended after the closing code block in `plugin-validator.md`, `skill-reviewer.md`, and `agent-creator.md`.

**Priority PR 4 — Add missing allowed-tools:**
`help.md` (ralph-loop), `new-sdk-app.md`, `feature-dev.md`, `clean_gone.md` all omit `allowed-tools`. Add appropriate tool lists.

**Security Issue (file in repo, do not PR):**
Runtime `bun install` in the 4 external MCP server package.json start scripts creates supply-chain exposure. Recommend pinning versions and using `--frozen-lockfile`. File as a security issue for maintainers to address.
