# Release

## On a fork

Please follow these instructions carefully.
Ensure that you name the branch precisely as `release-vX.Y.Z`
since this nomenclature is crucial for obtaining the `future_version` in the changelog.
Your attention to this specific branch naming convention is essential for accurate version tracking in the changelog.

```shell
export RELEASE_VERSION="X.Y.Z"
git switch main
git pull --rebase
git switch -c release-v$RELEASE_VERSION

bundle config set --local path vendor/bundle
bundle config set --local with 'release'
bundle install

CHANGELOG_GITHUB_TOKEN="token_MC_tokenface" bundle exec rake changelog
git commit --all --message "Release v${RELEASE_VERSION}"
git push --set-upstream origin HEAD
```

Then open a PR, discuss and merge.

## After the merge, as a maintainer on upstream

```shell
git switch main
git pull --rebase
git tag v$RELEASE_VERSION -m "v$RELEASE_VERSION"
git push --tags
```
