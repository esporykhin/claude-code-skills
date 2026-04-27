#!/usr/bin/env bash
# Список проектов с приложениями и compose внутри.
# Usage: project-list.sh [--ids-only]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

ids_only=0
[[ "${1:-}" == "--ids-only" ]] && ids_only=1

raw="$(dokploy_request GET project.all)"
if [[ $ids_only -eq 1 ]]; then
  echo "$raw" | jq -r '.[] | "\(.projectId)\t\(.name)"'
else
  echo "$raw" | jq .
fi
