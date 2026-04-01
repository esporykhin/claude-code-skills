#!/bin/bash
# ozon-seller.sh — Get products or analytics for an Ozon seller
# Usage: ./ozon-seller.sh <seller_id> [report] [d1] [d2] [limit] [fbs]

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <seller_id> [report] [d1] [d2] [limit] [fbs]"
  echo "  seller_id — Ozon seller ID (numeric)"
  echo "  report    — products (default), categories, brands, by_date, price_segmentation"
  echo "  d1        — start date YYYY-MM-DD (default: 30 days ago)"
  echo "  d2        — end date YYYY-MM-DD (default: today)"
  echo "  limit     — max results for products report, 1-5000 (default: 100)"
  echo "  fbs       — include FBS: 0 or 1 (default: 0)"
  echo ""
  echo "Environment:"
  echo "  MPSTATS_TOKEN — API token"
  exit 0
fi

TOKEN="${MPSTATS_TOKEN}"
if [ -z "$TOKEN" ]; then
  echo '{"error":"MPSTATS_TOKEN not set. Pass token via environment variable."}' >&2
  exit 1
fi

SELLER_ID="$1"
REPORT="${2:-products}"
D1="${3:-$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d '30 days ago' +%Y-%m-%d)}"
D2="${4:-$(date +%Y-%m-%d)}"
LIMIT="${5:-100}"
FBS="${6:-0}"

if [ "$REPORT" = "products" ]; then
  curl -s --location --request POST \
    "https://mpstats.io/api/oz/get/seller?d1=${D1}&d2=${D2}&seller_id=${SELLER_ID}&fbs=${FBS}" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json' \
    --data "{\"startRow\":0,\"endRow\":${LIMIT},\"filterModel\":{},\"sortModel\":[{\"colId\":\"revenue\",\"sort\":\"desc\"}]}"
else
  curl -s --location --request GET \
    "https://mpstats.io/api/oz/get/seller/${REPORT}?d1=${D1}&d2=${D2}&seller_id=${SELLER_ID}&fbs=${FBS}" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json'
fi
