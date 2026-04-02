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
  echo "  MPSTATS_TOKEN — API token (or set in config/.env)"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

SKU="$1"

curl -s --location --request GET \
  "https://mpstats.io/api/oz/get/item/${SKU}/sales" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
