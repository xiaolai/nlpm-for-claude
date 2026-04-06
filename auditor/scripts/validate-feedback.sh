#!/bin/bash
# Validate feedback/log.json integrity before it's used for any decision.
# Catches corruption, hallucinated stats, and drift from reality.

LOG="auditor/feedback/log.json"

if [ ! -f "$LOG" ]; then
  echo "WARN: No feedback log found"
  exit 0
fi

ERRORS=0

# Check 1: Valid JSON
if ! jq empty "$LOG" 2>/dev/null; then
  echo "ERROR: feedback/log.json is not valid JSON"
  exit 1
fi

# Check 2: Required structure
for key in events rule_stats metadata; do
  if ! jq -e ".$key" "$LOG" >/dev/null 2>&1; then
    echo "ERROR: missing required key '$key'"
    ERRORS=$((ERRORS + 1))
  fi
done

# Check 3: Rule stats reference real rules (R01-R50)
INVALID_RULES=$(jq -r '.rule_stats | keys[]' "$LOG" 2>/dev/null | grep -vE '^R[0-5][0-9]$' || true)
if [ -n "$INVALID_RULES" ]; then
  echo "ERROR: feedback log references invalid rules: $INVALID_RULES"
  ERRORS=$((ERRORS + 1))
fi

# Check 4: Counts are non-negative integers
NEGATIVE=$(jq '[.rule_stats[].total_hits, .metadata.total_prs_submitted, .metadata.total_prs_merged, .metadata.total_prs_rejected] | map(select(. < 0)) | length' "$LOG" 2>/dev/null || echo 0)
if [ "$NEGATIVE" -gt 0 ]; then
  echo "ERROR: negative counts in feedback log"
  ERRORS=$((ERRORS + 1))
fi

# Check 5: merged + rejected <= submitted
SUBMITTED=$(jq '.metadata.total_prs_submitted // 0' "$LOG")
MERGED=$(jq '.metadata.total_prs_merged // 0' "$LOG")
REJECTED=$(jq '.metadata.total_prs_rejected // 0' "$LOG")
if [ $((MERGED + REJECTED)) -gt "$SUBMITTED" ]; then
  echo "ERROR: merged ($MERGED) + rejected ($REJECTED) > submitted ($SUBMITTED)"
  ERRORS=$((ERRORS + 1))
fi

if [ "$ERRORS" -gt 0 ]; then
  echo "FAILED: $ERRORS validation error(s)"
  exit 1
fi

echo "Feedback log valid: $SUBMITTED submitted, $MERGED merged, $REJECTED rejected"
exit 0
