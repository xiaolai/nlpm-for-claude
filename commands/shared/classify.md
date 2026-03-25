---
user-invocable: false
---

# Classify NL Artifact Type

**Purpose:** Classify a file's artifact type from its path.

**Input:** file path (absolute or relative)
**Output:** artifact type string

## Classification Rules

Checked in order — **first match wins**:

| # | Condition | Type |
|---|-----------|------|
| 1 | Path matches `commands/shared/**/*.md` | `shared-partial` |
| 2 | Path matches `commands/**/*.md` | `command` |
| 3 | Path matches `agents/**/*.md` | `agent` |
| 4 | Filename is `SKILL.md` | `skill` |
| 5 | Path matches `.claude/rules/**/*.md` | `rule` |
| 6 | Path matches `hooks/**/*.json` | `hook-config` |
| 7 | Filename is `plugin.json` AND parent directory is `.claude-plugin` | `manifest` |
| 8 | Filename is `marketplace.json` AND parent directory is `.claude-plugin` | `marketplace` |
| 9 | Filename is `.mcp.json` | `mcp-config` |
| 10 | Filename is `.lsp.json` | `lsp-config` |
| 11 | Filename is `CLAUDE.md` | `claude-md` |
| 12 | Path matches `.claude/**/*.local.md` | `plugin-config` |
| 13 | Path matches `.claude/settings*.json` | `settings` |
| 14 | (fallback) | `document` |

## Notes

- Classification is path-based only — no content analysis required
- Path matching uses simple substring/suffix checks, not regex
- For rule 7 and 8, check that the immediate parent directory name is `.claude-plugin`
- Rule 12 applies to files like `.claude/nlpm.local.md`
- Rule 13 applies to `.claude/settings.json` and `.claude/settings.local.json`
