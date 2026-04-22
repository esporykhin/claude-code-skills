#!/bin/bash
# List comments of a card.
# Usage: card-comments-list.sh <card_id>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 1 ]; then echo "Usage: $0 <card_id>" >&2; exit 1; fi
kaiten_request GET "/cards/$1/comments"
