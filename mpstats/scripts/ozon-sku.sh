#!/bin/bash
# ozon-sku.sh — Get sales and stock history for an Ozon SKU
# Usage: ./ozon-sku.sh <sku>

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <sku>"
  echo "  sku — Ozon product ID (numeric), e.g. 123456789"
  echo ""
  echo "  Returns sales and stock history for the product."
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

curl -s --location --request GET \
  "https://mpstats.io/api/oz/get/item/${SKU}/sales" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
