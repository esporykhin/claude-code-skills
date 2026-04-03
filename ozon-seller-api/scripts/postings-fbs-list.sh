#!/bin/bash
# postings-fbs-list.sh — List FBS postings from Ozon Seller API
# Usage: ./postings-fbs-list.sh [since] [to] [status] [limit] [offset]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ]; then
  echo "Usage: $0 [since] [to] [status] [limit] [offset]"
  echo "  since   — ISO datetime or YYYY-MM-DD (default: 7 days ago)"
  echo "  to      — ISO datetime or YYYY-MM-DD (default: now)"
  echo "  status  — optional posting status filter (default: empty)"
  echo "  limit   — 1..1000 (default: 100)"
  echo "  offset  — offset for pagination (default: 0)"
  echo ""
  echo "Tip: if response has_next=true, repeat call with larger offset."
  exit 0
fi

SINCE_RAW="${1:-$(iso_utc_days_ago 7)}"
TO_RAW="${2:-$(iso_utc_now)}"
STATUS="${3:-}"
LIMIT="${4:-100}"
OFFSET="${5:-0}"

SINCE="$(normalize_datetime "$SINCE_RAW")"
TO="$(normalize_datetime "$TO_RAW")"

PAYLOAD="$(python3 - "$SINCE" "$TO" "$STATUS" "$LIMIT" "$OFFSET" <<'PY'
import json
import sys

since = sys.argv[1]
to = sys.argv[2]
status = sys.argv[3]
limit = int(sys.argv[4])
offset = int(sys.argv[5])

payload = {
    "dir": "DESC",
    "filter": {
        "since": since,
        "to": to,
    },
    "limit": limit,
    "offset": offset,
    "with": {
        "analytics_data": False,
        "barcodes": False,
        "financial_data": False,
        "translit": False,
    }
}

if status:
    payload["filter"]["status"] = status

print(json.dumps(payload, ensure_ascii=False))
PY
)"

ozon_post "/v3/posting/fbs/list" "$PAYLOAD"
