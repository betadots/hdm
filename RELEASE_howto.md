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

```shell
export CHANGELOG_GITHUB_TOKEN="github_TOKEN"
git switch -c release/X.Y.Z
```

edit `Rakefile`, search replace `future_release`

```text
    config.future_release = 'X.Y.Z'
```

Create Changelog

```shell
bundle exec rake changelog
```

check generated changlog

Create release pull request

```shell
git add -A
git commit -m 'Release vX.Y.Z'
git push
```

Open pull request on GitHub, add `skip-changelog` label and merge

## Set release tag

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
