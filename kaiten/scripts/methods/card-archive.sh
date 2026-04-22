#!/bin/bash
# Archive a card (soft).
# Usage: card-archive.sh <card_id>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 1 ]; then echo "Usage: $0 <card_id>" >&2; exit 1; fi
kaiten_request PATCH "/cards/$1" --data '{"archived":true}'
