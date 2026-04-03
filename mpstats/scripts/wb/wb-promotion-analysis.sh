#!/bin/bash
# wb-promotion-analysis.sh — Promotion analysis for a WB subject
# Usage: ./wb-promotion-analysis.sh <subject_id> [fbs]

if [ -z "$1" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <subject_id> [fbs]"
  echo "  subject_id — WB subject id"
  echo "  fbs        — include FBS: 0 or 1 (default: 0)"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common.sh
source "$SCRIPT_DIR/../common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

SUBJECT_ID="$1"
FBS="${2:-0}"

curl -s --location --request GET \
  "https://mpstats.io/api/wb/get/subjects/promotion-analysis/${SUBJECT_ID}?fbs=${FBS}" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
