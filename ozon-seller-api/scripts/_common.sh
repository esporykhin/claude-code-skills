#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CREDENTIALS_FILE="${HOME}/.claude/credentials.env"

read_cred_from_file() {
  local key="$1"
  if [ -f "$CREDENTIALS_FILE" ]; then
    grep -E "^${key}=" "$CREDENTIALS_FILE" | tail -n1 | cut -d= -f2- || true
  fi
}

normalize_base_url() {
  local raw="$1"
  if [ -z "$raw" ]; then
    raw="https://api-seller.ozon.ru"
  fi
  if [[ "$raw" != http://* && "$raw" != https://* ]]; then
    raw="https://${raw}"
  fi
  raw="${raw%/}"
  echo "$raw"
}

load_ozon_credentials() {
  local client_id="${OZON_CLIENT_ID:-${OZON_SELLER_CLIENT_ID:-${OZON_SELLER_ID:-}}}"
  local api_key="${OZON_API_KEY:-${OZON_SELLER_API_KEY:-}}"
  local base_url="${OZON_SELLER_BASE_URL:-${OZON_BASE_URL:-}}"

  if [ -z "$client_id" ]; then
    client_id="$(read_cred_from_file OZON_CLIENT_ID)"
  fi
  if [ -z "$client_id" ]; then
    client_id="$(read_cred_from_file OZON_SELLER_ID)"
  fi
  if [ -z "$api_key" ]; then
    api_key="$(read_cred_from_file OZON_API_KEY)"
  fi
  if [ -z "$api_key" ]; then
    api_key="$(read_cred_from_file OZON_SELLER_API_KEY)"
  fi
  if [ -z "$base_url" ]; then
    base_url="$(read_cred_from_file OZON_SELLER_BASE_URL)"
  fi

  OZON_CLIENT_ID_RESOLVED="$client_id"
  OZON_API_KEY_RESOLVED="$api_key"
  OZON_BASE_URL_RESOLVED="$(normalize_base_url "$base_url")"
}

require_ozon_credentials() {
  load_ozon_credentials

  if [ -z "$OZON_CLIENT_ID_RESOLVED" ] || [ -z "$OZON_API_KEY_RESOLVED" ]; then
    echo '{"error":"OZON_CLIENT_ID and OZON_API_KEY are required. Set env vars or add them to ~/.claude/credentials.env."}' >&2
    exit 1
  fi
}

iso_utc_now() {
  python3 - <<'PY'
from datetime import datetime, timezone
print(datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ'))
PY
}

iso_utc_days_ago() {
  local days="${1:-7}"
  python3 - "$days" <<'PY'
from datetime import datetime, timezone, timedelta
import sys
print((datetime.now(timezone.utc) - timedelta(days=int(sys.argv[1]))).strftime('%Y-%m-%dT%H:%M:%SZ'))
PY
}

normalize_datetime() {
  local raw="$1"
  python3 - "$raw" <<'PY'
import re
import sys
from datetime import datetime, timezone

value = (sys.argv[1] or '').strip()
if not value:
    print('')
    raise SystemExit(0)

# Already ISO-ish with time
if 'T' in value:
    v = value.replace('Z', '+00:00')
    dt = datetime.fromisoformat(v)
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    else:
        dt = dt.astimezone(timezone.utc)
    print(dt.strftime('%Y-%m-%dT%H:%M:%SZ'))
    raise SystemExit(0)

# Date only
if re.fullmatch(r'\d{4}-\d{2}-\d{2}', value):
    dt = datetime.strptime(value, '%Y-%m-%d').replace(tzinfo=timezone.utc)
    print(dt.strftime('%Y-%m-%dT%H:%M:%SZ'))
    raise SystemExit(0)

raise SystemExit(f'Unsupported datetime format: {value}')
PY
}

csv_to_json_array() {
  local raw="${1:-}"
  python3 - "$raw" <<'PY'
import json
import sys

raw = (sys.argv[1] or '').strip()
if not raw:
    print('[]')
    raise SystemExit(0)

items = []
for part in raw.replace('\n', ',').split(','):
    item = part.strip()
    if item:
        items.append(item)

# Deduplicate while preserving order
seen = set()
out = []
for item in items:
    if item not in seen:
        seen.add(item)
        out.append(item)

print(json.dumps(out, ensure_ascii=False))
PY
}

ozon_post() {
  local endpoint="$1"
  local payload="$2"

  require_ozon_credentials

  curl -sS --location --request POST "${OZON_BASE_URL_RESOLVED}${endpoint}" \
    --header "Client-Id: ${OZON_CLIENT_ID_RESOLVED}" \
    --header "Api-Key: ${OZON_API_KEY_RESOLVED}" \
    --header 'Content-Type: application/json' \
    --data "$payload"
}

ozon_post_file() {
  local endpoint="$1"
  local payload_file="$2"

  require_ozon_credentials

  curl -sS --location --request POST "${OZON_BASE_URL_RESOLVED}${endpoint}" \
    --header "Client-Id: ${OZON_CLIENT_ID_RESOLVED}" \
    --header "Api-Key: ${OZON_API_KEY_RESOLVED}" \
    --header 'Content-Type: application/json' \
    --data "@${payload_file}"
}

ozon_request() {
  local method="$1"
  local endpoint="$2"
  local payload_file="${3:-}"

  require_ozon_credentials

  if [ -n "$payload_file" ]; then
    curl -sS --location --request "$method" "${OZON_BASE_URL_RESOLVED}${endpoint}" \
      --header "Client-Id: ${OZON_CLIENT_ID_RESOLVED}" \
      --header "Api-Key: ${OZON_API_KEY_RESOLVED}" \
      --header 'Content-Type: application/json' \
      --data "@${payload_file}"
  else
    curl -sS --location --request "$method" "${OZON_BASE_URL_RESOLVED}${endpoint}" \
      --header "Client-Id: ${OZON_CLIENT_ID_RESOLVED}" \
      --header "Api-Key: ${OZON_API_KEY_RESOLVED}" \
      --header 'Content-Type: application/json'
  fi
}
