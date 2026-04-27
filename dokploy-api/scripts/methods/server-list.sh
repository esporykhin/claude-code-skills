#!/usr/bin/env bash
# Список remote-серверов в Dokploy.
# Usage: server-list.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

dokploy_request GET server.withSSHKey | jq '[.[] | {serverId, name, ipAddress, serverStatus}]'
