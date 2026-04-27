#!/usr/bin/env bash
# Статус и сводка по application.
# Usage: app-status.sh <applicationId> [--full]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
mode="${2:-}"
raw=$(dokploy_request GET application.one --query "applicationId=$appId")
if [[ "$mode" == "--full" ]]; then
  echo "$raw" | jq .
else
  echo "$raw" | jq '{
    applicationId, name, appName, applicationStatus, sourceType, autoDeploy,
    repository, owner, branch, buildPath, buildType,
    dockerfile, dockerContextPath, customGitUrl, customGitBranch,
    serverId,
    domains: [.domains[]? | {host, https, port}]
  }'
fi
