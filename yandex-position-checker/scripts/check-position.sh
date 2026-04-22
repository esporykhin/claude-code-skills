#!/bin/bash
# check-position.sh — Universal Yandex Maps card position check via public endpoint
# Usage:
#   ./check-position.sh <target_org_url_or_id> <queries_csv_or_multiline> [lat] [lon] [radius_km]
#   ./check-position.sh <target_org_url_or_id> <queries_csv_or_multiline> <location|lat,lon> [radius_km]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "$SCRIPT_DIR/_common.sh"

if [ "${1:-}" = "--help" ] || [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
  echo "Usage: $0 <target_org_url_or_id> <queries_csv_or_multiline> [lat] [lon] [radius_km]"
  echo "   or: $0 <target_org_url_or_id> <queries_csv_or_multiline> <location|lat,lon> [radius_km]"
  echo ""
  echo "Examples:"
  echo "  $0 \"https://yandex.ru/maps/org/pilim_lyubim/188841488618/\" \"маникюр,педикюр,ногти\""
  echo "  $0 188841488618 \"маникюр\nпедикюр\" 55.595275 37.074528 2"
  echo "  $0 188841488618 \"маникюр,педикюр\" \"Москва, Тверская 7\" 2"
  echo ""
  echo "Defaults:"
  echo "  lat=55.7558 lon=37.6176 radius_km=2"
  echo "  Queries are deduplicated and limited to first 5 (free-checker parity)."
  echo ""
  echo "Configuration:"
  echo "  config/.env внутри скилла (см. config/README.md). Env-переменные переопределяют."
  echo "  YANDEX_POSITION_CHECKER_BASE_URL — API base URL, default https://loocl.ru"
  echo "  LOOCL_BASE_URL — deprecated alias (backward compatibility)"
  echo "  YANDEX_GEOCODER_API_KEY — recommended for address-based checks in Russia"
  exit 0
fi

TARGET_RAW="$1"
QUERIES_RAW="$2"
ARG3="${3:-}"
ARG4="${4:-}"
ARG5="${5:-}"

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
  RADIUS_KM="2"
elif [ -n "$ARG4" ] && is_number "$ARG3" && is_number "$ARG4"; then
  LAT="$ARG3"
  LON="$ARG4"
  RADIUS_KM="${ARG5:-2}"
else
  LOCATION="$ARG3"
  RADIUS_KM="${ARG4:-2}"
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

PAYLOAD=$(python3 - "$TARGET_RAW" "$QUERIES_RAW" "$LAT" "$LON" "$RADIUS_KM" <<'PY'
import json
import re
import sys

target_raw = sys.argv[1].strip()
queries_raw = sys.argv[2]
lat = float(sys.argv[3])
lon = float(sys.argv[4])
radius_km = float(sys.argv[5])

queries = []
for q in re.split(r"[\n,]", queries_raw):
    q = q.strip()
    if q and q not in queries:
        queries.append(q)
queries = queries[:5]

if not queries:
    raise SystemExit("No valid queries provided")

if re.fullmatch(r"\d+", target_raw):
    target = {"targetOrgId": target_raw}
else:
    m = re.search(r"/org/[^/]*?/(\d+)", target_raw) or re.search(r"/org/(\d+)", target_raw)
    if m:
        target = {"targetOrgId": m.group(1)}
    elif target_raw.startswith("http"):
        target = {"targetOrgUrl": target_raw}
    else:
        target = {"targetOrgId": target_raw}

payload = {
    "queries": queries,
    **target,
    "coordinates": {
        "lat": lat,
        "lon": lon,
    },
    "radiusKm": radius_km,
}

print(json.dumps(payload, ensure_ascii=False))
PY
)

curl -sS --location --request POST "${BASE_URL}/api/tools/check-positions" \
  --header 'Content-Type: application/json' \
  --data "$PAYLOAD"
