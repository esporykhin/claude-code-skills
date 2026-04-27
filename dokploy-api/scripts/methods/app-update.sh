#!/usr/bin/env bash
# Произвольное обновление полей application.
# Usage: app-update.sh <applicationId> <jsonPatch>
# Пример: app-update.sh abc123 '{"autoDeploy":true,"triggerType":"push"}'
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
patch="${2:?json patch required}"

payload=$(jq -nc --arg a "$appId" --argjson p "$patch" '{applicationId:$a} + $p')
dokploy_request POST application.update --data "$payload"
