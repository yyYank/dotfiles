#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SRC_DIR="$REPO_ROOT/codex"
DST_DIR="$HOME/.codex"

if [ ! -f "$SRC_DIR/AGENTS.md" ]; then
  echo "missing: $SRC_DIR/AGENTS.md" >&2
  exit 1
fi

mkdir -p "$DST_DIR" "$DST_DIR/rules" "$DST_DIR/skills"

cp "$SRC_DIR/AGENTS.md" "$DST_DIR/AGENTS.md"

if [ -d "$SRC_DIR/rules" ]; then
  cp -R "$SRC_DIR/rules/." "$DST_DIR/rules/"
fi

if [ -d "$SRC_DIR/skills" ]; then
  cp -R "$SRC_DIR/skills/." "$DST_DIR/skills/"
fi

echo "Synced Codex config to $DST_DIR"
echo "- AGENTS.md"
echo "- rules/"
echo "- skills/"
