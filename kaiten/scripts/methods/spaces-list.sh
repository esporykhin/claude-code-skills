#!/bin/bash
# List all spaces.
# Usage: spaces-list.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/_common.sh"
kaiten_request GET /spaces
