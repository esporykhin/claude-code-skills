#!/bin/bash
# wb-search.sh — Get WB niche/subject list for research (subjects selection)
# Usage: ./wb-search.sh [d1] [d2]

if [ "$1" = "--help" ]; then
  echo "Usage: $0 [d1] [d2]"
  echo "  d1 — start date YYYY-MM-DD (default: 30 days ago)"
  echo "  d2 — end date YYYY-MM-DD (default: today)"
  echo ""
  echo "  Returns list of WB subjects/niches available for analysis."
  echo "  Use subject IDs from this list with wb-subject.sh"
  echo ""
  echo "Environment:"
  echo "  MPSTATS_TOKEN — API token (or set in config/.env)"
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

load_config
TOKEN="${MPSTATS_TOKEN}"

D1="${1:-$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d '30 days ago' +%Y-%m-%d)}"
D2="${2:-$(date +%Y-%m-%d)}"

curl -s --location --request GET \
  "https://mpstats.io/api/wb/get/subjects/select?d1=${D1}&d2=${D2}" \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
