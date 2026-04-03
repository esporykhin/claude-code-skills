#!/bin/bash
# report-info.sh — Get details for a generated report
# Usage: ./report-info.sh <code>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ]; then
  echo "Usage: $0 <code>"
  echo "  code — report code from /v1/report/list"
  exit 0
fi

CODE="$1"

PAYLOAD="$(python3 - "$CODE" <<'PY'
import json
import sys
print(json.dumps({"code": sys.argv[1]}, ensure_ascii=False))
PY
)"

ozon_post "/v1/report/info" "$PAYLOAD"
