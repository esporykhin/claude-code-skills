#!/bin/bash
# List users in the current company.
# Usage: users-list.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"
kaiten_request GET /users
