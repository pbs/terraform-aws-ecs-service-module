#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'


GIT_ROOT=$(git rev-parse --show-toplevel)

create_general_hooks() {
cat <<'EOF' >> "$GIT_ROOT"/.git/hooks/pre-commit
# terraform-aws-template-hooks
GIT_ROOT=$(git rev-parse --show-toplevel)
"$GIT_ROOT"/scripts/validate.sh
"$GIT_ROOT"/scripts/format.sh
EOF

}

add_non_template_hook() {
    echo '"$GIT_ROOT"/scripts/document.sh' >> "$GIT_ROOT"/.git/hooks/pre-commit
}

get_mod_name() {
    git remote -v | grep origin | grep fetch | awk '{printf $2}' | sd '.*/terraform-aws-([^\.]+)\.git' '$1'
}

if grep -q '# terraform-aws-template-hooks' "$GIT_ROOT"/.git/hooks/pre-commit; then
    echo "You already have hooks set up in $GIT_ROOT/.git/hooks/pre-commit"
    exit 1
else
    create_general_hooks
    if [[ "$(get_mod_name)" != 'template' ]]; then
        add_non_template_hook
    fi
fi

echo "Hooks installed"
