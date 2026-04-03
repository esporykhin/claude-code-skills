#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OZON_BASE_URL="${OZON_SELLER_BASE_URL:-https://api-seller.ozon.ru}"
OZON_BASE_URL="${OZON_BASE_URL%/}"

require_ozon_credentials() {
  if [ -z "${OZON_CLIENT_ID:-}" ] || [ -z "${OZON_API_KEY:-}" ]; then
    echo '{"error":"OZON_CLIENT_ID and OZON_API_KEY not set. Pass credentials via environment variables."}' >&2
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

  curl -sS --location --request POST "${OZON_BASE_URL}${endpoint}" \
    --header "Client-Id: ${OZON_CLIENT_ID}" \
    --header "Api-Key: ${OZON_API_KEY}" \
    --header 'Content-Type: application/json' \
    --data "$payload"
}

ozon_post_file() {
  local endpoint="$1"
  local payload_file="$2"

  require_ozon_credentials

  curl -sS --location --request POST "${OZON_BASE_URL}${endpoint}" \
    --header "Client-Id: ${OZON_CLIENT_ID}" \
    --header "Api-Key: ${OZON_API_KEY}" \
    --header 'Content-Type: application/json' \
    --data "@${payload_file}"
}

ozon_request() {
  local method="$1"
  local endpoint="$2"
  local payload_file="${3:-}"

  require_ozon_credentials

  if [ -n "$payload_file" ]; then
    curl -sS --location --request "$method" "${OZON_BASE_URL}${endpoint}" \
      --header "Client-Id: ${OZON_CLIENT_ID}" \
      --header "Api-Key: ${OZON_API_KEY}" \
      --header 'Content-Type: application/json' \
      --data "@${payload_file}"
  else
    curl -sS --location --request "$method" "${OZON_BASE_URL}${endpoint}" \
      --header "Client-Id: ${OZON_CLIENT_ID}" \
      --header "Api-Key: ${OZON_API_KEY}" \
      --header 'Content-Type: application/json'
  fi
}
