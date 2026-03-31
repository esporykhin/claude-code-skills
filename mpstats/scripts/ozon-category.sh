#!/bin/bash
# ozon-category.sh — Get products or stats for an Ozon category
# Usage: ./ozon-category.sh <category_path> [report] [d1] [d2] [limit] [fbs]

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <category_path> [report] [d1] [d2] [limit] [fbs]"
  echo "  category_path — e.g. 'Автотовары/Автоаксессуары и принадлежности'"
  echo "  report        — products (default), subcategories, brands, sellers, by_date, price_segmentation"
  echo "  d1            — start date YYYY-MM-DD (default: 30 days ago)"
  echo "  d2            — end date YYYY-MM-DD (default: today)"
  echo "  limit         — max results for products report, 1-5000 (default: 100)"
  echo "  fbs           — include FBS: 0 or 1 (default: 0)"
  echo ""
  echo "Environment:"
  echo "  MPSTATS_TOKEN — API token (or read from ~/.claude/credentials.env)"
  exit 0
fi

TOKEN="${MPSTATS_TOKEN}"
if [ -z "$TOKEN" ]; then
  TOKEN=$(grep MPSTATS_TOKEN ~/.claude/credentials.env | cut -d= -f2)
fi

if [ -z "$TOKEN" ]; then
  echo '{"error":"MPSTATS_TOKEN not set"}' >&2
  exit 1
fi

CATEGORY_PATH="$1"
REPORT="${2:-products}"
D1="${3:-$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d '30 days ago' +%Y-%m-%d)}"
D2="${4:-$(date +%Y-%m-%d)}"
LIMIT="${5:-100}"
FBS="${6:-0}"

ENCODED_PATH=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$CATEGORY_PATH'))" 2>/dev/null || \
  node -e "process.stdout.write(encodeURIComponent('$CATEGORY_PATH'))" 2>/dev/null || \
  printf '%s' "$CATEGORY_PATH" | sed 's/ /%20/g; s|/|%2F|g')

if [ "$REPORT" = "products" ]; then
  curl -s --location --request POST \
    "https://mpstats.io/api/oz/get/category?d1=${D1}&d2=${D2}&path=${ENCODED_PATH}&fbs=${FBS}" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json' \
    --data "{\"startRow\":0,\"endRow\":${LIMIT},\"filterModel\":{},\"sortModel\":[{\"colId\":\"revenue\",\"sort\":\"desc\"}]}"
else
  curl -s --location --request GET \
    "https://mpstats.io/api/oz/get/category/${REPORT}?d1=${D1}&d2=${D2}&path=${ENCODED_PATH}&fbs=${FBS}" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json'
fi
