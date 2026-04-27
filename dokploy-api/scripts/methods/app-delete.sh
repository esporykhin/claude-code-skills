#!/usr/bin/env bash
# Удалить application (вместе с домом, контейнером, конфигом traefik).
# Usage: app-delete.sh <applicationId>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
dokploy_request POST application.delete --data "$(jq -nc --arg a "$appId" '{applicationId:$a}')"
