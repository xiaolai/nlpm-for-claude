# NLPM Audit: hashicorp/agent-skills
**Date**: 2026-04-06  |  **Artifacts**: 21  |  **Strategy**: batched
**NL Score**: 98/100
**Security**: CLEAR
**Bugs**: 1  |  **Quality Issues**: 18  |  **Security Findings**: 3

## NL Score Summary
| File | Type | Score | Top Issue |
|------|------|-------|-----------|
| terraform/code-generation/skills/terraform-search-import/SKILL.md | skill | 90 | Broken reference to `./scripts/list_resources.sh` (file does not exist) |
| terraform/provider-development/skills/provider-actions/SKILL.md | skill | 92 | 4 vague quantifiers: "meaningful", "when relevant", "appropriate" (×2) |
| terraform/module-generation/skills/refactor-module/SKILL.md | skill | 92 | 4 vague quantifiers: "well-structured", "clear", "proper", "appropriate" |
| terraform/code-generation/skills/terraform-style-guide/SKILL.md | skill | 96 | 2 vague quantifiers: "meaningful", "where applicable" |
| terraform/module-generation/skills/terraform-stacks/SKILL.md | skill | 96 | 2 vague quantifiers: "descriptive", "logical" |
| packer/hcp/skills/push-to-registry/SKILL.md | skill | 96 | 2 vague quantifiers: "meaningful", "minimal" |
| terraform/code-generation/skills/azure-verified-modules/SKILL.md | skill | 98 | 1 vague quantifier: "adequate" |
| terraform/code-generation/skills/terraform-test/SKILL.md | skill | 98 | 1 vague quantifier: "specific enough" |
| terraform/provider-development/skills/run-acceptance-tests/SKILL.md | skill | 98 | 1 vague quantifier: "securely" |
| terraform/provider-development/skills/provider-resources/SKILL.md | skill | 98 | 1 vague quantifier: "appropriate" |
| terraform/provider-development/skills/provider-docs/SKILL.md | skill | 100 | None |
| terraform/provider-development/skills/new-terraform-provider/SKILL.md | skill | 100 | None |
| terraform/provider-development/skills/provider-test-patterns/SKILL.md | skill | 100 | None |
| packer/builders/skills/azure-image-builder/SKILL.md | skill | 100 | None |
| packer/builders/skills/windows-builder/SKILL.md | skill | 100 | None |
| packer/builders/skills/aws-ami-builder/SKILL.md | skill | 100 | None |
| terraform/code-generation/.claude-plugin/plugin.json | plugin manifest | 100 | None |
| terraform/provider-development/.claude-plugin/plugin.json | plugin manifest | 100 | None |
| terraform/module-generation/.claude-plugin/plugin.json | plugin manifest | 100 | None |
| packer/hcp/.claude-plugin/plugin.json | plugin manifest | 100 | None |
| packer/builders/.claude-plugin/plugin.json | plugin manifest | 100 | None |

## Security Scan
| Severity | Count |
|----------|-------|
| Critical | 0 |
| High | 0 |
| Medium | 2 |
| Low | 1 |

### Execution Surface Inventory
| Surface | Files |
|---------|-------|
| Hooks | None |
| Scripts | `scripts/validate-structure.sh` |
| MCP configs | `terraform/code-generation/.claude-plugin/plugin.json` (inline), `terraform/module-generation/.claude-plugin/plugin.json` (inline) |
| Package manifests | None |

### Security Findings
| # | Severity | File | Line | Pattern | Description |
|---|----------|------|------|---------|-------------|
| 1 | Medium | terraform/code-generation/.claude-plugin/plugin.json | 19–21 | Environment variable pass-through to container | MCP server runs `docker run hashicorp/terraform-mcp-server` with `-e TFE_TOKEN -e TFE_ADDRESS`. TFE_TOKEN is a Terraform Enterprise API credential. Passing it to a Docker container is expected for this use-case, but the token scope and container image provenance should be documented/verified. |
| 2 | Medium | terraform/module-generation/.claude-plugin/plugin.json | 19–21 | Environment variable pass-through to container | Same pattern as finding #1: same MCP server config, same credential exposure. |
| 3 | Low | packer/builders/skills/windows-builder/SKILL.md | 107 | curl-pipe-to-shell equivalent (PowerShell) | Example code uses `iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))` — the PowerShell equivalent of `curl \| sh`. Appears in a documentation example, not an executable artifact. No integrity check (checksum/signature) is shown. Could mislead users into adopting the pattern without verification. |

## Bugs (PR-worthy)
| # | File | Issue | Impact |
|---|------|-------|--------|
| 1 | terraform/code-generation/skills/terraform-search-import/SKILL.md | Lines 30–31 and 55–57 reference `./scripts/list_resources.sh`, which does not exist in the repository. Only `scripts/validate-structure.sh` is present. | Users following the "IMPORTANT: Check Provider Support First" instruction will immediately hit a missing-file error; the primary recommended workflow is broken. |

## Security Fixes (PR-worthy, Medium/Low only)
| # | File | Issue | Suggested Fix |
|---|------|-------|---------------|
| 1 | terraform/code-generation/.claude-plugin/plugin.json | TFE_TOKEN passed to Docker container with no documentation of required scope or image trust. | Add a `README` or inline comment documenting the minimum required token permissions and confirming that `hashicorp/terraform-mcp-server` is the official image. Pin the image to a digest or explicit version tag. |
| 2 | terraform/module-generation/.claude-plugin/plugin.json | Same as finding #1 — identical MCP config block. | Same fix as above. |
| 3 | packer/builders/skills/windows-builder/SKILL.md | PowerShell `iex` + `DownloadString` Chocolatey install example lacks integrity guidance. | Add a comment noting users should verify the Chocolatey install script URL and consider using the official signed installer or checking a checksum before running `iex`. |

## Quality Issues (informational)
| # | File | Issue | Penalty |
|---|------|-------|---------|
| 1 | terraform/provider-development/skills/provider-actions/SKILL.md | "Provide meaningful progress messages" — "meaningful" is a vague quantifier | -2 |
| 2 | terraform/provider-development/skills/provider-actions/SKILL.md | "Include API error details when relevant" — "when relevant" is a vague quantifier | -2 |
| 3 | terraform/provider-development/skills/provider-actions/SKILL.md | "Use appropriate error types" — "appropriate" is a vague quantifier | -2 |
| 4 | terraform/provider-development/skills/provider-actions/SKILL.md | "Use appropriate nested object types" — "appropriate" is a vague quantifier | -2 |
| 5 | terraform/module-generation/skills/refactor-module/SKILL.md | "well-structured modules" in description — "well-structured" is vague | -2 |
| 6 | terraform/module-generation/skills/refactor-module/SKILL.md | "Clear interface contracts" — "clear" is a vague quantifier | -2 |
| 7 | terraform/module-generation/skills/refactor-module/SKILL.md | "Proper encapsulation and abstraction" — "proper" is a vague quantifier | -2 |
| 8 | terraform/module-generation/skills/refactor-module/SKILL.md | "Organize into appropriate files" — "appropriate" is a vague quantifier | -2 |
| 9 | terraform/code-generation/skills/terraform-style-guide/SKILL.md | "Be specific and meaningful" — "meaningful" is a vague quantifier | -2 |
| 10 | terraform/code-generation/skills/terraform-style-guide/SKILL.md | "Configure private networking where applicable" — "where applicable" is a vague quantifier | -2 |
| 11 | terraform/module-generation/skills/terraform-stacks/SKILL.md | "Use descriptive names for components and deployments" — "descriptive" is a vague quantifier | -2 |
| 12 | terraform/module-generation/skills/terraform-stacks/SKILL.md | "Create components for logical infrastructure units" — "logical" is a vague quantifier | -2 |
| 13 | packer/hcp/skills/push-to-registry/SKILL.md | "Meaningful labels — Use for versions, teams, compliance" — "meaningful" is a vague quantifier | -2 |
| 14 | packer/hcp/skills/push-to-registry/SKILL.md | "adding minimal overhead (<1 minute)" — "minimal" is a vague quantifier (partially mitigated by the time bound) | -2 |
| 15 | terraform/code-generation/skills/azure-verified-modules/SKILL.md | "`any` MAY only be used with adequate reasons" — "adequate" is a vague quantifier | -2 |
| 16 | terraform/code-generation/skills/terraform-test/SKILL.md | "Make them specific enough to diagnose failures" — "specific enough" is a vague quantifier | -2 |
| 17 | terraform/provider-development/skills/run-acceptance-tests/SKILL.md | "suggest how to set up these environment variables securely" — "securely" is a vague quantifier | -2 |
| 18 | terraform/provider-development/skills/provider-resources/SKILL.md | "Plan modifiers are appropriate" in checklist — "appropriate" is a vague quantifier | -2 |

## Cross-Component
- **Broken script reference**: `terraform-search-import/SKILL.md` references `./scripts/list_resources.sh` at two locations (lines 30–31 and 55–57). This script does not exist; only `scripts/validate-structure.sh` is present in the repo. Severity: BUG — blocks the primary recommended workflow.
- **Unverified `references/` sub-documents**: Several skills delegate detail to relative `references/` files (`MOCK_PROVIDERS.md`, `CI_CD.md`, `EXAMPLES.md`, `checks.md`, `sweepers.md`, `ephemeral.md`, `hashicorp-provider-docs.md`, `component-blocks.md`, `deployment-blocks.md`, etc.). These were not in the audit manifest and could not be verified; if they are missing, the delegation instructions ("Read the relevant reference file when…") will silently fail. Recommend including them in future audit runs.
- **refactor-module external URLs**: The "Related Skills" section uses raw `githubusercontent.com` absolute URLs to reference other skills in the same repository. These will break on forks or repo renames; relative paths (e.g., `../../code-generation/skills/terraform-style-guide/SKILL.md`) would be more resilient.
- **MCP server duplication**: The identical `mcpServers.terraform` block appears in both `terraform-code-generation` and `terraform-module-generation` plugin manifests. No functional conflict, but the duplication means any change (e.g., pinning a Docker image version) must be applied in two places.
- **No hooks or commands detected**: All five plugins expose only skills. No command or agent NL artifacts are present; the agent/command scoring criteria (examples, model declaration, allowed-tools) do not apply.

## Recommendation
CLEAR — submit PRs for all bugs and medium/low security fixes.

**Priority order:**
1. **Bug fix** (high impact): Add `scripts/list_resources.sh` to the repository or update `terraform-search-import/SKILL.md` to remove the reference and redirect users to the manual discovery workflow. The current state breaks the skill's primary instruction.
2. **Medium security** (low effort): Pin the `hashicorp/terraform-mcp-server` Docker image to an explicit digest or version tag in both plugin manifests, and document the minimum TFE_TOKEN scope.
3. **Low security** (documentation): Add an integrity note to the Chocolatey install example in `windows-builder/SKILL.md`.
4. **Quality** (optional polish): Replace the 18 vague quantifiers with specific, measurable language — particularly in `provider-actions`, `refactor-module`, and `terraform-style-guide` where vague terms cluster.
