---
user-invocable: false
---

# Discover NL Programming Artifacts

**Purpose:** Discover NL programming artifacts by path pattern.

**Input:** directory path, category filter (A, B, or both)
**Output:** classified file list with line counts

## Category A — Plugin Artifacts

Patterns to search (relative to target directory):

| Pattern | Notes |
|---------|-------|
| `.claude-plugin/plugin.json` | Plugin manifest |
| `.claude-plugin/marketplace.json` | Marketplace entry |
| `commands/**/*.md` | Exclude `commands/shared/` — those are shared partials |
| `commands/shared/**/*.md` | Shared partials |
| `agents/**/*.md` | Agent definitions |
| `skills/**/SKILL.md` | Skill definitions |
| `hooks/**/*.json` | Hook configs |
| `.mcp.json` | MCP config |
| `.lsp.json` | LSP config |
| `settings.json` | Root-level settings |

## Category B — Project Config

| Pattern | Notes |
|---------|-------|
| `CLAUDE.md` | Root project instructions |
| `.claude/CLAUDE.md` | Claude config directory instructions |
| `.claude/rules/**/*.md` | Rule files |
| `.claude/settings.json` | Claude settings |
| `.claude/settings.local.json` | Local Claude settings |
| `.claude/**/*.local.md` | Local plugin config files |

## Skip Directories

Always skip these directories during traversal:

- `node_modules/`
- `.git/`
- `target/`
- `dist/`
- `build/`
- `vendor/`
- `__pycache__/`
- `.next/`
- `.venv/`

## Instructions

1. Receive: `directory` (absolute path), `category` ("A", "B", or "both")
2. Use Glob to find files matching each pattern within the directory
3. Filter out any results that fall inside skip directories
4. For each found file, use Read to count lines
5. Return a structured list with entries: `{ path, category, pattern_matched, line_count }`

## Notes

- For `commands/**/*.md` results, exclude any file whose path contains `/commands/shared/` (those match the shared partials pattern instead)
- `.gitkeep` files are not artifacts — ignore them
- If a file matches multiple patterns, use the first matching pattern in the order listed above (Category A first, then B)
