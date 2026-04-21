#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"

exec "${ROOT_DIR}/scripts/ozon-request.sh" "POST" "/v1/product/import/prices" "$@"
