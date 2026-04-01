#!/bin/bash
# report-list.sh — List generated reports in Ozon Seller API
# Usage: ./report-list.sh [report_type] [page] [page_size]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ]; then
  echo "Usage: $0 [report_type] [page] [page_size]"
  echo "  report_type — ALL (default) or specific report type"
  echo "  page        — page number, default 1"
  echo "  page_size   — page size, default 50"
  exit 0
fi

REPORT_TYPE="${1:-ALL}"
PAGE="${2:-1}"
PAGE_SIZE="${3:-50}"

PAYLOAD="$(python3 - "$REPORT_TYPE" "$PAGE" "$PAGE_SIZE" <<'PY'
import json
import sys

report_type = sys.argv[1]
page = int(sys.argv[2])
page_size = int(sys.argv[3])

print(json.dumps({
    "report_type": report_type,
    "page": page,
    "page_size": page_size,
}, ensure_ascii=False))
PY
)"

ozon_post "/v1/report/list" "$PAYLOAD"
