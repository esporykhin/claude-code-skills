#!/bin/bash
# wb-sku.sh — Get analytics for a specific Wildberries SKU
# Usage: ./wb-sku.sh <sku> <report> [d1] [d2] [fbs] [d] [version]

if [ -z "$1" ] || [ -z "$2" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <sku> <report> [d1] [d2] [fbs] [d] [version]"
  echo "  sku     — WB product ID (numeric), e.g. 152490541"
  echo "  report  — one of:"
  echo "             sales"
  echo "             balance_by_day"
  echo "             balance_by_region"
  echo "             balance_by_size"
  echo "             sales_by_region"
  echo "             sales_by_size"
  echo "             by_category"
  echo "             by_keywords"
  echo "             comments"
  echo "             identical"
  echo "             identical_wb"
  echo "             similar"
  echo "             in_similar"
  echo "             full_page_versions"
  echo "             full_page"
  echo "  d1      — start date YYYY-MM-DD (optional)"
  echo "  d2      — end date YYYY-MM-DD (optional)"
  echo "  fbs     — include FBS: 0 or 1 (optional)"
  echo "  d       — point date for balance_by_day/balance_by_region/balance_by_size"
  echo "  version — version hash for full_page (or pass it as the 3rd arg)"
  echo ""
  echo "Examples:"
  echo "  $0 152490541 sales 2026-03-01 2026-03-31"
  echo "  $0 152490541 full_page"
  echo "  $0 152490541 full_page d014a6f559bb6f65c0fd9cda245e7b28"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common.sh
source "$SCRIPT_DIR/../common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

SKU="$1"
REPORT="$2"
D1="$3"
D2="$4"
FBS="$5"
SINGLE_DATE="$6"
VERSION_HASH="$7"

resolve_full_page_version() {
  local explicit_version="$1"
  local versions_url="${BASE_URL}/full_page/versions"

  if [ -n "$explicit_version" ]; then
    printf '%s' "$explicit_version"
    return 0
  fi

  curl -s --location --request GET "$versions_url" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json' \
    | jq -r '.[0].version // empty'
}

BASE_URL="https://mpstats.io/api/wb/get/item/${SKU}"
URL=""
QUERY=""

append_query() {
  if [ -n "$2" ]; then
    if [ -z "$1" ]; then
      printf '%s' "$2"
    else
      printf '%s&%s' "$1" "$2"
    fi
  else
    printf '%s' "$1"
  fi
}

case "$REPORT" in
  full_page_versions)
    URL="$BASE_URL/full_page/versions"
    ;;
  full_page)
    URL="$BASE_URL/full_page"
    # For full_page, allow a short form where the version hash is passed
    # as the 3rd arg, and default to the latest available version.
    if [ -z "$VERSION_HASH" ] && [ -n "$D1" ] && [[ "$D1" =~ ^[A-Fa-f0-9]{32}$ ]]; then
      VERSION_HASH="$D1"
    fi
    VERSION_HASH="$(resolve_full_page_version "$VERSION_HASH")"
    if [ -z "$VERSION_HASH" ]; then
      echo '{"error":"Unable to resolve full_page version for this SKU."}' >&2
      exit 1
    fi
    QUERY=$(append_query "$QUERY" "version=${VERSION_HASH}")
    ;;
  sales|sales_by_region|sales_by_size|by_category|by_keywords|identical|identical_wb|similar|in_similar)
    URL="$BASE_URL/$REPORT"
    QUERY=$(append_query "$QUERY" "d1=${D1}")
    QUERY=$(append_query "$QUERY" "d2=${D2}")
    QUERY=$(append_query "$QUERY" "fbs=${FBS}")
    ;;
  balance_by_day|balance_by_region|balance_by_size)
    URL="$BASE_URL/$REPORT"
    QUERY=$(append_query "$QUERY" "d=${SINGLE_DATE}")
    QUERY=$(append_query "$QUERY" "fbs=${FBS}")
    ;;
  comments)
    URL="$BASE_URL/comments"
    ;;
  *)
    echo "Unsupported report: $REPORT" >&2
    exit 1
    ;;
esac

if [ -n "$QUERY" ]; then
  URL="${URL}?${QUERY}"
fi

curl -s --location --request GET "$URL" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
