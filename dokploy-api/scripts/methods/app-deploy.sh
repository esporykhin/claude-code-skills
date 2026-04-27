#!/usr/bin/env bash
# Запустить деплой приложения.
# Usage: app-deploy.sh <applicationId>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
dokploy_request POST application.deploy --data "$(jq -nc --arg a "$appId" '{applicationId:$a}')"
