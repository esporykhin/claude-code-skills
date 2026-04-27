#!/usr/bin/env bash
# Привязать application к произвольному git-репозиторию (через SSH-ключ Dokploy).
# Usage: app-set-git-source.sh <applicationId> <gitUrl> [branch] [buildPath] [sshKeyId]
# Пример gitUrl: git@github.com:owner/repo.git  или  https://github.com/owner/repo.git
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
gitUrl="${2:?gitUrl required}"
branch="${3:-main}"
buildPath="${4:-/}"
sshKeyId="${5:-}"

payload=$(jq -nc \
  --arg a "$appId" \
  --arg u "$gitUrl" \
  --arg b "$branch" \
  --arg p "$buildPath" \
  --arg s "$sshKeyId" \
  '{applicationId:$a, customGitUrl:$u, customGitBranch:$b, customGitBuildPath:$p, sourceType:"git", watchPaths:[], enableSubmodules:false}
   + (if $s == "" then {} else {customGitSSHKeyId:$s} end)')

dokploy_request POST application.saveGitProvider --data "$payload"
