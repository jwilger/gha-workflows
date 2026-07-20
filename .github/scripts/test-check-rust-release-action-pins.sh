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

if ! awk '
  /^      release-plz-version:$/ { in_input = 1; next }
  in_input && /^      [^ ]/ { exit !found }
  in_input && /default: "0.3.159"/ { found = 1 }
  END { exit !found }
' .github/workflows/rust-release-plz.yml; then
  echo 'shared workflow does not select the release-plz CLI version supported by the pinned action' >&2
  exit 1
fi
