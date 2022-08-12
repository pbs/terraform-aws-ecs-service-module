#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

GIT_ROOT=$(git rev-parse --show-toplevel)
pushd "$GIT_ROOT" >/dev/null || exit 1

todo_check() {
  grep \
    -I \
    -r 'TODO' \
    --exclude todo.sh \
    --exclude todo.yml \
    --exclude-dir .git \
    .
}

if todo_check; then
  echo 'Please address TODOs before merging into main.'
  exit 1
fi
