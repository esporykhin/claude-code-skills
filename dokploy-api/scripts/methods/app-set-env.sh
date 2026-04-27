#!/usr/bin/env bash
# Записать env-переменные приложения целиком (текстовый блок KEY=VALUE через перевод строки).
# Usage: app-set-env.sh <applicationId> [envFile]
#   envFile — путь к .env-файлу. Если не указан, читает stdin.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
src="${2:-}"

if [[ -n "$src" ]]; then
  env_text="$(cat "$src")"
else
  env_text="$(cat)"
fi

payload=$(jq -nc --arg a "$appId" --arg e "$env_text" '{applicationId:$a, env:$e}')
dokploy_request POST application.update --data "$payload"
