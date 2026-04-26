#!/usr/bin/env bash
# Package the skill into a .skill file for upload to Claude.
#
# A .skill file is just a zip of the skill's directory (with the directory
# itself as the top-level folder inside the zip). The Claude.ai upload UI
# accepts this format directly.
#
# Usage: ./scripts/build.sh
# Output: leader-review.skill in the repo root.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_DIR="leader-review"
OUTPUT="$REPO_ROOT/leader-review.skill"

cd "$REPO_ROOT"

if [[ ! -d "$SKILL_DIR" ]]; then
    echo "❌ Skill directory '$SKILL_DIR' not found in $REPO_ROOT" >&2
    exit 1
fi

if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
    echo "❌ $SKILL_DIR/SKILL.md not found — is this a valid skill?" >&2
    exit 1
fi

echo "📦 Packaging $SKILL_DIR/ → leader-review.skill"

# Remove old artifact if present.
rm -f "$OUTPUT"

# Zip the skill directory. -r recursive, -X strips extra OS metadata.
# We exclude OS-specific junk and any local edits the user may have made.
zip -rX "$OUTPUT" "$SKILL_DIR" \
    -x "*.DS_Store" \
    -x "*/__pycache__/*" \
    -x "*.pyc" \
    > /dev/null

echo "✅ Built: $OUTPUT"
echo ""
echo "Next steps:"
echo "  1. Upload leader-review.skill in Claude.ai → Settings → Capabilities → Skills"
echo "  2. Add it to a Project, along with your leaders.json"
echo "  3. Open a new chat in that Project and try: \"Have my manager review this doc\""
