#!/usr/bin/env bash
# Универсальный вызов amoCRM API с долгосрочным токеном.
#
# Usage:
#   amocrm-request.sh <METHOD> <PATH> [--data <json>] [--query <k=v>...]
#
# Examples:
#   amocrm-request.sh GET /api/v4/account
#   amocrm-request.sh GET /api/v4/leads --query limit=50 --query with=contacts
#   amocrm-request.sh POST /api/v4/leads --data '[{"name":"Test","price":100}]'
#   amocrm-request.sh PATCH /api/v4/leads/123 --data '{"status_id":142}'
#
# Читает credentials из config/.env (или env-переменных):
#   AMOCRM_SUBDOMAIN    — поддомен аккаунта (без .amocrm.ru)
#   AMOCRM_ACCESS_TOKEN — долгосрочный токен приватной интеграции
#   AMOCRM_DOMAIN       — amocrm.ru | amocrm.com (по умолчанию amocrm.ru)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"
load_config

method="${1:?method required (GET|POST|PATCH|DELETE)}"
path="${2:?path required, e.g. /api/v4/leads}"
shift 2

data=""
query=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --data) data="$2"; shift 2 ;;
    --query) query+="${query:+&}$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

url="https://${AMOCRM_SUBDOMAIN}.${AMOCRM_DOMAIN}${path}"
[[ -n "$query" ]] && url="${url}?${query}"

args=(-sS -X "$method" "$url"
  -H "Authorization: Bearer ${AMOCRM_ACCESS_TOKEN}"
  -H "Content-Type: application/json"
  -w '\n__HTTP_STATUS__:%{http_code}')

[[ -n "$data" ]] && args+=(-d "$data")

raw=$(curl "${args[@]}")
status="${raw##*__HTTP_STATUS__:}"
body="${raw%__HTTP_STATUS__:*}"

printf '%s' "$body"

if [[ ! "$status" =~ ^2 ]]; then
  echo "amocrm-request: HTTP $status" >&2
  exit 1
fi
