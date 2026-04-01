#!/bin/bash
# wb-categories-list.sh — Get full WB category tree (rubricator)
# Usage: ./wb-categories-list.sh

if [ "$1" = "--help" ]; then
  echo "Usage: $0"
  echo "  Returns the full Wildberries category tree."
  echo "  Each item: {url, name, path}"
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

curl -s --location --request GET 'https://mpstats.io/api/wb/get/categories' \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
