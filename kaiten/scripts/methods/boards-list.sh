#!/bin/bash
# List boards. Optional: filter by space_id.
# Usage: boards-list.sh [space_id]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -ge 1 ] && [ -n "${1:-}" ]; then
  kaiten_request GET "/spaces/$1/boards"
else
  kaiten_request GET /boards
fi
