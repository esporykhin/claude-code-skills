#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OZON_BASE_URL="${OZON_SELLER_BASE_URL:-https://api-seller.ozon.ru}"
OZON_BASE_URL="${OZON_BASE_URL%/}"

require_ozon_credentials() {
  if [ -z "${OZON_CLIENT_ID:-}" ] || [ -z "${OZON_API_KEY:-}" ]; then
    echo "OZON_CLIENT_ID and OZON_API_KEY must be set." >&2
    exit 1
  fi
}

payload_args() {
  local method="$1"
  shift || true

  PAYLOAD_MODE=""
  PAYLOAD_VALUE=""

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --data)
        PAYLOAD_MODE="data"
        PAYLOAD_VALUE="${2:-}"
        shift 2
        ;;
      --file)
        PAYLOAD_MODE="file"
        PAYLOAD_VALUE="${2:-}"
        shift 2
        ;;
      --empty)
        PAYLOAD_MODE="empty"
        PAYLOAD_VALUE="{}"
        shift
        ;;
      *)
        echo "Unknown argument: $1" >&2
        exit 1
        ;;
    esac
  done

  if [ -z "$PAYLOAD_MODE" ] && [ "$method" != "GET" ]; then
    PAYLOAD_MODE="empty"
    PAYLOAD_VALUE="{}"
  fi
}

ozon_request() {
  local method="$1"
  local endpoint="$2"
  shift 2 || true

  require_ozon_credentials
  payload_args "$method" "$@"

  extra=()
  case "${PAYLOAD_MODE}" in
    "")
      ;;
    data)
      extra=(--data "${PAYLOAD_VALUE}")
      ;;
    file)
      if [ ! -f "${PAYLOAD_VALUE}" ]; then
        echo "Payload file not found: ${PAYLOAD_VALUE}" >&2
        exit 1
      fi
      extra=(--data-binary "@${PAYLOAD_VALUE}")
      ;;
    empty)
      extra=(--data "${PAYLOAD_VALUE}")
      ;;
  esac

  curl_args=(
    -sS
    --globoff
    --request "$method"
    "${OZON_BASE_URL}${endpoint}"
    --header "Client-Id: ${OZON_CLIENT_ID}"
    --header "Api-Key: ${OZON_API_KEY}"
    --header "Content-Type: application/json"
  )

  if [ "${#extra[@]}" -gt 0 ]; then
    curl_args+=("${extra[@]}")
  fi

  curl "${curl_args[@]}"
}
