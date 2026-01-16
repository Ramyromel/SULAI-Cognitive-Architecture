#!/bin/bash
# SULAI Curriculum → Auto-Setup Levels 3-10
# Author: Ibrahim Ghonem
# Purpose: Automatically create folders, activities, and proof files for Levels 3–10

# Base directories
ACT_DIR="activities"
PROOF_DIR="proofs"

# Ensure base directories exist
mkdir -p "$ACT_DIR"
mkdir -p "$PROOF_DIR"

# Levels range
for level in {3..10}; do
    LEVEL_NAME="level-$level"
    
    # Create directories for activities and proofs
    mkdir -p "$ACT_DIR/$LEVEL_NAME"
    mkdir -p "$PROOF_DIR/$LEVEL_NAME"

    # Create Activity files
    for act in {1..3}; do
        ACT_FILE="$ACT_DIR/$LEVEL_NAME/Activity_${level}.${act}.md"
        if [ ! -f "$ACT_FILE" ]; then
            cat > "$ACT_FILE" <<EOL
# Activity ${level}.${act} — [Title Placeholder]

## Scenario Description
[وصف الحدث]

## Steps / Execution
Step 1:
Step 2:
Step 3:

## Insight / Reflection
[ما الذي تعلمته؟]

## Success Criteria
- وضوح العملية
- تطبيق منهجي
- نتائج قابلة للتحقق
EOL
        fi
    done

    # Create Proof file
    PROOF_FILE="$PROOF_DIR/$LEVEL_NAME/Level_${level}_Proof.md"
    if [ ! -f "$PROOF_FILE" ]; then
        cat > "$PROOF_FILE" <<EOL
# Level $level — Proof Template

Candidate ID:
Date:

## Completed Activities
- Activity ${level}.1 ✔
- Activity ${level}.2 ✔
- Activity ${level}.3 ✔

## Core Insight
[أهم إدراك توصّل إليه المتعلّم]

## Consistency Check
- Steps aligned ✔
- Cause-Effect logical ✔
- Timing / Relevance ✔

## Declaration
I confirm this proof reflects my own cognitive work.

Signature:
EOL
    fi

done

echo "✅ All Levels 3–10 directories, activities, and proof files have been created."
