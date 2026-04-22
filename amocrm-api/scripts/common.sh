#!/bin/bash
# Общие функции для amoCRM скриптов.
# Загружает config/.env, валидирует обязательные переменные.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -d "$SCRIPT_DIR/../config" ]]; then
  SKILL_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
elif [[ -d "$SCRIPT_DIR/../../config" ]]; then
  SKILL_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
else
  SKILL_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
fi

CONFIG_FILE="$SKILL_ROOT/config/.env"

load_config() {
  if [[ -f "$CONFIG_FILE" ]]; then
    while IFS='=' read -r key value; do
      [[ "$key" =~ ^[[:space:]]*# ]] && continue
      [[ -z "$key" ]] && continue
      key=$(printf '%s' "$key" | xargs)
      value=$(printf '%s' "$value" | sed 's/^["'\''"]//;s/["'\''"]$//')
      # Не перезатираем переменные, явно заданные в окружении
      if [[ -z "${!key:-}" ]]; then
        export "$key=$value"
      fi
    done < "$CONFIG_FILE"
  fi

  : "${AMOCRM_DOMAIN:=amocrm.ru}"
  export AMOCRM_DOMAIN

  if [[ -z "${AMOCRM_SUBDOMAIN:-}" || -z "${AMOCRM_ACCESS_TOKEN:-}" ]]; then
    cat >&2 <<'ERR'
{"error":"AMOCRM_SUBDOMAIN или AMOCRM_ACCESS_TOKEN не заданы. Настрой config/.env или экспортни переменные."}
See: amocrm-api/config/README.md
ERR
    exit 1
  fi
}
