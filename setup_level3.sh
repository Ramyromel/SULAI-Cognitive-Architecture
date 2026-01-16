#!/bin/bash
# ============================================
# SULAI Curriculum — Level 3 Setup Script v1.0
# Author: Ibrahim Ghonem
# Purpose: Automate creation of Level 3 directories
#          Activities & Proofs with professional structure
# ============================================

set -euo pipefail

# ---------------------------
# Config
# ---------------------------
LEVEL="level-3-time"
ACT_DIR="activities/$LEVEL"
PROOF_DIR="proofs/$LEVEL"

# ---------------------------
# Create directories
# ---------------------------
mkdir -p "$ACT_DIR"
mkdir -p "$PROOF_DIR"

echo "✅ Directories created:"
echo "   - $ACT_DIR"
echo "   - $PROOF_DIR"

# ---------------------------
# Create Activities
# ---------------------------
declare -A activities=(
  ["Activity-3.1-Temporal-Mapping.md"]="Temporal Mapping"
  ["Activity-3.2-Delayed-Decision.md"]="Delayed Decision Simulation"
  ["Activity-3.3-Reverse-Causality.md"]="Reverse Causality Exercise"
)

for file in "${!activities[@]}"; do
  cat > "$ACT_DIR/$file" <<EOL2
# ${activities[$file]}

## Scenario / Decision Context
[الوصف التفصيلي للحدث أو القرار]

## Steps / Temporal Chain
Step -3:
Step -2:
Step -1:
Step 0:

## Insights / Analysis
[أهم النتائج والتحليلات]

## Success Criteria
- وضوح السلسلة الزمنية
- عدم القفز بين النتائج
- وجود نقطة كسر منطقية (Breakpoint)
- التحليل الزمني العميق لكل خطوة

EOL2
done

echo "✅ Activities files created in $ACT_DIR"

# ---------------------------
# Create Proof file
# ---------------------------
PROOF_FILE="$PROOF_DIR/Level-3-Temporal-Cognition-Proof.md"
cat > "$PROOF_FILE" <<EOL3
# Level 3 — Temporal Cognition Proof

Candidate ID: [أدخل رقم المعرف]
Date: $(date -u +"%Y-%m-%d %H:%M:%S UTC")

## Completed Activities
- Activity 3.1 ✔
- Activity 3.2 ✔
- Activity 3.3 ✔

## Core Temporal Insight
[أهم إدراك زمني توصّل إليه المتعلّم]

## Decision Map (Verified)
[خريطة زمنية واحدة كاملة]

## Temporal Consistency Check
- No contradiction ✔
- Cause-Effect alignment ✔
- Timing relevance ✔

## Declaration
I confirm this proof reflects my own cognitive work.

Signature:
EOL3

echo "✅ Proof file created at $PROOF_FILE"

# ---------------------------
# Final message
# ---------------------------
echo ""
echo "🎯 Level 3 structure fully prepared."
echo "Next steps:"
echo "  - Fill activities with content"
echo "  - Complete proof after executing all activities"
echo "  - Ready for GitHub / IPFS / NFT integration"
