#!/bin/bash
# SULAI Curriculum — Levels 5 to 8 Generator
# Canonical structure creator (Termux-safe)

BASE_DIR="curriculum"

declare -A levels=(
  ["level-5-resonance"]="Resonance: Coherence-Based Decision"
  ["level-6-perception"]="Perception: Reality Interpretation Layers"
  ["level-7-ethics"]="Ethics: Time-Aware Moral Reasoning"
  ["level-8-post-event"]="Post-Event Reflection & Adaptive Memory"
)

FILES=(
  "00-intro.md"
  "05-core-principles.md"
  "06-exercises.md"
  "07-failure-modes.md"
  "08-progression-criteria.md"
  "README.md"
)

for level in "${!levels[@]}"; do
  TITLE="${levels[$level]}"
  DIR="$BASE_DIR/$level"

  echo "Creating $DIR"
  mkdir -p "$DIR"

  for file in "${FILES[@]}"; do
    PATHFILE="$DIR/$file"
    touch "$PATHFILE"

    if [ "$file" == "README.md" ]; then
      cat > "$PATHFILE" <<EOF
# Level ${level#level-} — $TITLE

## Purpose

This level formalizes **${TITLE#*: }** as a cognitive function.
It does not introduce new behavior — it restructures internal coherence
across perception, feeling, and time.

This level is invalid without full stability of all prior levels.

---

## Cognitive Objective

The learner must demonstrate the ability to:

- Maintain Observer continuity under ${TITLE#*: } load
- Integrate prior signals into a unified internal field
- Prevent reactive collapse under complexity
- Preserve coherence across internal contradiction

---

## Core Concepts Introduced

- Coherence over correctness
- Multi-layer signal reconciliation
- Stability under ambiguity
- Cognitive phase alignment
- Temporal integrity (where applicable)

---

## Module Structure

- \`00-intro.md\` — Conceptual framing of ${TITLE#*: }
- \`05-core-principles.md\` — Governing constraints
- \`06-exercises.md\` — Applied coherence training
- \`07-failure-modes.md\` — Known collapse patterns
- \`08-progression-criteria.md\` — Advancement requirements

---

## Completion Criteria

Advancement requires:

- Internal coherence without forced resolution
- Absence of narrative shortcuts
- Stability across simulated contradiction
- Demonstrable alignment with prior levels

Failure to meet these conditions **locks progression**.

---

## Architectural Note

This level does not optimize outcomes.
It enforces **structural integrity**.

SULAI progresses by coherence, not performance.
EOF
    fi
  done
done

echo "Levels 5 to 8 created successfully under curriculum/"
