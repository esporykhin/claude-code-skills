#!/usr/bin/env bash
# Список SSH-ключей в Dokploy.
# Usage: sshkey-list.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

dokploy_request GET sshKey.all | jq '[.[] | {sshKeyId, name, publicKey}]'
