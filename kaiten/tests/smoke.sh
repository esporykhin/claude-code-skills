#!/bin/bash
# Smoke test: checks that scripts can hit the real Kaiten API.
# Requires KAITEN_DOMAIN and KAITEN_TOKEN in env or ~/.claude/credentials.env.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "== current user =="
"$DIR/scripts/methods/current-user.sh" | jq '{id,email,full_name}'

echo "== spaces =="
"$DIR/scripts/methods/spaces-list.sh" | jq 'map({id,title}) | .[0:5]'

echo "OK"
