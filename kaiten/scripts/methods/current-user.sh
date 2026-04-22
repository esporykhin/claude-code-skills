#!/bin/bash
# Current authenticated user (whoami).
# Usage: current-user.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"
kaiten_request GET /users/current
