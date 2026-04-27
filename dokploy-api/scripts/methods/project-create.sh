#!/usr/bin/env bash
# Создать проект.
# Usage: project-create.sh <name> [description]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

name="${1:?name required}"
desc="${2:-}"
payload=$(jq -nc --arg n "$name" --arg d "$desc" '{name:$n, description:$d}')
dokploy_request POST project.create --data "$payload"
