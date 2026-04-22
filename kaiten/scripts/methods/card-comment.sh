#!/bin/bash
# Add a comment to a card.
# Usage: card-comment.sh <card_id> "comment text"
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 2 ]; then echo "Usage: $0 <card_id> <text>" >&2; exit 1; fi
payload="$(jq -nc --arg t "$2" '{text:$t}')"
kaiten_request POST "/cards/$1/comments" --data "$payload"
