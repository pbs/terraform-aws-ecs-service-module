#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY must be set. e.g. owner/repo}"
: "${GITHUB_USERNAME:?GITHUB_USERNAME must be set. e.g. owner}"

GIT_ROOT=$(git rev-parse --show-toplevel)

pushd "$GIT_ROOT" >/dev/null

if ! LATEST_GIT_TAG="$(gh api -X GET "repos/$GITHUB_REPOSITORY/tags" -f 'per_page=1' --jq '.[0].name')"; then
  LATEST_GIT_TAG="0.0.0"
fi

if [[ "$LATEST_GIT_TAG" == '0.0.0' ]] || ! [[ "$LATEST_GIT_TAG" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  NEW_GIT_TAG='0.0.1'
else
  IFS=. read -r major minor patch <<EOF
$LATEST_GIT_TAG
EOF

  RELEASE_TYPE='patch'

  echo 'Generating release notes to see what kind of release we are dealing with...'
  gh api "repos/$GITHUB_REPOSITORY/releases/generate-notes" \
    -f tag_name="new-release" \
    -f previous_tag_name="${LATEST_GIT_TAG}" \
    -q .body >CHANGELOG.md

  cat CHANGELOG.md

  if grep -q 'Breaking Changes' CHANGELOG.md; then
    RELEASE_TYPE='major'
  elif grep -q 'New Features' CHANGELOG.md; then
    RELEASE_TYPE='minor'
  fi

  NEW_GIT_TAG=''

  case "$RELEASE_TYPE" in
  major) NEW_GIT_TAG="$((major + 1)).0.0" ;;
  minor) NEW_GIT_TAG="$major.$((minor + 1)).0" ;;
  patch) NEW_GIT_TAG="$major.$minor.$((patch + 1))" ;;
  *) NEW_GIT_TAG="$RELEASE_TYPE" ;;
  esac
fi

echo "Updating README using new tag: $NEW_GIT_TAG"

if command -v sd >/dev/null; then
  # This is only really necessary for the template
  if ! grep -q 'x.y.z' README.md; then
    sd "$LATEST_GIT_TAG" 'x.y.z' README.md
  fi
  sd 'x.y.z' "$NEW_GIT_TAG" README.md
else
  tmp="$(mktemp)"
  # This is only really necessary for the template
  if ! grep -q 'x.y.z' README.md; then
    sed "s/$LATEST_GIT_TAG/x.y.z/g" README.md >"$tmp"
    mv "$tmp" README.md
  fi
  sed "s/x.y.z/$NEW_GIT_TAG/g" README.md >"$tmp"
  mv "$tmp" README.md
fi

git add README.md
git config user.name "${GITHUB_USERNAME}"
git config user.email "${GITHUB_USERNAME}@users.noreply.github.com"
git commit -m "Update README for new release: $NEW_GIT_TAG"
git push origin main
git tag "$NEW_GIT_TAG"
git push origin "$NEW_GIT_TAG"

./scripts/minify.sh

mkdir -p target
rm -f target/release.tar.gz
tar --exclude target --exclude .git -cvf target/release.tar.gz .
gh release create --generate-notes "$NEW_GIT_TAG" target/release.tar.gz
git reset --hard
