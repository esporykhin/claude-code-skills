#!/bin/bash
# products-list.sh — List products from Ozon Seller API
# Usage: ./products-list.sh [visibility] [limit] [last_id] [offer_ids_csv] [product_ids_csv]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ]; then
  echo "Usage: $0 [visibility] [limit] [last_id] [offer_ids_csv] [product_ids_csv]"
  echo "  visibility      — ALL (default), VISIBLE, INVISIBLE, EMPTY_STOCK, etc"
  echo "  limit           — 1..1000 (default: 100)"
  echo "  last_id         — pagination cursor (default: empty)"
  echo "  offer_ids_csv   — optional CSV offer_id list"
  echo "  product_ids_csv — optional CSV product_id list"
  echo ""
  echo "Environment:"
  echo "  OZON_CLIENT_ID"
  echo "  OZON_API_KEY"
  echo "  OZON_SELLER_BASE_URL (optional, default https://api-seller.ozon.ru)"
  exit 0
fi

VISIBILITY="${1:-ALL}"
LIMIT="${2:-100}"
LAST_ID="${3:-}"
OFFER_IDS_CSV="${4:-}"
PRODUCT_IDS_CSV="${5:-}"

OFFER_IDS_JSON="$(csv_to_json_array "$OFFER_IDS_CSV")"
PRODUCT_IDS_JSON="$(csv_to_json_array "$PRODUCT_IDS_CSV")"

PAYLOAD="$(python3 - "$VISIBILITY" "$LIMIT" "$LAST_ID" "$OFFER_IDS_JSON" "$PRODUCT_IDS_JSON" <<'PY'
import json
import sys

visibility = sys.argv[1]
limit = int(sys.argv[2])
last_id = sys.argv[3]
offer_ids = json.loads(sys.argv[4])
product_ids = json.loads(sys.argv[5])

payload = {
    "filter": {
        "visibility": visibility,
    },
    "limit": limit,
}

if last_id:
    payload["last_id"] = last_id
if offer_ids:
    payload["filter"]["offer_id"] = offer_ids
if product_ids:
    payload["filter"]["product_id"] = product_ids

print(json.dumps(payload, ensure_ascii=False))
PY
)"

ozon_post "/v2/product/list" "$PAYLOAD"
