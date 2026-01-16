#!/bin/bash
# Script to create Level 3 and Level 4 SULAI curriculum structure

declare -A levels=(
  ["level-3-time"]="Time: Temporal Cognition"
  ["level-4-emotional-mass"]="Emotional Mass: Decision Weight Formation"
)

for level in "${!levels[@]}"; do
  title="${levels[$level]}"
  echo "Creating $level - $title"
  
  # إنشاء المجلد
  mkdir -p "$level"
  
  # الملفات
  files=("00-intro.md" "05-core-principles.md" "06-exercises.md" "07-failure-modes.md" "08-progression-criteria.md" "README.md")
  
  for file in "${files[@]}"; do
    filepath="$level/$file"
    touch "$filepath"
    
    # محتوى افتراضي للـ README
    if [ "$file" == "README.md" ]; then
      cat > "$filepath" <<EOL
# $title

## Purpose

This level introduces **${title#*:}**.
It builds directly on prior levels to ensure cognitive continuity.

---

## Cognitive Objective

Learner must demonstrate:

- Understanding core concepts of ${title#*:}
- Applying observation and signal processing principles
- Maintaining stability of the Observer under new cognitive challenges

---

## Core Concepts Introduced

- Conceptual foundations of ${title#*:}
- Observer integration
- Signal and decision mapping
- Progression relevance for higher levels

---

## Module Structure

- 00-intro.md — Introduction to ${title#*:}
- 05-core-principles.md — Foundational rules
- 06-exercises.md — Applied exercises
- 07-failure-modes.md — Common breakdowns
- 08-progression-criteria.md — Conditions for progression

---

## Completion Criteria

Advancement requires:

- Demonstrated understanding of ${title#*:}
- Integration with prior level(s)
- Stable cognitive processing
- Successful completion of exercises

EOL
    fi
  done
done

echo "Levels 3 and 4 created successfully!"
