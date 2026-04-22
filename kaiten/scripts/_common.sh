#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$ROOT_DIR/config/.env"

load_kaiten_config() {
  if [[ -f "$CONFIG_FILE" ]]; then
    while IFS='=' read -r key value; do
      [[ "$key" =~ ^[[:space:]]*# ]] && continue
      [[ -z "$key" ]] && continue
      key=$(printf '%s' "$key" | xargs)
      value=$(printf '%s' "$value" | sed 's/^["'\''"]//;s/["'\''"]$//')
      if [[ -z "${!key:-}" ]]; then
        export "$key=$value"
      fi
    done < "$CONFIG_FILE"
  fi
}

require_kaiten_credentials() {
  load_kaiten_config
  if [ -z "${KAITEN_DOMAIN:-}" ] || [ -z "${KAITEN_TOKEN:-}" ]; then
    echo '{"error":"KAITEN_DOMAIN и KAITEN_TOKEN не заданы. Настрой config/.env или экспортни переменные."}' >&2
    echo "See: kaiten/config/README.md" >&2
    echo "Get token: Kaiten → Профиль → API → Create new API token." >&2
    exit 1
  fi
}

kaiten_base_url() {
  local domain="${KAITEN_DOMAIN%/}"
  domain="${domain#https://}"
  domain="${domain#http://}"
  echo "https://${domain}/api/latest"
}

# Usage: kaiten_request METHOD ENDPOINT [--data '{...}' | --file path | --query '{...}']
kaiten_request() {
  local method="$1"
  local endpoint="$2"
  shift 2 || true

  require_kaiten_credentials

  local payload_mode="" payload_value="" query_value=""
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --data)  payload_mode="data"; payload_value="${2:-}"; shift 2 ;;
      --file)  payload_mode="file"; payload_value="${2:-}"; shift 2 ;;
      --query) query_value="${2:-}"; shift 2 ;;
      *) echo "Unknown argument: $1" >&2; exit 1 ;;
    esac
  done

  local url
  url="$(kaiten_base_url)${endpoint}"

  if [ -n "$query_value" ] && [ "$method" = "GET" ]; then
    local qs
    qs="$(echo "$query_value" | jq -r 'to_entries | map("\(.key)=\(.value|tostring|@uri)") | join("&")')"
    if [ -n "$qs" ]; then
      if [[ "$url" == *"?"* ]]; then url="${url}&${qs}"; else url="${url}?${qs}"; fi
    fi
  fi

  local curl_args=(
    -sS --globoff
    --request "$method"
    "$url"
    --header "Authorization: Bearer ${KAITEN_TOKEN}"
    --header "Content-Type: application/json"
    --header "Accept: application/json"
  )

  case "$payload_mode" in
    data)
      curl_args+=(--data "$payload_value") ;;
    file)
      if [ ! -f "$payload_value" ]; then
        echo "Payload file not found: $payload_value" >&2; exit 1
      fi
      curl_args+=(--data-binary "@${payload_value}") ;;
    "")
      if [ "$method" != "GET" ] && [ "$method" != "DELETE" ]; then
        curl_args+=(--data "{}")
      fi
      ;;
  esac

  curl "${curl_args[@]}"
}
