#!/usr/bin/env bash
# Expand organiser require lines from version "main" (committed policy) to the
# canonical pseudo-version for the current tip of each repo's main branch, so
# Go and Hugo can run. Use "restore" to put go.mod back and drop local go.work.
set -euo pipefail

MAIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$MAIN_ROOT"
BACKUP="$MAIN_ROOT/.go.mod.branch-main.backup"

organiser_modules_from_go_mod() {
  grep -E '^[[:space:]]*github.com/ouroakley/organiser-[^[:space:]]+[[:space:]]+main([[:space:]]|//)' go.mod \
    | awk '{print $1}' | sort -u
}

resolve_one() {
  local mod="$1"
  local go_ver="$2"
  local tmp
  tmp="$(mktemp -d "${TMPDIR:-/tmp}/ouroakley-pin.XXXXXX")"
  (
    cd "$tmp"
    printf 'module pinlookup\ngo %s\n' "$go_ver" > go.mod
    GOTOOLCHAIN="go${go_ver}" GOPRIVATE='github.com/ouroakley/*' GONOSUMDB='github.com/ouroakley/*' \
      go get "$mod@main"
    go list -m -f '{{.Version}}' "$mod"
  )
  rm -rf "$tmp"
}

case "${1:-}" in
  apply)
    if ! grep -qE '^[[:space:]]*github.com/ouroakley/organiser-[^[:space:]]+[[:space:]]+main([[:space:]]|//)' go.mod; then
      exit 0
    fi
    go_ver="$(grep '^go ' go.mod | awk '{print $2}')"
    if [[ -z "$go_ver" ]]; then
      echo "resolve-organiser-requires-to-tip-of-main: missing go directive in go.mod" >&2
      exit 1
    fi
    cp go.mod "$BACKUP"
    pins_file="$(mktemp "${TMPDIR:-/tmp}/ouroakley-pins.XXXXXX")"
    while IFS= read -r mod; do
      [[ -z "$mod" ]] && continue
      if ! ver="$(resolve_one "$mod" "$go_ver")"; then
        echo "resolve-organiser-requires-to-tip-of-main: failed to resolve $mod" >&2
        mv "$BACKUP" go.mod
        rm -f "$pins_file"
        exit 1
      fi
      printf '%s %s\n' "$mod" "$ver" >> "$pins_file"
    done < <(organiser_modules_from_go_mod)

    {
      echo "module github.com/ouroakley/main"
      echo ""
      echo "go $go_ver"
      echo ""
      echo "require ("
      sort "$pins_file" | while read -r mod ver; do
        printf '\t%s %s // indirect\n' "$mod" "$ver"
      done
      echo ")"
    } > go.mod.tmp
    rm -f "$pins_file"
    mv go.mod.tmp go.mod
    ;;
  restore)
    if [[ -f "$BACKUP" ]]; then
      mv "$BACKUP" go.mod
    fi
    rm -f go.work go.work.sum
    ;;
  *)
    echo "usage: $0 apply|restore" >&2
    exit 2
    ;;
esac
