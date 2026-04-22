#!/bin/bash
# Загружает config/.env скилла и подставляет дефолты.
# НЕ затирает переменные, уже заданные в окружении.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$ROOT_DIR/config/.env"

if [[ -f "$CONFIG_FILE" ]]; then
  while IFS='=' read -r key value; do
    [[ "$key" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$key" ]] && continue
    key=$(printf '%s' "$key" | xargs)
    value=$(printf '%s' "$value" | sed 's/^["'\''"]//;s/["'\''"]$//')
    if [[ -z "${!key:-}" ]]; then
      export "$key=$value"
    fi
  done < "$CONFIG_FILE"
fi

# Backward-compat alias
if [[ -z "${YANDEX_POSITION_CHECKER_BASE_URL:-}" && -n "${LOOCL_BASE_URL:-}" ]]; then
  export YANDEX_POSITION_CHECKER_BASE_URL="$LOOCL_BASE_URL"
fi

export YANDEX_POSITION_CHECKER_BASE_URL="${YANDEX_POSITION_CHECKER_BASE_URL:-https://loocl.ru}"
YANDEX_POSITION_CHECKER_BASE_URL="${YANDEX_POSITION_CHECKER_BASE_URL%/}"
