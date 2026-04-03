#!/bin/bash
# ozon-sku.sh — Ozon SKU-level endpoints
# Usage: ./ozon-sku.sh <sku> [report] [d1] [d2] [fbs] [d]

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <sku> [report] [d1] [d2] [fbs] [d]"
  echo "  sku    — Ozon product ID (numeric), e.g. 1252420260"
  echo "  report — sales (default), balance_by_day, balance_by_region, by_category, by_keywords"
  echo "  d1     — start date YYYY-MM-DD (optional for sales/by_category/by_keywords)"
  echo "  d2     — end date YYYY-MM-DD (optional for sales/by_category/by_keywords)"
  echo "  fbs    — include FBS: 0 or 1 (optional for sales/balance_by_region)"
  echo "  d      — point date YYYY-MM-DD (required for balance_by_day/balance_by_region)"
  echo ""
  echo "Examples:"
  echo "  $0 1252420260 sales 2023-12-12 2023-12-25"
  echo "  $0 1252420260 balance_by_day '' '' '' 2023-12-26"
  echo "  $0 1252420260 balance_by_region '' '' 1 2023-12-26"
  echo "  $0 1252420260 by_category 2023-12-19 2023-12-26"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common.sh
source "$SCRIPT_DIR/../common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

SKU="$1"
REPORT="${2:-sales}"
D1="$3"
D2="$4"
FBS="$5"
POINT_DATE="$6"

BASE_URL="https://mpstats.io/api/oz/get/item/${SKU}"
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
  sales|by_category|by_keywords)
    URL="${BASE_URL}/${REPORT}"
    QUERY=$(append_query "$QUERY" "d1=${D1}")
    QUERY=$(append_query "$QUERY" "d2=${D2}")
    if [ "$REPORT" = "sales" ]; then
      QUERY=$(append_query "$QUERY" "fbs=${FBS}")
    fi
    ;;
  balance_by_day|balance_by_region)
    URL="${BASE_URL}/${REPORT}"
    QUERY=$(append_query "$QUERY" "d=${POINT_DATE}")
    if [ "$REPORT" = "balance_by_region" ]; then
      QUERY=$(append_query "$QUERY" "fbs=${FBS}")
    fi
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
