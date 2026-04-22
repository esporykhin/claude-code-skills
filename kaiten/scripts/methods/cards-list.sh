#!/bin/bash
# List/search cards with filters.
# Usage: cards-list.sh '<json-query>'
# Common filters: board_id, space_id, column_id, lane_id, owner_id, member_ids,
#                 query (text), archived (0/1), condition, limit (<=100), offset.
# Example: cards-list.sh '{"board_id":123,"archived":0,"limit":50}'
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

QUERY="${1:-{}}"
kaiten_request GET /cards --query "$QUERY"
