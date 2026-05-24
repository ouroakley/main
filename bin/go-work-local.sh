#!/usr/bin/env bash
# Maintain a local-only go.work so organiser modules resolve from ../organisers
# (gitignored). Safe no-op when ../organisers is missing (e.g. main-only clone).
set -euo pipefail

MAIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$MAIN_ROOT"

if [[ ! -d ../organisers ]]; then
  echo "go-work-local: ../organisers not found — skipping go.work (clone-only layout)." >&2
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/resolve-organiser-requires-to-tip-of-main.sh" apply

go_ver="$(grep '^go ' go.mod | awk '{print $2}')"
if [[ -z "$go_ver" ]]; then
  echo "go-work-local: could not read go version from go.mod" >&2
  exit 1
fi

if [[ ! -f go.work ]]; then
  go work init .
fi

go work use -r ../organisers
go work edit -go="$go_ver"
