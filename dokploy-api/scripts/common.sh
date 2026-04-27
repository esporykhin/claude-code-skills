#!/bin/bash
# Общие функции для Dokploy-скриптов.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$ROOT_DIR/config/.env"

load_dokploy_config() {
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

require_dokploy_credentials() {
  load_dokploy_config
  if [[ -z "${DOKPLOY_URL:-}" || -z "${DOKPLOY_API_KEY:-}" ]]; then
    echo '{"error":"DOKPLOY_URL и DOKPLOY_API_KEY не заданы. Настрой config/.env."}' >&2
    echo "See: dokploy-api/config/README.md" >&2
    exit 1
  fi
  DOKPLOY_URL="${DOKPLOY_URL%/}"
  export DOKPLOY_URL
}

# Usage: dokploy_request METHOD PROCEDURE [--data '{...}']
# PROCEDURE — tRPC-процедура без префикса /api/, например: project.all, application.create
dokploy_request() {
  local method="$1"
  local procedure="$2"
  shift 2 || true

  require_dokploy_credentials

  local data=""
  local query=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --data)  data="$2"; shift 2 ;;
      --query) query+="${query:+&}$2"; shift 2 ;;
      *) echo "Unknown arg: $1" >&2; exit 2 ;;
    esac
  done

  local url="${DOKPLOY_URL}/api/${procedure}"
  [[ -n "$query" ]] && url="${url}?${query}"

  local args=(-sS -X "$method" "$url"
    -H "x-api-key: ${DOKPLOY_API_KEY}"
    -H "Content-Type: application/json"
    -w '\n__HTTP_STATUS__:%{http_code}')

  [[ -n "$data" ]] && args+=(-d "$data")

  local raw status body
  raw=$(curl "${args[@]}")
  status="${raw##*__HTTP_STATUS__:}"
  body="${raw%__HTTP_STATUS__:*}"

  printf '%s' "$body"

  if [[ ! "$status" =~ ^2 ]]; then
    echo >&2
    echo "dokploy-request: HTTP $status" >&2
    exit 1
  fi
}
