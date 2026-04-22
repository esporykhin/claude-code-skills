#!/bin/bash
# Create a card.
# Usage: card-create.sh <payload.json>
# Minimal payload: {"title":"...","board_id":123,"column_id":456}
# Optional: description, lane_id, owner_id, members (ids), tags (names), due_date,
#           type_id, properties, checklists.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 1 ]; then echo "Usage: $0 <payload.json>" >&2; exit 1; fi
kaiten_request POST /cards --file "$1"
