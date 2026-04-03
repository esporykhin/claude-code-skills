#!/bin/bash
# update-prices.sh — Update product prices in Ozon Seller API
# Usage:
#   ./update-prices.sh --file payload.json
#   ./update-prices.sh <offer_id> <price> [old_price] [currency_code] [min_price] [product_id]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ]; then
  echo "Usage:"
  echo "  $0 --file payload.json"
  echo "  $0 <offer_id> <price> [old_price] [currency_code] [min_price] [product_id]"
  echo ""
  echo "Notes:"
  echo "  - Endpoint: /v1/product/import/prices"
  echo "  - Up to 1000 items per request"
  echo "  - To reset old_price, pass 0"
  exit 0
fi

if [ "$1" = "--file" ]; then
  if [ -z "${2:-}" ] || [ ! -f "$2" ]; then
    echo "Payload file not found: ${2:-<empty>}" >&2
    exit 1
  fi
  ozon_post_file "/v1/product/import/prices" "$2"
  exit 0
fi

OFFER_ID="$1"
PRICE="$2"
OLD_PRICE="${3:-0}"
CURRENCY_CODE="${4:-RUB}"
MIN_PRICE="${5:-}"
PRODUCT_ID="${6:-}"

PAYLOAD="$(python3 - "$OFFER_ID" "$PRICE" "$OLD_PRICE" "$CURRENCY_CODE" "$MIN_PRICE" "$PRODUCT_ID" <<'PY'
import json
import sys

offer_id = sys.argv[1]
price = sys.argv[2]
old_price = sys.argv[3]
currency_code = sys.argv[4]
min_price = sys.argv[5]
product_id = sys.argv[6]

item = {
    "offer_id": offer_id,
    "price": str(price),
    "old_price": str(old_price),
    "currency_code": currency_code,
}
if min_price:
    item["min_price"] = str(min_price)
if product_id:
    item["product_id"] = int(product_id)

print(json.dumps({"prices": [item]}, ensure_ascii=False))
PY
)"

ozon_post "/v1/product/import/prices" "$PAYLOAD"
