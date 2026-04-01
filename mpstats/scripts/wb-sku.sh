#!/bin/bash
# wb-sku.sh — Get analytics for a specific Wildberries SKU
# Usage: ./wb-sku.sh <sku> <report>

if [ -z "$1" ] || [ -z "$2" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <sku> <report>"
  echo "  sku    — WB product ID (numeric), e.g. 152490541"
  echo "  report — one of:"
  echo "             sales           — sales and stock history"
  echo "             balance_by_day  — daily balance"
  echo "             balance_by_region — stock by warehouse/region"
  echo "             balance_by_size — stock by size"
  echo "             sales_by_region — sales by region"
  echo "             sales_by_size   — sales by size"
  echo "             by_category     — category positions"
  echo "             by_keywords     — keyword positions"
  echo "             comments        — review history"
  echo "             identical       — AI-similar products"
  echo "             similar         — WB-similar products"
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

SKU="$1"
REPORT="$2"

curl -s --location --request GET \
  "https://mpstats.io/api/wb/get/item/${SKU}/${REPORT}" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
