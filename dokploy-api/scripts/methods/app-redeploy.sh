#!/usr/bin/env bash
# Передеплоить приложение (без пересборки кода — использовать существующий image).
# Usage: app-redeploy.sh <applicationId>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
dokploy_request POST application.redeploy --data "$(jq -nc --arg a "$appId" '{applicationId:$a}')"
