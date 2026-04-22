#!/bin/bash
# Update a card (PATCH).
# Usage: card-update.sh <card_id> <payload.json>
# Any subset of fields: title, description, due_date, column_id, lane_id,
#                      owner_id, archived, properties, etc.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 2 ]; then echo "Usage: $0 <card_id> <payload.json>" >&2; exit 1; fi
kaiten_request PATCH "/cards/$1" --file "$2"
