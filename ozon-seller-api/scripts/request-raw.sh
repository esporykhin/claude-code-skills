#!/bin/bash
# request-raw.sh — Send arbitrary request to Ozon Seller API
# Usage:
#   ./request-raw.sh <METHOD> <endpoint> [payload_file]
# Examples:
#   ./request-raw.sh POST /v1/warehouse/list payload.json
#   ./request-raw.sh GET /v1/actions

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
  echo "Usage: $0 <METHOD> <endpoint> [payload_file]"
  echo "  METHOD      — GET, POST, PUT, PATCH, DELETE"
  echo "  endpoint    — API path, for example /v2/product/list"
  echo "  payload_file — optional JSON file for body"
  exit 0
fi

METHOD="$(echo "$1" | tr '[:lower:]' '[:upper:]')"
ENDPOINT="$2"
PAYLOAD_FILE="${3:-}"

if [ -n "$PAYLOAD_FILE" ] && [ ! -f "$PAYLOAD_FILE" ]; then
  echo "Payload file not found: $PAYLOAD_FILE" >&2
  exit 1
fi

ozon_request "$METHOD" "$ENDPOINT" "$PAYLOAD_FILE"
