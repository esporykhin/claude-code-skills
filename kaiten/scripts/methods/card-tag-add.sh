#!/bin/bash
# Attach a tag to a card by name (creates tag if not exists on the board).
# Usage: card-tag-add.sh <card_id> <tag_name>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 2 ]; then echo "Usage: $0 <card_id> <tag_name>" >&2; exit 1; fi
payload="$(jq -nc --arg n "$2" '{name:$n}')"
kaiten_request POST "/cards/$1/tags" --data "$payload"
