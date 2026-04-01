#!/bin/bash
# account-limits.sh — Check MPSTATS API usage and remaining quota
# Usage: ./account-limits.sh

if [ "$1" = "--help" ]; then
  echo "Usage: $0"
  echo "  Checks remaining API call quota for your MPSTATS account."
  echo ""
  echo "Environment:"
  echo "  MPSTATS_TOKEN — API token"
  exit 0
fi

TOKEN="${MPSTATS_TOKEN}"
if [ -z "$TOKEN" ]; then
  echo '{"error":"MPSTATS_TOKEN not set. Pass token via environment variable."}' >&2
  exit 1
fi

curl -s --location --request GET 'https://mpstats.io/api/user/report_api_limit' \
  --header "X-Mpstats-TOKEN: $TOKEN" \
  --header 'Content-Type: application/json'
