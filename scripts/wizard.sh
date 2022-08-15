#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

GIT_ROOT=$(git rev-parse --show-toplevel)

MOD_NAME="$(git remote -v | grep origin | awk '{printf $2}' | sed -nr 's~.*/terraform-aws-([^\.]+)\.git~\1~p')"
MOD_SHORTNAME="$(echo "$MOD_NAME" | sed -nr 's~(.*)-module~\1~p' | tr -d '[:space:]')"
MOD_TITLE="${MOD_NAME//-/ }"

declare -A REPLACEMENT_KEYS=(
    ["MOD_NAME"]="$MOD_NAME"
    ["MOD_TITLE"]="$MOD_TITLE"
    ["MOD_SHORTNAME"]="$MOD_SHORTNAME"
)

pushd "$GIT_ROOT" >/dev/null
BOILERPLATE_FILES=$(fd -tf -E wizard.sh -c never .)

for BOILERPLATE_FILE in $BOILERPLATE_FILES; do
    for REPLACEMENT_KEY in "${!REPLACEMENT_KEYS[@]}"; do
        if command -v sd >/dev/null; then
            sd "$REPLACEMENT_KEY" "${REPLACEMENT_KEYS[$REPLACEMENT_KEY]}" "$BOILERPLATE_FILE"
        else
            tmp="$(mktemp)"
            sed "s/$REPLACEMENT_KEY/${REPLACEMENT_KEYS[$REPLACEMENT_KEY]}/g" "$BOILERPLATE_FILE" >"$tmp"
            mv "$tmp" "$BOILERPLATE_FILE"
        fi
    done
done
