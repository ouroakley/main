#!/usr/bin/env bash
# Run hugo with HUGO_MODULE_WORKSPACE when main/go.work exists (local monorepo).
# Restores branch-main go.mod after Hugo (see resolve-organiser-requires-to-tip-of-main.sh).
set -euo pipefail

MAIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BIN_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$MAIN_ROOT"

"$BIN_DIR/resolve-organiser-requires-to-tip-of-main.sh" apply
"$BIN_DIR/go-work-local.sh"

if [[ -f "$MAIN_ROOT/go.work" ]]; then
  export HUGO_MODULE_WORKSPACE="$MAIN_ROOT/go.work"
else
  echo "hugo-with-local-workspace: go.work missing (no ../organisers?); running hugo without HUGO_MODULE_WORKSPACE." >&2
fi

set +e
hugo "$@"
ec=$?
set -e
"$BIN_DIR/resolve-organiser-requires-to-tip-of-main.sh" restore
exit "$ec"
