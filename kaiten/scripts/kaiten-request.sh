#!/bin/bash
# Arbitrary request to Kaiten API.
# Usage:
#   kaiten-request.sh GET  /cards --query '{"board_id":123,"limit":10}'
#   kaiten-request.sh POST /cards --data '{"title":"Foo","board_id":123}'
#   kaiten-request.sh PATCH /cards/456 --file payload.json
#   kaiten-request.sh DELETE /cards/456
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${DIR}/_common.sh"

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 METHOD /endpoint [--data JSON | --file path | --query JSON]" >&2
  exit 1
fi

kaiten_request "$@"
