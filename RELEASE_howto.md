# How to do a HDM release

## Prepare gemset

```shell
bundle config set --local path 'vendor/bundle'
bundle install
```

## Merge pull requests

1. check labels on issues and pull requests on github
1. check mentions from pull requests to issues
1. merge all desired pull requests

## Create Release PR

Please follow these instructions carefully. Ensure that you name the branch precisely as `release-vX.Y.Z` since this nomenclature is crucial for obtaining the future_version in the changelog. Your attention to this specific branch naming convention is essential for accurate version tracking in the changelog.

```shell
git switch -c release-vX.Y.Z
```

Create Changelog

```shell
export CHANGELOG_GITHUB_TOKEN="github_TOKEN"
bundle exec rake changelog
```

Check generated `CHANGELOG.md`

Add and push changes to create a release PR

```shell
git add -A
git commit -m 'Release vX.Y.Z'
git push origin release-vX.Y.Z
```

Open pull request on GitHub, add `skip-changelog` label, discuss and merge

## Create release tag

After the release PR is merged

```shell
git switch main
git pull -r
git tag vX.Y.Z
git push --tags
```

## Generate GitHub release

Open [Releases - betadots/hdm](https://github.com/betadots/hdm/releases) in browser.

Click on `Draft a new release`

Set release title to tag name (X.Y.Z)

Choose tag

Click on `generate release notes`

Publish release

Done.
