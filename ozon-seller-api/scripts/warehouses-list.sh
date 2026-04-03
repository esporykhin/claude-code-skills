#!/bin/bash
# warehouses-list.sh — List warehouses from Ozon Seller API
# Usage: ./warehouses-list.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_common.sh
source "${SCRIPT_DIR}/_common.sh"

if [ "${1:-}" = "--help" ]; then
  echo "Usage: $0"
  echo "  Returns available warehouses for the current seller account."
  exit 0
fi

ozon_post "/v1/warehouse/list" "{}"
