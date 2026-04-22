#!/bin/bash
# check-position-free.sh — Free-checker-style input mapped to check-positions endpoint
# Usage:
#   ./check-position-free.sh <organization_url_or_id> <keywords_csv_or_multiline> [latitude] [longitude] [radius_meters] [organization_name]
#   ./check-position-free.sh <organization_url_or_id> <keywords_csv_or_multiline> <location|lat,lon|address> [radius_meters] [organization_name]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "$SCRIPT_DIR/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
  echo "Usage: $0 <organization_url_or_id> <keywords_csv_or_multiline> [latitude] [longitude] [radius_meters] [organization_name]"
  echo "   or: $0 <organization_url_or_id> <keywords_csv_or_multiline> <location|lat,lon|address> [radius_meters] [organization_name]"
  echo ""
  echo "Example:"
  echo "  $0 \"https://yandex.ru/maps/org/pilim_lyubim/188841488618/\" \"маникюр,педикюр,ногти\" 55.595275 37.074528 2000 \"Пилим Любим\""
  echo "  $0 \"https://yandex.ru/maps/org/pilim_lyubim/188841488618/\" \"маникюр,педикюр\" \"Москва, Тверская 7\" 2000 \"Пилим Любим\""
  echo ""
  echo "Notes:"
  echo "  - radius_meters is converted to radiusKm"
  echo "  - queries are deduplicated and limited to first 5 (UI parity)"
  echo "  - organization_name is accepted for compatibility, but not sent"
  echo ""
  echo "Configuration:"
  echo "  config/.env внутри скилла (см. config/README.md). Env-переменные переопределяют."
  echo "  YANDEX_POSITION_CHECKER_BASE_URL — API base URL, default https://loocl.ru"
  echo "  LOOCL_BASE_URL — deprecated alias (backward compatibility)"
  echo "  YANDEX_GEOCODER_API_KEY — recommended for address-based checks in Russia"
  exit 0
fi

ORG_RAW="$1"
KEYWORDS_RAW="$2"
ARG3="${3:-}"
ARG4="${4:-}"
ARG5="${5:-}"
ARG6="${6:-}"

is_number() {
  [[ "$1" =~ ^-?[0-9]+([.][0-9]+)?$ ]]
}

resolve_location() {
  local location="$1"
  python3 - "$location" <<'PY'
import json
import os
import re
import sys
import urllib.parse
import urllib.request

location = (sys.argv[1] or "").strip()
ua = "yandex-position-checker-skill/1.0"

def emit(lat, lon, source):
    print(f"{float(lat)} {float(lon)} {source}")

pair = re.fullmatch(r"(-?\d+(?:\.\d+)?)\s*[,; ]\s*(-?\d+(?:\.\d+)?)", location)
if pair:
    emit(pair.group(1), pair.group(2), "inline-coords")
    raise SystemExit(0)

if location.lower() in {"auto", "ip", "geoip"}:
    raise SystemExit("Auto IP geolocation is disabled. Pass an address or coordinates.")

yandex_key = os.getenv("YANDEX_GEOCODER_API_KEY", "").strip()
if yandex_key:
    y_url = (
        "https://geocode-maps.yandex.ru/1.x/?format=json&results=1"
        + "&apikey=" + urllib.parse.quote(yandex_key)
        + "&geocode=" + urllib.parse.quote(location)
    )
    y_req = urllib.request.Request(y_url, headers={"User-Agent": ua})
    try:
        with urllib.request.urlopen(y_req, timeout=15) as resp:
            y_data = json.load(resp)
        members = (
            y_data.get("response", {})
            .get("GeoObjectCollection", {})
            .get("featureMember", [])
        )
        if members:
            pos = (
                members[0]
                .get("GeoObject", {})
                .get("Point", {})
                .get("pos", "")
                .strip()
            )
            if pos:
                lon, lat = pos.split()
                emit(lat, lon, "yandex-geocoder")
                raise SystemExit(0)
    except Exception:
        pass

n_url = (
    "https://nominatim.openstreetmap.org/search?format=jsonv2&limit=1"
    + "&accept-language=ru"
    + "&q=" + urllib.parse.quote(location)
)
n_req = urllib.request.Request(
    n_url,
    headers={
        "User-Agent": ua,
        "Accept": "application/json",
    },
)
with urllib.request.urlopen(n_req, timeout=15) as resp:
    n_data = json.load(resp)
if not n_data:
    raise SystemExit(f"Unable to geocode address: {location}")
emit(n_data[0]["lat"], n_data[0]["lon"], "nominatim")
PY
}

if [ -z "$ARG3" ]; then
  LAT="55.7558"
  LON="37.6176"
  RADIUS_METERS="2000"
  ORG_NAME="${ARG6:-}"
elif [ -n "$ARG4" ] && is_number "$ARG3" && is_number "$ARG4"; then
  LAT="$ARG3"
  LON="$ARG4"
  RADIUS_METERS="${ARG5:-2000}"
  ORG_NAME="${ARG6:-}"
else
  LOCATION="$ARG3"
  RADIUS_METERS="${ARG4:-2000}"
  ORG_NAME="${ARG5:-}"
  if ! RESOLVED="$(resolve_location "$LOCATION")"; then
    exit 1
  fi
  read -r LAT LON LOCATION_SOURCE <<<"$RESOLVED"
  if [ -z "${LAT:-}" ] || [ -z "${LON:-}" ]; then
    echo "Unable to resolve location: ${LOCATION}" >&2
    exit 1
  fi
  echo "Resolved location '${LOCATION}' -> lat=${LAT}, lon=${LON} (${LOCATION_SOURCE})" >&2
fi

BASE_URL="$YANDEX_POSITION_CHECKER_BASE_URL"

PAYLOAD=$(python3 - "$ORG_RAW" "$KEYWORDS_RAW" "$LAT" "$LON" "$RADIUS_METERS" "$ORG_NAME" <<'PY'
import json
import re
import sys

org_raw = sys.argv[1].strip()
keywords_raw = sys.argv[2]
lat = float(sys.argv[3])
lon = float(sys.argv[4])
radius_meters = float(sys.argv[5])
organization_name = sys.argv[6].strip()

queries = []
for q in re.split(r"[\n,]", keywords_raw):
    q = q.strip()
    if q and q not in queries:
        queries.append(q)
queries = queries[:5]

if not queries:
    raise SystemExit("No valid queries provided")

if re.fullmatch(r"\d+", org_raw):
    target = {"targetOrgId": org_raw}
else:
    m = re.search(r"/org/[^/]*?/(\d+)", org_raw) or re.search(r"/org/(\d+)", org_raw)
    if m:
        target = {"targetOrgId": m.group(1)}
    elif org_raw.startswith("http"):
        target = {"targetOrgUrl": org_raw}
    else:
        target = {"targetOrgId": org_raw}

payload = {
    "queries": queries,
    **target,
    "coordinates": {
        "lat": lat,
        "lon": lon,
    },
    "radiusKm": radius_meters / 1000.0,
}

# Compatibility arg with free-checker form; not sent to endpoint.
_ = organization_name

print(json.dumps(payload, ensure_ascii=False))
PY
)

curl -sS --location --request POST "${BASE_URL}/api/tools/check-positions" \
  --header 'Content-Type: application/json' \
  --data "$PAYLOAD"
