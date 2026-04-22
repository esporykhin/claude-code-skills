#!/bin/bash
# check-position-raw.sh — Send raw JSON payload to check-positions endpoint
# Usage:
#   ./check-position-raw.sh '<json_body>'

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "$SCRIPT_DIR/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ]; then
  echo "Usage: $0 '<json_body>'"
  echo ""
  echo "Example:"
  echo "  $0 '{\"queries\":[\"маникюр\",\"педикюр\"],\"targetOrgId\":\"188841488618\",\"coordinates\":{\"lat\":55.595275,\"lon\":37.074528},\"radiusKm\":2}'"
  echo ""
  echo "Configuration:"
  echo "  config/.env внутри скилла (см. config/README.md). Env-переменные переопределяют."
  echo "  YANDEX_POSITION_CHECKER_BASE_URL — API base URL, default https://loocl.ru"
  echo "  LOOCL_BASE_URL — deprecated alias (backward compatibility)"
  exit 0
fi

BASE_URL="$YANDEX_POSITION_CHECKER_BASE_URL"
PAYLOAD="$1"

curl -sS --location --request POST "${BASE_URL}/api/tools/check-positions" \
  --header 'Content-Type: application/json' \
  --data "$PAYLOAD"
