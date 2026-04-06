---
name: security
description: Security pattern database for Claude Code plugin audits. Covers execution surfaces, supply chain, data exfiltration, and prompt injection.
version: 0.1.0
---

# Security Scan Patterns for Claude Code Plugins

## Execution Surfaces

Claude Code plugins have five execution surfaces that must be scanned:

| Surface | Files | Risk Level | Why |
|---------|-------|------------|-----|
| Hooks | `hooks/hooks.json`, referenced scripts | Critical | Runs on EVERY tool call automatically |
| Scripts | `scripts/*.sh`, `*.py`, `*.js` | High | Executed by commands/agents |
| MCP Servers | `.mcp.json` | High | Network access, data flow |
| Bash in commands | `commands/*.md` with Bash tool | Medium | Shell execution via Claude |
| Install scripts | `package.json` postinstall, setup scripts | Medium | Runs on install |

## Dangerous Shell Patterns

### Critical (immediate risk)

| Pattern | Regex | Why |
|---------|-------|-----|
| Pipe to shell | `curl.*\|.*sh`, `wget.*\|.*bash` | Remote code execution |
| Eval with variables | `eval\s+["']?\$` | Arbitrary code execution |
| Reverse shell | `bash\s+-i\s+>&`, `/dev/tcp/` | Backdoor |
| Base64 decode and exec | `base64.*\|.*sh`, `base64.*\|.*python` | Obfuscated execution |
| SSH key exfiltration | `cat.*\.ssh/`, `scp.*\.ssh/` | Key theft |
| Token exfiltration | Secrets like GITHUB_TOKEN or API keys sent to curl/wget | Credential theft |

### High (likely dangerous)

| Pattern | Regex | Why |
|---------|-------|-----|
| Subprocess with shell=True | `subprocess\.(call\|run\|Popen).*shell\s*=\s*True` | Python shell injection |
| OS system calls | `os\.system\(` | Python shell execution |
| Dynamic require/import | `require\(\s*\$`, `import\(\s*\$` | Dynamic code loading |
| File write outside repo | `> ~/`, `> /etc/`, `> /tmp/.*\.sh` | System modification |
| Sudo usage | `sudo\s+` | Privilege escalation |
| PATH modification | Appending to bashrc, zshrc, or profile | Persistent system modification |

### Medium (context-dependent)

| Pattern | Regex | Why |
|---------|-------|-----|
| Network calls | `curl\s+`, `wget\s+`, `fetch\(`, `requests\.(get\|post)` | Data exfiltration potential |
| Environment access | `process\.env`, `os\.environ`, shell variable expansion | Sensitive data access |
| File reads outside repo | Reading from home directory or system paths | Data access |
| Runtime package install | `npm install`, `pip install`, `gem install` | Supply chain risk |
| Shell exec functions | Functions that execute strings as shell commands | Shell execution |

## MCP Configuration Risks

Scan `.mcp.json` for:

| Risk | Check | Severity |
|------|-------|----------|
| Remote servers | `url` field pointing to non-localhost | High |
| Unknown domains | Domain not in known-safe list | High |
| Broad permissions | `permissions` with wildcard or extensive list | Medium |
| File system access | Server with `fs` or `filesystem` capability | Medium |
| Shell access | Server with `shell` or execution capability | Critical |
| Missing auth | Remote server without `auth` field | High |

Known-safe MCP domains: `localhost`, `127.0.0.1`, `modelcontextprotocol.io`, `github.com`, `api.anthropic.com`

## Hook Safety Rules

Scan `hooks/hooks.json` for:

| Risk | Check | Severity |
|------|-------|----------|
| Hook runs shell script | `command` field references `.sh`, `.py`, `.js` | Medium (must scan the script) |
| Hook uses user input | Script receives prompt or input variables without sanitization | High |
| Hook on every event | Triggers on PreToolUse or PostToolUse without tool filter | Medium |
| Hook modifies files | Script writes to disk on every tool call | Medium |
| Hook makes network calls | Script contains network request commands | High |

## Dependency Supply Chain

Scan `package.json` for:

| Risk | Check | Severity |
|------|-------|----------|
| postinstall scripts | `scripts.postinstall` exists | High |
| preinstall scripts | `scripts.preinstall` exists | High |
| Git URL dependencies | Deps pointing to git URLs | Medium |
| Unpinned versions | Wildcard or "latest" version | Medium |

Scan `requirements.txt` / `pyproject.toml` for:

| Risk | Check | Severity |
|------|-------|----------|
| Git URL deps | git+https or git+ssh URLs | Medium |
| Unpinned | No version pin | Low |
| Direct URL | HTTP download URLs | High |

## Prompt Injection Surfaces

| Risk | Check | Severity |
|------|-------|----------|
| Untrusted file content in prompts | Agent reads arbitrary file then uses content in Bash | High |
| User input passed to shell | Command takes arguments and passes to Bash without sanitization | Critical |
| Template expansion | Variable expansion in hook scripts with user-controlled values | High |

## Severity Definitions

| Severity | Meaning | Action |
|----------|---------|--------|
| Critical | Immediate exploitation risk: RCE, credential theft, backdoor | Block contribution, file security issue |
| High | Likely dangerous: shell injection, data exfil, privilege escalation | Block contribution, report in audit |
| Medium | Context-dependent: network calls, env access, runtime installs | Report in audit, flag for review |
| Low | Minor concern: unpinned deps, broad permissions | Report as informational |

## Report Format

The security scan section in an audit report follows this structure:

```
## Security Scan

| Severity | Count |
|----------|-------|
| Critical | N |
| High | N |
| Medium | N |
| Low | N |

### Findings

| # | Severity | File | Line | Pattern | Description |
|---|----------|------|------|---------|-------------|
```

## Risk Gate

If any Critical or High findings exist, the `contribute-approved` label must NOT be applied. The audit report must include a prominent warning and the tracking issue must link to the security findings.
