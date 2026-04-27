#!/usr/bin/env bash
# Установить build type приложения.
# Usage: app-set-build-type.sh <applicationId> <buildType> [--dockerfile path] [--context dir] [--stage name]
# buildType: dockerfile | nixpacks | heroku_buildpacks | paketo_buildpacks | static | railpack
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "${DIR}/common.sh"

appId="${1:?applicationId required}"
buildType="${2:?buildType required (dockerfile|nixpacks|...)}"
shift 2

dockerfile="Dockerfile"
context="."
stage=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dockerfile) dockerfile="$2"; shift 2 ;;
    --context)    context="$2"; shift 2 ;;
    --stage)      stage="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

payload=$(jq -nc \
  --arg a "$appId" \
  --arg b "$buildType" \
  --arg d "$dockerfile" \
  --arg c "$context" \
  --arg s "$stage" \
  '{applicationId:$a, buildType:$b, dockerfile:$d, dockerContextPath:$c, dockerBuildStage:$s, herokuVersion:"24", railpackVersion:"latest"}')

dokploy_request POST application.saveBuildType --data "$payload"
