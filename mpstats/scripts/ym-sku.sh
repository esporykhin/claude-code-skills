#!/bin/bash
# ym-sku.sh — Get sales and stock history for a Yandex Market item
# Usage: ./ym-sku.sh <id>

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <id>"
  echo "  id — Yandex Market item ID (numeric), e.g. 12345678"
  echo ""
  echo "  Returns sales and stock history for the item."
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

ITEM_ID="$1"

curl -s --location --request GET \
  "https://mpstats.io/api/ym/get/item/${ITEM_ID}/sales" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
