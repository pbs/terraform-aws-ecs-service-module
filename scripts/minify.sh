#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

GIT_ROOT=$(git rev-parse --show-toplevel)
branch_name="$(git symbolic-ref HEAD 2>/dev/null)"

pushd "$GIT_ROOT" >/dev/null

TF_FILES="$(fd -tf . | rg .tf)"

git rm -rf .
git clean -fdx

for TF_FILE in $TF_FILES; do
  git checkout "$branch_name" -- "$TF_FILE"
done

git checkout "$branch_name" -- .tool-versions

rm -rf examples

git checkout "$branch_name" -- 'README.md'
