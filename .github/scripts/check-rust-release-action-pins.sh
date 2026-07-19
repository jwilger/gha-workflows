#!/usr/bin/env bash
set -euo pipefail

workflow=${1:-.github/workflows/rust-release-plz.yml}
status=0

while IFS= read -r reference; do
  revision=${reference##*@}
  if [[ ! $revision =~ ^[0-9a-f]{40}$ ]]; then
    printf 'mutable action reference: %s\n' "$reference" >&2
    status=1
  fi
done < <(grep -oE '[[:alnum:]_.-]+/[[:alnum:]_.-]+@[[:alnum:]_./-]+' "$workflow" || true)

exit "$status"
