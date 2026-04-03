#!/bin/bash
# request.sh — Universal MPSTATS API request runner
# Usage: ./request.sh <METHOD> <path> [query] [body_json]

METHOD="$1"
PATH_REL="$2"
QUERY="$3"
BODY_JSON="$4"

if [ -z "$METHOD" ] || [ -z "$PATH_REL" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <METHOD> <path> [query] [body_json]"
  echo "  METHOD    — GET or POST"
  echo "  path      — API path without base URL, e.g. wb/get/subject/by_date"
  echo "  query     — optional raw query, e.g. d1=2024-01-01&d2=2024-01-31&path=70"
  echo "  body_json — optional JSON body for POST"
  echo ""
  echo "Examples:"
  echo "  $0 GET wb/get/categories"
  echo "  $0 GET wb/get/subject/by_date 'path=70&d1=2024-01-01&d2=2024-01-31&groupBy=day'"
  echo "  $0 POST wb/get/subject 'path=70&d1=2024-01-01&d2=2024-01-31' '{\"startRow\":0,\"endRow\":100,\"filterModel\":{},\"sortModel\":[]}'"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

METHOD_UPPER=$(printf '%s' "$METHOD" | tr '[:lower:]' '[:upper:]')
URL="https://mpstats.io/api/${PATH_REL}"
if [ -n "$QUERY" ]; then
  URL="${URL}?${QUERY}"
fi

if [ "$METHOD_UPPER" = "GET" ]; then
  curl -s --location --request GET "$URL" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json'
elif [ "$METHOD_UPPER" = "POST" ]; then
  PAYLOAD="${BODY_JSON:-{\"startRow\":0,\"endRow\":100,\"filterModel\":{},\"sortModel\":[{\"colId\":\"revenue\",\"sort\":\"desc\"}]}}"
  curl -s --location --request POST "$URL" \
    --header "X-Mpstats-TOKEN: $TOKEN" \
    --header 'Content-Type: application/json' \
    --data "$PAYLOAD"
else
  echo "Unsupported METHOD: $METHOD. Use GET or POST." >&2
  exit 1
fi
