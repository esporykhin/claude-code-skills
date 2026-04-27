#!/usr/bin/env bash
# Прикрутить домен к application.
# Usage: domain-create.sh <applicationId> <host> [--port 3000] [--http-only] [--cert letsencrypt|none]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
host="${2:?host required (e.g. example.com)}"
shift 2

port=3000
https=true
cert="letsencrypt"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --port) port="$2"; shift 2 ;;
    --http-only) https=false; cert="none"; shift ;;
    --cert) cert="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

payload=$(jq -nc \
  --arg a "$appId" \
  --arg h "$host" \
  --argjson p "$port" \
  --argjson s "$https" \
  --arg c "$cert" \
  '{applicationId:$a, host:$h, https:$s, port:$p, path:"/", certificateType:$c, domainType:"application"}')

dokploy_request POST domain.create --data "$payload"
