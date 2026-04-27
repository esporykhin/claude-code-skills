#!/usr/bin/env bash
# Создать application внутри environment.
# Usage: app-create.sh <name> <environmentId> [--server <serverId>] [--description <text>]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

name="${1:?name required}"
envId="${2:?environmentId required}"
shift 2
serverId=""
description=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --server) serverId="$2"; shift 2 ;;
    --description) description="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

payload=$(jq -nc \
  --arg n "$name" \
  --arg e "$envId" \
  --arg d "$description" \
  --arg s "$serverId" \
  '{name:$n, appName:$n, description:$d, environmentId:$e}
   + (if $s == "" then {} else {serverId:$s} end)')

dokploy_request POST application.create --data "$payload"
