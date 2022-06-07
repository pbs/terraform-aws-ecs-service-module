#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

LATEST_GIT_TAG="$(gh api -X GET "repos/$GITHUB_REPOSITORY/tags" -f 'per_page=1' --jq '.[0].name')"

if [[ "$LATEST_GIT_TAG" == "" ]]; then
  echo "No git tags found"
  exit 1
fi

echo "$LATEST_GIT_TAG"
