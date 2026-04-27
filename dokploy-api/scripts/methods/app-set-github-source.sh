#!/usr/bin/env bash
# Привязать application к GitHub-репозиторию через GitHub App-провайдера.
# Usage: app-set-github-source.sh <applicationId> <githubId> <owner> <repository> [branch] [buildPath]
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
githubId="${2:?githubId required}"
owner="${3:?owner required}"
repo="${4:?repository required}"
branch="${5:-main}"
buildPath="${6:-/}"

payload=$(jq -nc \
  --arg a "$appId" \
  --arg r "$repo" \
  --arg o "$owner" \
  --arg b "$branch" \
  --arg p "$buildPath" \
  --arg g "$githubId" \
  '{applicationId:$a, repository:$r, owner:$o, branch:$b, buildPath:$p, githubId:$g, watchPaths:[]}')

dokploy_request POST application.saveGithubProvider --data "$payload"
