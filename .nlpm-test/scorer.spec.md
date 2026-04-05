---
artifact: agents/scorer.md
type: agent
min_score: 90
---

## Frontmatter Valid

Required fields:
- description: present and trigger-style with 3+ specific phrases
- model: sonnet
- tools: includes Read, Glob, Grep (no Write or Edit)
- skills: includes nlpm:scoring, nlpm:conventions

## Triggers On

Queries that SHOULD trigger this agent:

- "score this agent file"
- "check the quality of my skill"
- "what's the score of commands/fix.md"
- "run quality analysis on this plugin"
- "score all artifacts in this directory"
- "identify issues in this command file"

## Does Not Trigger On

Queries that should NOT trigger this agent:

- "discover all NL artifacts in this repo"
- "check cross-component consistency"
- "write a new agent for dependency scanning"
- "run my test specs"
- "count vague words in this file"

## Output Contains

Expected elements in the output:

- Score out of 100 (e.g., "85/100")
- Severity classification (HIGH, MEDIUM, LOW)
- Rule numbers (R01-R50)
- Line numbers for each issue
- Penalty values
- Suggested fixes
- Table format with columns for severity, rule, line, issue, penalty, fix
