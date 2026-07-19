#!/usr/bin/env bash
set -euo pipefail

fixture=$(mktemp)
trap 'rm -f "$fixture"' EXIT

printf '%s\n' 'steps:' '  - uses : owner/action@v1' > "$fixture"

if .github/scripts/check-rust-release-action-pins.sh "$fixture" 2>/dev/null; then
  echo 'checker accepted a mutable reference with whitespace before the colon' >&2
  exit 1
fi

printf '%s\n' 'steps:' '  - "uses": owner/action@v1' > "$fixture"

if .github/scripts/check-rust-release-action-pins.sh "$fixture" 2>/dev/null; then
  echo 'checker accepted a mutable reference behind a quoted YAML key' >&2
  exit 1
fi
