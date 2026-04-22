#!/bin/bash
# Add a member (responsible user) to a card.
# Usage: card-members-add.sh <card_id> <user_id>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 2 ]; then echo "Usage: $0 <card_id> <user_id>" >&2; exit 1; fi
payload="$(jq -nc --argjson u "$2" '{user_id:$u}')"
kaiten_request POST "/cards/$1/members" --data "$payload"
