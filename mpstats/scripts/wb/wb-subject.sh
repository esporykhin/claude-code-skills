#!/bin/bash
# wb-subject.sh — Subject (niche) endpoints: products and aggregate reports
# Usage: ./wb-subject.sh <subject_id> [report] [d1] [d2] [limit] [fbs] [groupBy]

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <subject_id> [report] [d1] [d2] [limit] [fbs] [groupBy]"
  echo "  subject_id — WB subject id (numeric), e.g. 70"
  echo "  report     — products (default), categories, brands, sellers, trends, by_date, price_segmentation, by_keywords, similar"
  echo "  d1         — start date YYYY-MM-DD (default: 30 days ago)"
  echo "  d2         — end date YYYY-MM-DD (default: today)"
  echo "  limit      — max rows for products report, 1-5000 (default: 100)"
  echo "  fbs        — include FBS: 0 or 1 (default: 0)"
  echo "  groupBy    — for by_date: day|week|month (optional)"
  echo ""
  echo "Examples:"
  echo "  $0 70 products"
  echo "  $0 70 by_date 2024-01-01 2024-01-31 100 0 day"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common.sh
source "$SCRIPT_DIR/../common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

SUBJECT_ID="$1"
REPORT="${2:-products}"
D1="${3:-$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d '30 days ago' +%Y-%m-%d)}"
D2="${4:-$(date +%Y-%m-%d)}"
LIMIT="${5:-100}"
FBS="${6:-0}"
GROUP_BY="$7"

BASE_URL="https://mpstats.io/api"

if [ "$REPORT" = "geography" ]; then
  echo "Report 'geography' is temporarily disabled due to unstable API responses." >&2
  exit 1
fi

if [ "$REPORT" = "products" ]; then
  curl -s --location --request POST \
    "$BASE_URL/wb/get/subject?d1=${D1}&d2=${D2}&path=${SUBJECT_ID}&fbs=${FBS}" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json' \
    --data "{\"startRow\":0,\"endRow\":${LIMIT},\"filterModel\":{},\"sortModel\":[{\"colId\":\"revenue\",\"sort\":\"desc\"}]}"
  exit $?
fi

QUERY="d1=${D1}&d2=${D2}&path=${SUBJECT_ID}&fbs=${FBS}"

if [ "$REPORT" = "by_date" ] && [ -n "$GROUP_BY" ]; then
  QUERY="${QUERY}&groupBy=${GROUP_BY}"
fi

curl -s --location --request GET \
  "$BASE_URL/wb/get/subject/${REPORT}?${QUERY}" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
