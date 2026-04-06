# NLPM Audit: trailofbits/skills
**Date**: 2026-04-06  |  **Artifacts**: 151  |  **Strategy**: progressive
**NL Score**: 95/100
**Security**: BLOCKED
**Bugs**: 3  |  **Quality Issues**: 42  |  **Security Findings**: 13

## NL Score Summary

| File | Type | Score | Top Issue |
|------|------|-------|-----------|
| plugins/spec-to-code-compliance/agents/spec-compliance-checker.md | agent | 60 | No examples, no output format, Write/Bash on read-only agent |
| plugins/skill-improver/commands/skill-improver.md | command | 63 | Missing required `name` field (BUG) |
| plugins/skill-improver/commands/cancel-skill-improver.md | command | 65 | Missing required `name` field (BUG) |
| plugins/audit-context-building/agents/function-analyzer.md | agent | 70 | No examples, no output format, no model |
| plugins/let-fate-decide/agents/draw.md | agent | 75 | No examples, no formal output format section |
| plugins/workflow-skill-design/agents/workflow-skill-reviewer.md | agent | 75 | No examples, no model |
| plugins/burpsuite-project-parser/commands/burp-search.md | command | 75 | No empty input handling |
| plugins/zeroize-audit/agents/1-mcp-resolver.md | agent | 80 | No examples |
| plugins/zeroize-audit/agents/2-source-analyzer.md | agent | 80 | No examples |
| plugins/zeroize-audit/agents/6-test-generator.md | agent | 80 | No examples |
| plugins/debug-buttercup/skills/debug-buttercup/SKILL.md | skill | 84 | No output format, 4 vague quantifiers |
| plugins/constant-time-analysis/commands/ct-check.md | command | 85 | No empty input handling |
| plugins/audit-context-building/commands/audit-context.md | command | 85 | No empty input handling |
| plugins/spec-to-code-compliance/commands/spec-compliance.md | command | 85 | No empty input handling |
| plugins/differential-review/commands/diff-review.md | command | 85 | No empty input handling |
| plugins/property-based-testing/skills/property-based-testing/SKILL.md | skill | 86 | No output format, vague language |
| plugins/dimensional-analysis/agents/dimension-propagator.md | agent | 88 | No model, vague "appropriate" |
| plugins/dimensional-analysis/agents/dimension-validator.md | agent | 88 | No model, vague "appropriate" |
| plugins/dimensional-analysis/agents/dimension-annotator.md | agent | 88 | No model, vague "appropriate" |
| plugins/static-analysis/agents/semgrep-scanner.md | agent | 88 | No model |
| plugins/semgrep-rule-creator/commands/semgrep-rule.md | command | 88 | Vague "appropriate" |
| plugins/dimensional-analysis/agents/dimension-discoverer.md | agent | 90 | No model |
| plugins/yara-authoring/skills/yara-rule-authoring/SKILL.md | skill | 90 | No output format |
| plugins/supply-chain-risk-auditor/skills/supply-chain-risk-auditor/SKILL.md | skill | 90 | No output format |
| plugins/modern-python/skills/modern-python/SKILL.md | skill | 90 | No output format |
| plugins/dwarf-expert/skills/dwarf-expert/SKILL.md | skill | 90 | No output format |
| plugins/trailmark/skills/trailmark-structural/SKILL.md | skill | 90 | No output format |
| plugins/trailmark/skills/audit-augmentation/SKILL.md | skill | 90 | No output format |
| plugins/trailmark/skills/trailmark/SKILL.md | skill | 90 | No output format |
| plugins/trailmark/skills/trailmark-summary/SKILL.md | skill | 90 | No output format |
| plugins/ask-questions-if-underspecified/skills/ask-questions-if-underspecified/SKILL.md | skill | 90 | No output format |
| .codex/skills/gh-cli/SKILL.md | skill | 90 | No output format |
| plugins/fp-check/hooks/hooks.json | hook | 90 | Valid config, no NL issues observed |
| plugins/gh-cli/hooks/hooks.json | hook | 90 | Valid config, no NL issues observed |
| plugins/modern-python/hooks/hooks.json | hook | 90 | Valid config, no NL issues observed |
| plugins/skill-improver/hooks/hooks.json | hook | 90 | Valid config, no NL issues observed |
| plugins/fp-check/agents/data-flow-analyzer.md | agent | 93 | Only one example |
| plugins/fp-check/skills/fp-check/SKILL.md | skill | 94 | Vague: appropriate, relevant, various |
| plugins/building-secure-contracts/skills/audit-prep-assistant/SKILL.md | skill | 94 | Vague: appropriate, comprehensive, thorough |
| plugins/dimensional-analysis/agents/arithmetic-scanner.md | agent | 95 | No model |
| plugins/fp-check/agents/exploitability-verifier.md | agent | 95 | None significant |
| plugins/zeroize-audit/agents/0-preflight.md | agent | 95 | None significant |
| plugins/zeroize-audit/agents/2b-rust-source-analyzer.md | agent | 95 | None significant |
| plugins/zeroize-audit/agents/3-tu-compiler-analyzer.md | agent | 95 | None significant |
| plugins/zeroize-audit/agents/3b-rust-compiler-analyzer.md | agent | 95 | None significant |
| plugins/zeroize-audit/agents/5b-poc-validator.md | agent | 95 | None significant |
| plugins/zeroize-audit/agents/5c-poc-verifier.md | agent | 95 | None significant |
| plugins/variant-analysis/commands/variants.md | command | 95 | None significant |
| plugins/git-cleanup/skills/git-cleanup/SKILL.md | skill | 96 | Vague: thorough, appropriate |
| plugins/building-secure-contracts/skills/guidelines-advisor/SKILL.md | skill | 96 | Vague: various, comprehensive |
| plugins/building-secure-contracts/skills/token-integration-analyzer/SKILL.md | skill | 96 | Vague: comprehensive, various |
| plugins/testing-handbook-skills/skills/libafl/SKILL.md | skill | 96 | Vague: appropriate, various |
| plugins/testing-handbook-skills/skills/ossfuzz/SKILL.md | skill | 96 | Vague: appropriate, various |
| plugins/testing-handbook-skills/skills/constant-time-testing/SKILL.md | skill | 96 | Vague: appropriate, various |
| plugins/testing-handbook-skills/skills/testing-handbook-generator/SKILL.md | skill | 96 | Vague: appropriate, comprehensive |
| plugins/testing-handbook-skills/skills/aflpp/SKILL.md | skill | 96 | Vague: appropriate, various |
| plugins/variant-analysis/skills/variant-analysis/SKILL.md | skill | 96 | Vague: various, appropriate |
| plugins/sharp-edges/skills/sharp-edges/SKILL.md | skill | 96 | Vague: appropriate, various |
| plugins/insecure-defaults/skills/insecure-defaults/SKILL.md | skill | 96 | Vague: appropriate, various |
| plugins/static-analysis/skills/codeql/SKILL.md | skill | 96 | Vague: appropriate, various |
| CLAUDE.md | doc | 96 | Minor vague language |
| plugins/dimensional-analysis/skills/dimensional-analysis/SKILL.md | skill | 97 | Vague "appropriate" |
| plugins/audit-context-building/skills/audit-context-building/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/devcontainer-setup/skills/devcontainer-setup/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/building-secure-contracts/skills/cairo-vulnerability-scanner/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/building-secure-contracts/skills/code-maturity-assessor/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/building-secure-contracts/skills/algorand-vulnerability-scanner/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/building-secure-contracts/skills/cosmos-vulnerability-scanner/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/building-secure-contracts/skills/solana-vulnerability-scanner/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/building-secure-contracts/skills/substrate-vulnerability-scanner/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/testing-handbook-skills/skills/address-sanitizer/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/testing-handbook-skills/skills/ruzzy/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/testing-handbook-skills/skills/wycheproof/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/testing-handbook-skills/skills/coverage-analysis/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/testing-handbook-skills/skills/fuzzing-dictionary/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/testing-handbook-skills/skills/cargo-fuzz/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/testing-handbook-skills/skills/libfuzzer/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/static-analysis/skills/sarif-parsing/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/differential-review/skills/differential-review/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/zeroize-audit/skills/zeroize-audit/SKILL.md | skill | 98 | Vague "appropriate" |
| plugins/zeroize-audit/agents/4-report-assembler.md | agent | 98 | None significant |
| plugins/fp-check/agents/poc-builder.md | agent | 98 | None significant |
| plugins/zeroize-audit/agents/5-poc-generator.md | agent | 98 | None significant |
| plugins/entry-point-analyzer/commands/entry-points.md | command | 100 | None |
| plugins/firebase-apk-scanner/commands/scan-apk.md | command | 100 | None |
| plugins/constant-time-analysis/skills/constant-time-analysis/SKILL.md | skill | 100 | None |
| plugins/skill-improver/skills/skill-improver/SKILL.md | skill | 100 | None |
| plugins/firebase-apk-scanner/skills/firebase-apk-scanner/SKILL.md | skill | 100 | None |
| plugins/seatbelt-sandboxer/skills/seatbelt-sandboxer/SKILL.md | skill | 100 | None |
| plugins/trailmark/skills/vector-forge/SKILL.md | skill | 100 | None |
| plugins/trailmark/skills/graph-evolution/SKILL.md | skill | 100 | None |
| plugins/trailmark/skills/mermaid-to-proverif/SKILL.md | skill | 100 | None |
| plugins/trailmark/skills/diagramming-code/SKILL.md | skill | 100 | None |
| plugins/trailmark/skills/crypto-protocol-diagram/SKILL.md | skill | 100 | None |
| plugins/trailmark/skills/genotoxic/SKILL.md | skill | 100 | None |
| plugins/entry-point-analyzer/skills/entry-point-analyzer/SKILL.md | skill | 100 | None |
| plugins/burpsuite-project-parser/skills/burpsuite-project-parser/SKILL.md | skill | 100 | None |
| plugins/second-opinion/skills/second-opinion/SKILL.md | skill | 100 | None |
| plugins/mutation-testing/skills/mutation-testing/SKILL.md | skill | 100 | None |
| plugins/agentic-actions-auditor/skills/agentic-actions-auditor/SKILL.md | skill | 100 | None |
| plugins/culture-index/skills/interpreting-culture-index/SKILL.md | skill | 100 | None |
| plugins/spec-to-code-compliance/skills/spec-to-code-compliance/SKILL.md | skill | 100 | None |
| plugins/building-secure-contracts/skills/secure-workflow-guide/SKILL.md | skill | 100 | None |
| plugins/building-secure-contracts/skills/ton-vulnerability-scanner/SKILL.md | skill | 100 | None |
| plugins/testing-handbook-skills/skills/fuzzing-obstacles/SKILL.md | skill | 100 | None |
| plugins/testing-handbook-skills/skills/harness-writing/SKILL.md | skill | 100 | None |
| plugins/testing-handbook-skills/skills/atheris/SKILL.md | skill | 100 | None |
| plugins/semgrep-rule-creator/skills/semgrep-rule-creator/SKILL.md | skill | 100 | None |
| plugins/let-fate-decide/skills/let-fate-decide/SKILL.md | skill | 100 | None |
| plugins/claude-in-chrome-troubleshooting/skills/claude-in-chrome-troubleshooting/SKILL.md | skill | 100 | None |
| plugins/static-analysis/skills/semgrep/SKILL.md | skill | 100 | None |
| plugins/workflow-skill-design/skills/designing-workflow-skills/SKILL.md | skill | 100 | None |
| plugins/semgrep-rule-variant-creator/skills/semgrep-rule-variant-creator/SKILL.md | skill | 100 | None |
| plugins/git-cleanup/.claude-plugin/plugin.json | json | 100 | None |
| plugins/debug-buttercup/.claude-plugin/plugin.json | json | 100 | None |
| plugins/building-secure-contracts/.claude-plugin/plugin.json | json | 100 | None |
| plugins/testing-handbook-skills/.claude-plugin/plugin.json | json | 100 | None |
| plugins/semgrep-rule-creator/.claude-plugin/plugin.json | json | 100 | None |
| plugins/variant-analysis/.claude-plugin/plugin.json | json | 100 | None |
| plugins/let-fate-decide/.claude-plugin/plugin.json | json | 100 | None |
| plugins/sharp-edges/.claude-plugin/plugin.json | json | 100 | None |
| plugins/insecure-defaults/.claude-plugin/plugin.json | json | 100 | None |
| plugins/claude-in-chrome-troubleshooting/.claude-plugin/plugin.json | json | 100 | None |
| plugins/gh-cli/.claude-plugin/plugin.json | json | 100 | None |
| plugins/static-analysis/.claude-plugin/plugin.json | json | 100 | None |
| plugins/differential-review/.claude-plugin/plugin.json | json | 100 | None |
| plugins/zeroize-audit/.claude-plugin/plugin.json | json | 100 | None |
| plugins/workflow-skill-design/.claude-plugin/plugin.json | json | 100 | None |
| plugins/semgrep-rule-variant-creator/.claude-plugin/plugin.json | json | 100 | None |
| plugins/dimensional-analysis/.claude-plugin/plugin.json | json | 100 | None |
| plugins/yara-authoring/.claude-plugin/plugin.json | json | 100 | None |
| plugins/supply-chain-risk-auditor/.claude-plugin/plugin.json | json | 100 | None |
| plugins/constant-time-analysis/.claude-plugin/plugin.json | json | 100 | None |
| plugins/audit-context-building/.claude-plugin/plugin.json | json | 100 | None |
| plugins/devcontainer-setup/.claude-plugin/plugin.json | json | 100 | None |
| plugins/skill-improver/.claude-plugin/plugin.json | json | 100 | None |
| plugins/firebase-apk-scanner/.claude-plugin/plugin.json | json | 100 | None |
| plugins/modern-python/.claude-plugin/plugin.json | json | 100 | None |
| plugins/dwarf-expert/.claude-plugin/plugin.json | json | 100 | None |
| plugins/seatbelt-sandboxer/.claude-plugin/plugin.json | json | 100 | None |
| plugins/trailmark/.claude-plugin/plugin.json | json | 100 | None |
| plugins/entry-point-analyzer/.claude-plugin/plugin.json | json | 100 | None |
| plugins/burpsuite-project-parser/.claude-plugin/plugin.json | json | 100 | None |
| plugins/second-opinion/.claude-plugin/plugin.json | json | 100 | None |
| plugins/ask-questions-if-underspecified/.claude-plugin/plugin.json | json | 100 | None |
| plugins/mutation-testing/.claude-plugin/plugin.json | json | 100 | None |
| plugins/agentic-actions-auditor/.claude-plugin/plugin.json | json | 100 | None |
| plugins/culture-index/.claude-plugin/plugin.json | json | 100 | None |
| plugins/property-based-testing/.claude-plugin/plugin.json | json | 100 | None |
| plugins/spec-to-code-compliance/.claude-plugin/plugin.json | json | 100 | None |
| plugins/fp-check/.claude-plugin/plugin.json | json | 100 | None |

## Security Scan

| Severity | Count |
|----------|-------|
| Critical | 0 |
| High | 4 |
| Medium | 5 |
| Low | 4 |

### Execution Surface Inventory

| Surface | Files |
|---------|-------|
| Hooks JSON | plugins/fp-check/hooks/hooks.json, plugins/gh-cli/hooks/hooks.json, plugins/modern-python/hooks/hooks.json, plugins/skill-improver/hooks/hooks.json |
| Hook scripts (gh-cli) | cleanup-clones.sh, intercept-github-curl.sh, intercept-github-fetch.sh, persist-session-id.sh, setup-shims.sh |
| Hook scripts (modern-python) | setup-shims.sh |
| Hook scripts (skill-improver) | stop-hook.sh |
| Scanner script | plugins/firebase-apk-scanner/scanner.sh |
| Install scripts | .codex/scripts/install-for-codex.sh, plugins/devcontainer-setup/skills/devcontainer-setup/resources/install.sh |
| Skill scripts | plugins/burpsuite-project-parser/skills/.../burp-search.sh, plugins/debug-buttercup/skills/.../diagnose.sh, plugins/skill-improver/scripts/*.sh |
| Zeroize-audit tools | plugins/zeroize-audit/skills/zeroize-audit/tools/*.sh (27+ shell scripts), generate_poc.py, check_rust_asm.py |
| Python resources | plugins/devcontainer-setup/skills/devcontainer-setup/resources/post_install.py, plugins/culture-index/skills/.../scripts/extract_pdf.py |
| MCP configs | plugins/second-opinion/.mcp.json |
| Shell configs | plugins/devcontainer-setup/skills/devcontainer-setup/resources/.zshrc |

### Security Findings

| # | Severity | File | Line | Pattern | Description |
|---|----------|------|------|---------|-------------|
| 1 | HIGH | plugins/devcontainer-setup/.../resources/post_install.py | 104–108 | subprocess + sudo | Executes `sudo chown` with a user-controlled directory path. Path is derived from function arguments without sanitization; if an attacker controls the install target path, they can trigger privilege-escalated `chown` on arbitrary filesystem locations. |
| 2 | HIGH | plugins/devcontainer-setup/.../resources/post_install.py | 18–36 | File write outside repo — `bypassPermissions` | Writes `~/.claude/settings.json` and sets `bypassPermissions: true`. This modifies global Claude Code settings outside the repository boundary, weakening the tool's permission model for all future sessions. |
| 3 | HIGH | plugins/gh-cli/hooks/setup-shims.sh | 29 | PATH modification via CLAUDE_ENV_FILE | Appends a plugin-managed shims directory to `CLAUDE_ENV_FILE`. If `CLAUDE_ENV_FILE` points to a world-writable location or is overridden by an attacker, arbitrary executables could be injected into Claude's PATH for the session. |
| 4 | HIGH | plugins/modern-python/hooks/setup-shims.sh | 24 | PATH modification via CLAUDE_ENV_FILE | Prepends a shims directory to `CLAUDE_ENV_FILE`. Same risk as finding #3 — PATH prepend is more dangerous than append because it can completely override system binaries. |
| 5 | MEDIUM | plugins/devcontainer-setup/.../resources/.zshrc | 10 | `eval "$(fnm env --use-on-cd)"` | Executes the output of `fnm env` via `eval`. If the `fnm` binary is replaced or returns adversarial output (e.g., via supply chain), this becomes arbitrary code execution at shell startup. |
| 6 | MEDIUM | plugins/devcontainer-setup/.../resources/.zshrc | 56 | `eval "$(fzf --zsh)"` | Same `eval`-with-tool-output pattern as finding #5, applied to `fzf`. Low practical risk unless the fuzzy finder binary itself is compromised, but represents a code execution surface in shell initialization. |
| 7 | MEDIUM | plugins/zeroize-audit/.../tools/generate_poc.py | 103–117 | subprocess + JSON output parsing | Spawns `extract_compile_flags.py` via `subprocess.run` (no `shell=True` — safe), then parses its stdout as JSON. If the child process is compromised or returns malformed output exploiting a parser bug, downstream code execution is possible. Includes timeout and error handling. |
| 8 | MEDIUM | plugins/gh-cli/hooks/persist-session-id.sh | 12–16 | Shell path construction from validated session ID | Constructs file paths using a `session_id` validated against `^[a-zA-Z0-9_-]+$`. Validation is correct but validates format only, not origin. A session ID injected during the Claude startup sequence before hook execution would still pass. Low practical exploitability. |
| 9 | MEDIUM | plugins/gh-cli/hooks/cleanup-clones.sh | 12 | `rm -rf` on constructed path | Constructs a `rm -rf` target path using `session_id` (regex-validated). If validation is bypassed or the base directory variable is empty, path traversal to root deletion is possible. Mitigation: validate the base directory is non-empty before executing. |
| 10 | LOW | plugins/zeroize-audit/.../tools/generate_poc.py | 4 | Unpinned upper bound: `pyyaml>=6.0` | Dependency declared as `pyyaml>=6.0` with no upper bound. A future major PyYAML version with breaking changes or security issues will be pulled in automatically. Recommended: `pyyaml>=6.0,<7.0`. |
| 11 | LOW | plugins/skill-improver/hooks/hooks.json | — | Verbose hook triggers | Hook fires on every `Stop` event. Verbose triggers increase attack surface for hook-based prompt injection if stop-event data is user-influenced. No immediate vulnerability but increases noise exposure. |
| 12 | LOW | plugins/gh-cli/hooks/hooks.json | — | Verbose hook triggers | PostToolUse hook fires on Bash tool use. Broad trigger scope means adversarial command outputs are passed to the hook handler more frequently. |
| 13 | LOW | plugins/modern-python/hooks/hooks.json | — | Verbose hook triggers | Same broad PostToolUse scope as finding #12. |

## Bugs (PR-worthy)

| # | File | Issue | Impact |
|---|------|-------|--------|
| 1 | plugins/skill-improver/commands/skill-improver.md | Missing `name` field in frontmatter | Command cannot be registered by name in plugin registry; plugin.json declares it as `skill-improver` but the command file has no `name` to match against |
| 2 | plugins/skill-improver/commands/cancel-skill-improver.md | Missing `name` field in frontmatter | Same as above — `cancel-skill-improver` command will not resolve from the plugin registry; `/cancel-skill-improver` invocation will fail |
| 3 | plugins/spec-to-code-compliance/agents/spec-compliance-checker.md | `Write` and `Bash` tools declared on a read-only compliance analysis agent | A compliance checker should only read files and emit findings; having Write/Bash allows the agent to modify source files or run shell commands during an audit, which violates least-privilege and could corrupt the codebase under audit |

## Security Fixes (PR-worthy, Medium/Low only)

*Critical/High findings (#1–#4) require private disclosure to maintainers — do NOT submit public PRs.*

| # | File | Issue | Suggested Fix |
|---|------|-------|---------------|
| 1 | plugins/devcontainer-setup/.../resources/.zshrc (line 10) | `eval "$(fnm env --use-on-cd)"` — eval of tool output at shell init | Add a comment documenting the risk; verify `fnm` binary path is absolute before eval (e.g., `/usr/local/bin/fnm`) to resist PATH hijacking |
| 2 | plugins/devcontainer-setup/.../resources/.zshrc (line 56) | `eval "$(fzf --zsh)"` — eval of tool output at shell init | Same mitigation as above: verify absolute binary path before eval |
| 3 | plugins/gh-cli/hooks/cleanup-clones.sh (line 12) | `rm -rf` path constructed from session ID without empty-variable guard | Add `[ -n "$BASE_DIR" ] || exit 1` guard before constructing the rm target path to prevent deletion of `/` or `/sessions` if the base variable is unset |
| 4 | plugins/zeroize-audit/.../tools/generate_poc.py (line 4) | `pyyaml>=6.0` — no upper-bound pin | Change to `pyyaml>=6.0,<7.0` to prevent unexpected major-version upgrades |

## Quality Issues (informational)

| # | File | Issue | Penalty |
|---|------|-------|---------|
| 1 | plugins/dimensional-analysis/agents/dimension-propagator.md | No model declared | -5 |
| 2 | plugins/dimensional-analysis/agents/dimension-discoverer.md | No model declared | -5 |
| 3 | plugins/dimensional-analysis/agents/dimension-validator.md | No model declared | -5 |
| 4 | plugins/dimensional-analysis/agents/dimension-annotator.md | No model declared | -5 |
| 5 | plugins/dimensional-analysis/agents/arithmetic-scanner.md | No model declared | -5 |
| 6 | plugins/audit-context-building/agents/function-analyzer.md | No model declared | -5 |
| 7 | plugins/spec-to-code-compliance/agents/spec-compliance-checker.md | No model declared | -5 |
| 8 | plugins/static-analysis/agents/semgrep-scanner.md | No model declared | -5 |
| 9 | plugins/workflow-skill-design/agents/workflow-skill-reviewer.md | No model declared | -5 |
| 10 | plugins/audit-context-building/agents/function-analyzer.md | Zero examples | -15 |
| 11 | plugins/spec-to-code-compliance/agents/spec-compliance-checker.md | Zero examples | -15 |
| 12 | plugins/let-fate-decide/agents/draw.md | Zero examples | -15 |
| 13 | plugins/zeroize-audit/agents/1-mcp-resolver.md | Zero examples | -15 |
| 14 | plugins/zeroize-audit/agents/2-source-analyzer.md | Zero examples | -15 |
| 15 | plugins/zeroize-audit/agents/6-test-generator.md | Zero examples | -15 |
| 16 | plugins/workflow-skill-design/agents/workflow-skill-reviewer.md | Zero examples | -15 |
| 17 | plugins/fp-check/agents/data-flow-analyzer.md | Only one example | -5 |
| 18 | plugins/audit-context-building/agents/function-analyzer.md | No output format section | -10 |
| 19 | plugins/spec-to-code-compliance/agents/spec-compliance-checker.md | No output format section | -10 |
| 20 | plugins/let-fate-decide/agents/draw.md | No formal output format section | -10 |
| 21 | plugins/constant-time-analysis/commands/ct-check.md | No empty input handling | -10 |
| 22 | plugins/audit-context-building/commands/audit-context.md | No empty input handling | -10 |
| 23 | plugins/burpsuite-project-parser/commands/burp-search.md | No empty input handling | -10 |
| 24 | plugins/spec-to-code-compliance/commands/spec-compliance.md | No empty input handling | -10 |
| 25 | plugins/differential-review/commands/diff-review.md | No empty input handling | -10 |
| 26 | plugins/skill-improver/commands/cancel-skill-improver.md | No empty input handling | -10 |
| 27 | plugins/yara-authoring/skills/yara-rule-authoring/SKILL.md | No output format | -10 |
| 28 | plugins/supply-chain-risk-auditor/skills/supply-chain-risk-auditor/SKILL.md | No output format | -10 |
| 29 | plugins/modern-python/skills/modern-python/SKILL.md | No output format | -10 |
| 30 | plugins/dwarf-expert/skills/dwarf-expert/SKILL.md | No output format | -10 |
| 31 | plugins/trailmark/skills/trailmark-structural/SKILL.md | No output format | -10 |
| 32 | plugins/trailmark/skills/audit-augmentation/SKILL.md | No output format | -10 |
| 33 | plugins/trailmark/skills/trailmark/SKILL.md | No output format | -10 |
| 34 | plugins/trailmark/skills/trailmark-summary/SKILL.md | No output format | -10 |
| 35 | plugins/ask-questions-if-underspecified/skills/ask-questions-if-underspecified/SKILL.md | No output format | -10 |
| 36 | plugins/property-based-testing/skills/property-based-testing/SKILL.md | No output format | -10 |
| 37 | plugins/debug-buttercup/skills/debug-buttercup/SKILL.md | No output format | -10 |
| 38 | .codex/skills/gh-cli/SKILL.md | No output format | -10 |
| 39 | plugins/dimensional-analysis/agents/dimension-propagator.md | Vague "appropriate" | -2 |
| 40 | plugins/dimensional-analysis/agents/dimension-validator.md | Vague "appropriate" | -2 |
| 41 | plugins/dimensional-analysis/agents/dimension-annotator.md | Vague "appropriate" | -2 |
| 42 | plugins/semgrep-rule-creator/commands/semgrep-rule.md | Vague "appropriate" | -2 |

*Vague-word issues in skills (fp-check, git-cleanup, debug-buttercup, audit-prep-assistant, guidelines-advisor, token-integration-analyzer, 12× testing-handbook skills, variant-analysis, sharp-edges, insecure-defaults, codeql, differential-review, zeroize-audit, etc.) carry -2 per occurrence, capped at -20 per file. Most incur only 1–2 occurrences of "appropriate" or "various" so penalties are small (-2 to -6 per file).*

## Cross-Component

**Broken name registration (skill-improver plugin):** The plugin.json for `skill-improver` declares two commands: `skill-improver` and `cancel-skill-improver`. Both corresponding command `.md` files are missing the `name` frontmatter field. The plugin registry uses the `name` field for lookup, so neither command will resolve. This is a multi-file break: fix both command files together.

**Tooling mismatch (spec-to-code-compliance):** The `spec-compliance-checker` agent declares `Write` and `Bash` in its tool list, but the `spec-compliance` command dispatches it as an analysis-only agent via `Task`. The agent's stated purpose is compliance verification (read-only), yet it has write capability. If the agent were to follow instructions embedded in an audited document (prompt injection via spec files), it could write files to the repository.

**Ironic omission (workflow-skill-design):** The `workflow-skill-reviewer` agent — whose sole purpose is reviewing workflow skill quality — has zero examples and no declared model. This is the canonical anti-pattern for the plugin's own subject matter.

**Dimensional-analysis agents: uniform model gap.** All 5 dimensional-analysis agents (`dimension-propagator`, `dimension-discoverer`, `dimension-validator`, `dimension-annotator`, `arithmetic-scanner`) lack model declarations. The zeroize-audit agents handle this correctly with `model: inherit`. The dimensional-analysis agents should adopt the same pattern.

**Zeroize-audit pipeline consistency:** The agents `0-preflight` through `6-test-generator` all use `model: inherit` and are well-structured. The outliers are `1-mcp-resolver`, `2-source-analyzer`, and `6-test-generator` which lack examples despite being invoked in the same orchestrated pipeline as example-rich siblings.

## Recommendation

**BLOCKED — do not submit PRs. File a private security report with maintainers first.**

Findings #1–#4 (HIGH severity) must be privately disclosed before any public contributions:

- **Finding #1 & #2** (`post_install.py`): privileged file writes and `sudo` operations with user-controlled paths in the devcontainer-setup plugin.
- **Finding #3 & #4** (`setup-shims.sh` in gh-cli and modern-python): PATH modification via `CLAUDE_ENV_FILE` that could allow session-scoped command hijacking.

Once the security gate clears, the following public PRs are appropriate:

1. **Bug fix PR — skill-improver:** Add `name: trailofbits:skill-improver` and `name: trailofbits:cancel-skill-improver` frontmatter to both command files.
2. **Bug fix PR — spec-compliance-checker:** Remove `Write` and `Bash` from the agent's `tools` list; it is analysis-only.
3. **Security fix PR — Medium/Low:** Address findings #5–#13 (eval patterns in .zshrc, rm -rf guard, pyyaml pin, verbose hook scope).
4. **Quality PR — dimensional-analysis agents:** Add `model: inherit` to all 5 agents.
5. **Quality PR — missing examples:** Add at least two examples to `function-analyzer`, `draw`, `1-mcp-resolver`, `2-source-analyzer`, `6-test-generator`, `workflow-skill-reviewer`.
6. **Quality PR — missing output formats:** Add output format sections to `yara-rule-authoring`, `supply-chain-risk-auditor`, `modern-python`, `dwarf-expert`, `trailmark*` (5 files), `ask-questions-if-underspecified`, `property-based-testing`, `debug-buttercup`, `.codex/gh-cli`.
