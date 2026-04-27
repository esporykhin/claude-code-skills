#!/usr/bin/env bash
# Запустить ранее остановленное приложение.
# Usage: app-start.sh <applicationId>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
dokploy_request POST application.start --data "$(jq -nc --arg a "$appId" '{applicationId:$a}')"
