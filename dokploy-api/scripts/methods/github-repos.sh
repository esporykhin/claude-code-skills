#!/usr/bin/env bash
# Список репозиториев, доступных GitHub-провайдеру.
# Usage: github-repos.sh <githubId> [--full]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

githubId="${1:?githubId required (см. git-providers-list.sh)}"
mode="${2:-}"
raw=$(dokploy_request GET github.getGithubRepositories --query "githubId=$githubId")
if [[ "$mode" == "--full" ]]; then
  echo "$raw" | jq .
else
  echo "$raw" | jq -r '.[] | "\(.full_name)\t\(.default_branch)\t\(if .private then "private" else "public" end)"'
fi
