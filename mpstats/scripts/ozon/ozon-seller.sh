#!/bin/bash
# ozon-seller.sh — Get products or analytics for an Ozon seller
# Usage: ./ozon-seller.sh <seller_id_or_name> [report] [d1] [d2] [limit] [fbs] [newsmode]

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <seller_id_or_name> [report] [d1] [d2] [limit] [fbs] [newsmode]"
  echo "  seller_id_or_name — Ozon seller ID (numeric) or seller name (path)"
  echo "  report            — products (default), categories, brands, by_date, price_segmentation"
  echo "  d1        — start date YYYY-MM-DD (default: 30 days ago)"
  echo "  d2        — end date YYYY-MM-DD (default: today)"
  echo "  limit     — max results for products report, 1-5000 (default: 100)"
  echo "  fbs       — include FBS: 0 or 1 (default: 0)"
  echo "  newsmode  — only new products for last N days: 7|14|30 (optional)"
  echo ""
  echo "Environment:"
  echo "  MPSTATS_TOKEN — API token (or set in config/.env)"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common.sh
source "$SCRIPT_DIR/../common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

SELLER_INPUT="$1"
REPORT="${2:-products}"
D1="${3:-$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d '30 days ago' +%Y-%m-%d)}"
D2="${4:-$(date +%Y-%m-%d)}"
LIMIT="${5:-100}"
FBS="${6:-0}"
NEWSMODE="$7"

if printf '%s' "$SELLER_INPUT" | grep -Eq '^[0-9]+$'; then
  SELLER_QUERY="seller_id=${SELLER_INPUT}"
else
  ENCODED_PATH=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$SELLER_INPUT'))" 2>/dev/null || \
    node -e "process.stdout.write(encodeURIComponent('$SELLER_INPUT'))" 2>/dev/null || \
    printf '%s' "$SELLER_INPUT" | sed 's/ /%20/g')
  SELLER_QUERY="path=${ENCODED_PATH}"
fi

QUERY="d1=${D1}&d2=${D2}&${SELLER_QUERY}&fbs=${FBS}"
if [ -n "$NEWSMODE" ]; then
  QUERY="${QUERY}&newsmode=${NEWSMODE}"
fi

if [ "$REPORT" = "products" ]; then
  curl -s --location --request POST \
    "https://mpstats.io/api/oz/get/seller?${QUERY}" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json' \
    --data "{\"startRow\":0,\"endRow\":${LIMIT},\"filterModel\":{},\"sortModel\":[{\"colId\":\"revenue\",\"sort\":\"desc\"}]}"
else
  curl -s --location --request GET \
    "https://mpstats.io/api/oz/get/seller/${REPORT}?${QUERY}" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json'
fi
