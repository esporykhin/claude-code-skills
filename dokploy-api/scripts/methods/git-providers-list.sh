#!/usr/bin/env bash
# Список git-провайдеров (GitHub Apps, GitLab, Bitbucket, Gitea).
# Usage: git-providers-list.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

dokploy_request GET gitProvider.getAll | jq '[.[] | {gitProviderId, name, providerType, githubId: .github.githubId, githubInstallationId: .github.githubInstallationId}]'
