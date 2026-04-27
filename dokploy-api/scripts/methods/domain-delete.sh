#!/usr/bin/env bash
# Удалить домен.
# Usage: domain-delete.sh <domainId>
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

domainId="${1:?domainId required}"
dokploy_request POST domain.delete --data "$(jq -nc --arg d "$domainId" '{domainId:$d}')"
