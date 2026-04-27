#!/usr/bin/env bash
# Универсальный запрос к Dokploy API.
#
# Usage:
#   dokploy-request.sh <METHOD> <procedure> [--data '<json>'] [--query '<k=v>']
#
# Procedure — tRPC-эндпоинт без префикса /api/, например:
#   project.all, application.one, application.deploy, domain.create
#
# Examples:
#   dokploy-request.sh GET  project.all
#   dokploy-request.sh GET  application.one --query 'applicationId=abc123'
#   dokploy-request.sh POST application.deploy --data '{"applicationId":"abc123"}'
#
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${DIR}/common.sh"

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 METHOD procedure [--data JSON] [--query k=v]" >&2
  exit 1
fi

dokploy_request "$@"
