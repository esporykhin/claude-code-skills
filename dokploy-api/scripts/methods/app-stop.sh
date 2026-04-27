#!/usr/bin/env bash
# Остановить контейнер приложения.
# Usage: app-stop.sh <applicationId>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
dokploy_request POST application.stop --data "$(jq -nc --arg a "$appId" '{applicationId:$a}')"
