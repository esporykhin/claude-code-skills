#!/bin/bash
# List columns of a board.
# Usage: columns-list.sh <board_id>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 1 ]; then echo "Usage: $0 <board_id>" >&2; exit 1; fi
kaiten_request GET "/boards/$1/columns"
