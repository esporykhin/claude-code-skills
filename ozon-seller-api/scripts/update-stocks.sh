#!/bin/bash
# update-stocks.sh — Update stocks in Ozon Seller API
# Usage:
#   ./update-stocks.sh --file payload.json
#   ./update-stocks.sh <offer_id> <stock> [product_id]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ]; then
  echo "Usage:"
  echo "  $0 --file payload.json"
  echo "  $0 <offer_id> <stock> [product_id]"
  echo ""
  echo "Notes:"
  echo "  - Endpoint: /v1/product/import/stocks"
  echo "  - Up to 100 items per request"
  echo "  - Used for FBS and rFBS warehouses"
  exit 0
fi

if [ "$1" = "--file" ]; then
  if [ -z "${2:-}" ] || [ ! -f "$2" ]; then
    echo "Payload file not found: ${2:-<empty>}" >&2
    exit 1
  fi
  ozon_post_file "/v1/product/import/stocks" "$2"
  exit 0
fi

OFFER_ID="$1"
STOCK="$2"
PRODUCT_ID="${3:-}"

PAYLOAD="$(python3 - "$OFFER_ID" "$STOCK" "$PRODUCT_ID" <<'PY'
import json
import sys

offer_id = sys.argv[1]
stock = int(sys.argv[2])
product_id = sys.argv[3]

item = {
    "offer_id": offer_id,
    "stock": stock,
}
if product_id:
    item["product_id"] = int(product_id)

print(json.dumps({"stocks": [item]}, ensure_ascii=False))
PY
)"

ozon_post "/v1/product/import/stocks" "$PAYLOAD"
