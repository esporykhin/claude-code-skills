#!/bin/bash
# Common functions for MPSTATS scripts

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/../config/.env"

load_config() {
  if [[ -f "$CONFIG_FILE" ]]; then
    # shellcheck disable=SC1090
    source "$CONFIG_FILE"
  fi

  if [[ -z "${MPSTATS_TOKEN:-}" ]]; then
    echo '{"error":"MPSTATS_TOKEN not set. Configure config/.env or export MPSTATS_TOKEN."}' >&2
    echo "See: mpstats/config/README.md" >&2
    exit 1
  fi
}
