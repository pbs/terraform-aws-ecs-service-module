#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

GIT_ROOT=$(git rev-parse --show-toplevel)
pushd "$GIT_ROOT" > /dev/null || exit 1
if terraform-docs markdown --header-from README-HEADER.md . > README.md; then
    git add README.md
fi
