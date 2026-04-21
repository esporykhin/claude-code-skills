#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
  echo "Usage: $0 <METHOD> <ENDPOINT> [--data JSON | --file payload.json | --empty]"
  echo "Examples:"
  echo "  $0 POST /v1/roles --empty"
  echo "  $0 POST /v3/product/list --data '{\"filter\":{\"visibility\":\"ALL\"},\"limit\":100}'"
  echo "  $0 POST /v1/product/import/prices --file payload.json"
  exit 0
fi

METHOD="$(printf '%s' "$1" | tr '[:lower:]' '[:upper:]')"
ENDPOINT="$2"
shift 2

ozon_request "$METHOD" "$ENDPOINT" "$@"
