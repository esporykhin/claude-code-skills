#!/bin/bash
# Move a card to another column (and optionally lane).
# Usage: card-move.sh <card_id> <column_id> [lane_id]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 2 ]; then echo "Usage: $0 <card_id> <column_id> [lane_id]" >&2; exit 1; fi

card_id="$1"; column_id="$2"; lane_id="${3:-}"
if [ -n "$lane_id" ]; then
  payload="$(jq -nc --argjson c "$column_id" --argjson l "$lane_id" '{column_id:$c, lane_id:$l}')"
else
  payload="$(jq -nc --argjson c "$column_id" '{column_id:$c}')"
fi
kaiten_request PATCH "/cards/${card_id}" --data "$payload"
