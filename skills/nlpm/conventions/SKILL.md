---
name: conventions
description: "Use when writing, reviewing, or validating Claude Code plugin artifacts — check frontmatter schemas, hook event names, naming conventions, prompt structure, or reference syntax. Loaded by the NLPM linter for schema validation."
version: 0.1.0
---

# Claude Code Plugin Conventions

Canonical reference for all NL programming artifact schemas, frontmatter fields, hook events, and naming conventions. Use this skill when linting, writing, or reviewing any Claude Code plugin component.

---

## 1. plugin.json

The plugin manifest. Located at `.claude-plugin/plugin.json`.

**Required fields:**
- `name` — string, kebab-case, unique identifier

**Optional fields:**
- `version` — semver string (e.g. `"0.1.0"`)
- `description` — one-line summary of what the plugin does
- `author` — object: `{ "name": "...", "email": "...", "url": "..." }`
- `homepage` — URL string
- `repository` — URL string or object
- `license` — SPDX identifier (e.g. `"MIT"`)
- `keywords` — string array for discovery

**Component path fields (all optional, string or string[]):**
- `commands` — path(s) to command markdown files
- `agents` — path(s) to agent markdown files
- `skills` — path(s) to skill directories
- `hooks` — path to hooks.json
- `mcpServers` — path(s) to MCP server config
- `lspServers` — path(s) to LSP server config
- `outputStyles` — path(s) to output style definitions

**Example:**
```json
{
  "name": "my-plugin",
  "version": "0.2.1",
  "description": "Does useful things",
  "author": { "name": "dev" },
  "license": "MIT",
  "keywords": ["tools", "productivity"],
  "commands": "commands/",
  "agents": "agents/",
  "skills": "skills/"
}
```

---

## 2. Command Frontmatter

Commands live in `commands/*.md`. Frontmatter is YAML between `---` delimiters.

**Required fields:**
- `description` — string; explains what the command does and when to invoke it

**Optional fields:**
- `argument-hint` — string; shown in UI as placeholder (e.g. `"[path]"`, `"<file>"`)
- `allowed-tools` — string array; tools Claude may call while executing this command
- `model` — one of `haiku`, `sonnet`, `opus`; selects model tier
- `user-invocable` — boolean; set `false` for shared partials that should not appear in menus

**Body convention:**
- Write imperative instructions directed at Claude (not the user)
- Use numbered steps for multi-phase workflows
- Reference shared partials by relative path: `commands/shared/name.md`
- Define the expected output format explicitly in the body

**Example:**
```yaml
---
description: "Lint all NL artifacts in the current project and report quality scores"
argument-hint: "[path]"
allowed-tools: ["Read", "Glob"]
model: sonnet
---
```

---

## 3. Shared Partials

Reusable command fragments. Located in `commands/shared/`.

**Rules:**
- MUST include `user-invocable: false` in frontmatter — prevents them appearing as top-level commands
- MUST have a clear `description` stating their purpose as a partial
- Referenced by full relative path from the consuming command file
- Can contain any mix of instructions, templates, or decision logic

**Example frontmatter:**
```yaml
---
description: "Shared: discover NL artifact files in a directory tree"
user-invocable: false
allowed-tools: ["Glob"]
---
```

---

## 4. Agent Frontmatter

Agents live in `agents/*.md`. They are specialized Claude instances invoked by commands or other agents.

**Documented fields:**
- `name` — string; identifier used when referencing or invoking this agent
- `description` — string; critical for reliable triggering — should contain 3+ specific phrases describing when to use this agent

**Convention fields (not enforced by schema but strongly recommended):**
- `model` — `haiku` / `sonnet` / `opus`; declare explicitly
- `color` — one of `cyan`, `blue`, `magenta`, `yellow`, `green`, `red`; visual label in UI
- `tools` — string array; only tools the agent body actually needs
- `skills` — string array; `plugin-name:skill-name` format

**Best practice: include `<example>` blocks in description:**
```markdown
---
description: |
  Scans a directory for Claude Code artifact files. Use this agent when
  you need to discover commands, agents, skills, rules, or hooks. Also
  triggers on "inventory NL files" or "find plugin components".

  <example>
  Context: User asks to audit a plugin repo
  user: find all the agent files in this plugin
  assistant: I'll scan the directory structure for agent markdown files...
  </example>

  <example>
  Context: Command invokes scanner as sub-agent
  user: /scan
  assistant: Invoking scanner agent to discover NL artifacts...
  </example>
model: haiku
color: cyan
tools: ["Glob", "Read"]
skills: ["nlpm:conventions"]
---
```

Two or more `<example>` blocks with diverse scenarios is the minimum for reliable triggering.

---

## 5. Skill Structure

Skills provide reference knowledge to agents and commands.

**Path conventions:**
- Single plugin skill: `skills/<name>/SKILL.md`
- Multi-skill plugin: `skills/<plugin>/<name>/SKILL.md`

**Frontmatter:**
- `name` — string (required)
- `description` — string (required); used for discovery and triggering
- `version` — semver string (optional)
- `globs` — string array (optional); file patterns this skill applies to

**Body rules:**
- Under 500 lines — exceeding this creates context bloat
- Reference material only — no imperative instructions (those belong in commands/agents)
- Include a scope note: what this skill covers and what it does NOT cover
- Cross-reference related skills with their `plugin:skill` identifiers

**Supporting directories (optional):**
- `references/` — external docs, specifications, examples
- `examples/` — concrete worked examples
- `scripts/` — helper scripts referenced by hooks or commands

---

## 6. Rules

Rules live in `.claude/rules/<name>.md`.

**Frontmatter:**
- `description` — string (required); summary shown in rule lists
- `paths` — string array (optional); glob patterns scoping which files this rule applies to

**Body format:**
- Lead with a **bold imperative**: `**Always do X.**` or `**Use Y instead of Z.**`
- Follow immediately with rationale: "Because W, using X ensures..."
- Be specific and testable — vague rules cannot be linted or enforced
- State what to DO, not only what to avoid (Pink Elephant effect: prohibitions without alternatives are ignored)

**Budget:** Under 500 lines total per rules file.

**Naming convention for ordered sets:** `NN-kebab-name.md` (e.g. `01-formatting.md`, `02-naming.md`)

**Example:**
```markdown
---
description: "Always use kebab-case for file and plugin names"
paths: ["**/*.json", "**/*.md"]
---

**Use kebab-case for all file and plugin names.**

Because Claude Code resolves plugin references by exact string match, inconsistent casing
causes lookup failures. `my-plugin` and `MyPlugin` are treated as different identifiers.

Correct: `my-plugin`, `tdd-guardian`, `echo-sleuth`
Incorrect: `myPlugin`, `MyPlugin`, `my_plugin`
```

---

## 7. Hook Events

Hook events are **case-sensitive**. Using wrong case silently ignores the hook.

**Available events:**
| Event | Trigger |
|-------|---------|
| `PreToolUse` | Before any tool call |
| `PostToolUse` | After successful tool call |
| `PostToolUseFailure` | After failed tool call |
| `PermissionRequest` | When Claude requests permission |
| `UserPromptSubmit` | When user submits a prompt |
| `Stop` | When main agent stops |
| `SubagentStop` | When sub-agent stops |
| `SessionStart` | Session initialization |
| `SessionEnd` | Session teardown |
| `PreCompact` | Before context compaction |
| `Notification` | On notification events |
| `InstructionsLoaded` | After instructions load |

**Hook types:** `command`, `prompt`, `agent`

**Matcher:** Regex pattern matched against the tool name (for tool hooks). Empty string matches all.

**Permission decision output** (for `PermissionRequest` hooks):
```json
{
  "hookSpecificOutput": {
    "permissionDecision": "allow",
    "permissionDecisionReason": "This tool call is safe because..."
  }
}
```
`permissionDecision` values: `"allow"` or `"deny"`

---

## 8. hooks.json Format

Located at `.claude/hooks.json` or path specified in `plugin.json`.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/pre-write-check.sh"
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "You are now in strict TDD mode. No production code without a failing test."
          }
        ]
      }
    ]
  }
}
```

**Structure rules:**
- Top-level key: `"hooks"`
- Second-level keys: event names (case-sensitive)
- Each event maps to an array of matcher objects
- Each matcher object: `{ "matcher": "<regex>", "hooks": [...] }`
- Each hook object: `{ "type": "command"|"prompt"|"agent", "<type-field>": "..." }` where the field name matches the type: `"command"` for type `command`, `"prompt"` for type `prompt`, `"agent"` for type `agent`

---

## 9. General Prompt Engineering

**Layer order** (imperative for complex prompts):
1. Role/persona — "You are a strict code reviewer..."
2. Context — relevant background, project state, constraints
3. Task — specific action to perform
4. Constraints — what to avoid, limits, edge cases
5. Output format — exact structure of the response

**Few-shot examples:** Include 2+ concrete input→output examples for any complex judgment task. Examples dramatically improve consistency.

**Positive framing:** State what to do. "Use imperative verbs" beats "Don't use passive voice." The brain processes prohibitions poorly under inference load (Pink Elephant effect).

**Explicit output format:** Every command and agent body should define exactly what the output should look like — section names, table formats, score displays, etc.

---

## 10. Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| File names | kebab-case | `tdd-guardian.md`, `pre-write-check.sh` |
| Plugin names | kebab-case | `nlpm`, `echo-sleuth` |
| Skill references | `plugin-name:skill-name` | `nlpm:conventions`, `tdd-guardian:rules` |
| Rule files (ordered) | `NN-kebab.md` | `01-formatting.md` |
| Environment variable | SCREAMING_SNAKE | `CLAUDE_PLUGIN_ROOT` |

**Portable paths:** Always use `${CLAUDE_PLUGIN_ROOT}` when referencing files within a plugin (scripts, configs). Hardcoded absolute paths break portability.

---

## 11. Reference Syntax

**Commands referencing shared partials:**
```
<!-- Include: commands/shared/discover.md -->
```
Or by instruction: "Follow the steps in commands/shared/discover.md"

**Agents referencing skills in frontmatter:**
```yaml
skills: ["nlpm:conventions", "nlpm:patterns"]
```

**Hooks referencing scripts:**
```json
"command": "${CLAUDE_PLUGIN_ROOT}/scripts/check.sh"
```

**Cross-plugin skill references** use the same `plugin:skill` format. The plugin must be installed for the reference to resolve.

---

## 12. Memory File Conventions

Memory files are `.md` files that Claude Code writes and reads as persistent per-project knowledge.

**Location:**
```
~/.claude/projects/<project-slug>/memory/
```

**Index file:** `MEMORY.md` lives at the same level as individual memory files. It is a one-line-per-entry index, not a memory file itself. Each line references one memory file by filename.

**Individual memory files** MUST include YAML frontmatter:

```yaml
---
name: "short identifier"
description: "one-line summary of what this memory contains"
type: user | feedback | project | reference
---
```

**`type` values:**
| Value | Meaning |
|-------|---------|
| `user` | Preferences, habits, or facts about the user |
| `feedback` | Corrections or lessons from past sessions |
| `project` | Project-specific facts, decisions, or context |
| `reference` | External reference material copied into memory |

**Rules:**
- Every memory file must appear in `MEMORY.md` — orphaned files (present in the directory but not in the index) are flagged by the linter
- `MEMORY.md` itself is the index; it does not need frontmatter and is not scored as a memory file
- Memory files should not reference other files or functions that have since been deleted — stale references reduce the signal-to-noise ratio of the memory store

---

## Scope Note

This skill covers Claude Code plugin component schemas and conventions. It does NOT cover:
- Scoring/quality rubric → see `nlpm:scoring`
- Anti-patterns and best practices catalog → see `nlpm:patterns`
- General software engineering conventions outside Claude Code artifacts
