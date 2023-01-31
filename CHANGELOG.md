# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [1.0.1](https://github.com/betadots/hdm/tree/1.0.1) (2023-01-31)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.0.0...1.0.1)

**Merged pull requests:**

- add upgrade infos [\#137](https://github.com/betadots/hdm/pull/137) ([rwaffen](https://github.com/rwaffen))
- add faraday middeware [\#136](https://github.com/betadots/hdm/pull/136) ([rwaffen](https://github.com/rwaffen))
- Bump ludeeus/action-shellcheck from 1.1.0 to 2.0.0 [\#135](https://github.com/betadots/hdm/pull/135) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v1.0.0](https://github.com/betadots/hdm/tree/v1.0.0) (2023-01-30)

[Full Changelog](https://github.com/betadots/hdm/compare/v0.0.4...v1.0.0)

**Breaking changes:**

- Running Rails in production mode [\#82](https://github.com/betadots/hdm/issues/82)
- Update and make production ready [\#106](https://github.com/betadots/hdm/pull/106) ([rwaffen](https://github.com/rwaffen))

**Implemented enhancements:**

- Switch Docker image to ruby-slim [\#118](https://github.com/betadots/hdm/issues/118)

**Closed issues:**

- Add HDM Logo to Start page [\#131](https://github.com/betadots/hdm/issues/131)
- LDAP login not working if local user with same name exists [\#117](https://github.com/betadots/hdm/issues/117)
- Requirements for v1.0.0 [\#116](https://github.com/betadots/hdm/issues/116)
- Adopt color scheme [\#115](https://github.com/betadots/hdm/issues/115)
- License [\#70](https://github.com/betadots/hdm/issues/70)

**Merged pull requests:**

- Fix loading of stimulus controllers. [\#130](https://github.com/betadots/hdm/pull/130) ([oneiros](https://github.com/oneiros))
- Improve error handling of ldap login \#117 [\#129](https://github.com/betadots/hdm/pull/129) ([oneiros](https://github.com/oneiros))
- Add license information to footer \#70 [\#128](https://github.com/betadots/hdm/pull/128) ([oneiros](https://github.com/oneiros))
- Bump globalid from 1.0.0 to 1.0.1 [\#127](https://github.com/betadots/hdm/pull/127) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rack from 2.2.4 to 2.2.6.2 [\#126](https://github.com/betadots/hdm/pull/126) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump git from 1.11.0 to 1.13.0 [\#125](https://github.com/betadots/hdm/pull/125) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump httparty from 0.20.0 to 0.21.0 [\#124](https://github.com/betadots/hdm/pull/124) ([dependabot[bot]](https://github.com/apps/dependabot))
- simplify tagging [\#122](https://github.com/betadots/hdm/pull/122) ([rwaffen](https://github.com/rwaffen))
- add release.yaml for automated release notes on new releases [\#121](https://github.com/betadots/hdm/pull/121) ([rwaffen](https://github.com/rwaffen))
- Bump rails-html-sanitizer from 1.4.3 to 1.4.4 [\#120](https://github.com/betadots/hdm/pull/120) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump loofah from 2.18.0 to 2.19.1 [\#119](https://github.com/betadots/hdm/pull/119) ([dependabot[bot]](https://github.com/apps/dependabot))
- Add Changelog for 1.0.0 [\#134](https://github.com/betadots/hdm/pull/134) ([rwaffen](https://github.com/rwaffen))
- Add logo and incorporate its colors \#115 / \#131 [\#133](https://github.com/betadots/hdm/pull/133) ([oneiros](https://github.com/oneiros))

## [v0.0.4](https://github.com/betadots/hdm/tree/v0.0.4) (2022-12-12)

[Full Changelog](https://github.com/betadots/hdm/compare/v0.0.3...v0.0.4)

**Implemented enhancements:**

- Custom 40x Error Page? [\#102](https://github.com/betadots/hdm/issues/102)
- Transfer code from hdm-pro to hdm [\#88](https://github.com/betadots/hdm/issues/88)

**Fixed bugs:**

- User deletion does open the edit page [\#109](https://github.com/betadots/hdm/issues/109)

**Closed issues:**

- Update readme and archive example42 module? [\#105](https://github.com/betadots/hdm/issues/105)
- Hiera accepts empty yaml files [\#103](https://github.com/betadots/hdm/issues/103)
- Allow reset of admin password [\#101](https://github.com/betadots/hdm/issues/101)
- How to proceed if RBAC prohibits viewing of a key? [\#96](https://github.com/betadots/hdm/issues/96)
- HDM and absolute paths in hiera.yaml [\#93](https://github.com/betadots/hdm/issues/93)
- Docker images and labels [\#81](https://github.com/betadots/hdm/issues/81)
- Setup integration environment for testing/developing [\#47](https://github.com/betadots/hdm/issues/47)

**Merged pull requests:**

- Improve and add static error pages \#102 [\#114](https://github.com/betadots/hdm/pull/114) ([oneiros](https://github.com/oneiros))
- Add task to reset admin password \#101 [\#113](https://github.com/betadots/hdm/pull/113) ([oneiros](https://github.com/oneiros))
- Upgrade data attributes to turbo syntax \#109 [\#112](https://github.com/betadots/hdm/pull/112) ([oneiros](https://github.com/oneiros))
- RBAC [\#111](https://github.com/betadots/hdm/pull/111) ([oneiros](https://github.com/oneiros))
- Bump nokogiri from 1.13.9 to 1.13.10 [\#110](https://github.com/betadots/hdm/pull/110) ([dependabot[bot]](https://github.com/apps/dependabot))
- Return empty hash if yaml file is empty. [\#104](https://github.com/betadots/hdm/pull/104) ([oneiros](https://github.com/oneiros))
- update screenshots to latest version [\#99](https://github.com/betadots/hdm/pull/99) ([tuxmea](https://github.com/tuxmea))
- Bump nokogiri from 1.13.8 to 1.13.9 [\#97](https://github.com/betadots/hdm/pull/97) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v0.0.3](https://github.com/betadots/hdm/tree/v0.0.3) (2022-10-18)

[Full Changelog](https://github.com/betadots/hdm/compare/v0.0.2...v0.0.3)

**Fixed bugs:**

- When no LDAP is configured, please disable usage of the LDAP Login fields. [\#89](https://github.com/betadots/hdm/issues/89)

**Closed issues:**

- Feature Request: Searching for hiera keys [\#4](https://github.com/betadots/hdm/issues/4)

**Merged pull requests:**

- Do not use bang method. [\#94](https://github.com/betadots/hdm/pull/94) ([oneiros](https://github.com/oneiros))
- Hide LDAP login if not configured \#89 [\#91](https://github.com/betadots/hdm/pull/91) ([oneiros](https://github.com/oneiros))
- Bump docker/login-action from 2.0.0 to 2.1.0 [\#90](https://github.com/betadots/hdm/pull/90) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump docker/build-push-action from 2 to 3 [\#86](https://github.com/betadots/hdm/pull/86) ([dependabot[bot]](https://github.com/apps/dependabot))
- Key search [\#83](https://github.com/betadots/hdm/pull/83) ([oneiros](https://github.com/oneiros))

## [v0.0.2](https://github.com/betadots/hdm/tree/v0.0.2) (2022-09-13)

[Full Changelog](https://github.com/betadots/hdm/compare/v0.0.1...v0.0.2)

**Implemented enhancements:**

- Check possibility for hdm to run locally without authentication [\#54](https://github.com/betadots/hdm/issues/54)

**Fixed bugs:**

- Dependabot - RCE bug with Serialized Columns in Active Record [\#75](https://github.com/betadots/hdm/issues/75)

**Merged pull requests:**

- Bump actions/checkout from 2 to 3 [\#85](https://github.com/betadots/hdm/pull/85) ([dependabot[bot]](https://github.com/apps/dependabot))
- Allow disabling of authentication [\#78](https://github.com/betadots/hdm/pull/78) ([oneiros](https://github.com/oneiros))
- footer updates [\#77](https://github.com/betadots/hdm/pull/77) ([tuxmea](https://github.com/tuxmea))

## [v0.0.1](https://github.com/betadots/hdm/tree/v0.0.1) (2022-08-08)

[Full Changelog](https://github.com/betadots/hdm/compare/4e2ec7e45e018f4f701e67273ee31be84c4f67de...v0.0.1)

**Implemented enhancements:**

- HDM always shows all available hierarchies even when file doe snot contin the hiera key [\#19](https://github.com/betadots/hdm/issues/19)
- HDM should be able to use 80% browser window width. [\#18](https://github.com/betadots/hdm/issues/18)
- Enable unit tests on CI [\#32](https://github.com/betadots/hdm/pull/32) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- HDM does not recognize the facts. syntax in hiera.yaml file [\#17](https://github.com/betadots/hdm/issues/17)

**Closed issues:**

- User authentication via LDAP [\#63](https://github.com/betadots/hdm/issues/63)
- Update documentation and Docker build [\#61](https://github.com/betadots/hdm/issues/61)
- Update always to latest Rails version, as far as possible  [\#38](https://github.com/betadots/hdm/issues/38)
- borken things after updates [\#37](https://github.com/betadots/hdm/issues/37)
- Update Ruby/Rails version [\#34](https://github.com/betadots/hdm/issues/34)

**Merged pull requests:**

- Bump docker/build-push-action from 3.1.0 to 3.1.1 [\#76](https://github.com/betadots/hdm/pull/76) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update docuemntation [\#74](https://github.com/betadots/hdm/pull/74) ([tuxmea](https://github.com/tuxmea))
- Bump docker/build-push-action from 3.0.0 to 3.1.0 [\#73](https://github.com/betadots/hdm/pull/73) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rails-html-sanitizer from 1.4.2 to 1.4.3 [\#72](https://github.com/betadots/hdm/pull/72) ([dependabot[bot]](https://github.com/apps/dependabot))
- LDAP authentication. [\#67](https://github.com/betadots/hdm/pull/67) ([oneiros](https://github.com/oneiros))
- 61 update documentation and docker build [\#66](https://github.com/betadots/hdm/pull/66) ([rwaffen](https://github.com/rwaffen))
- Bump nokogiri from 1.13.4 to 1.13.6 [\#62](https://github.com/betadots/hdm/pull/62) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rack from 2.2.3 to 2.2.3.1 [\#60](https://github.com/betadots/hdm/pull/60) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump eventsource from 1.1.0 to 1.1.1 [\#59](https://github.com/betadots/hdm/pull/59) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump docker/build-push-action from 2.10.0 to 3 [\#58](https://github.com/betadots/hdm/pull/58) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump docker/login-action from 1.14.1 to 2 [\#57](https://github.com/betadots/hdm/pull/57) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump docker/metadata-action from 3.7.0 to 4.0.1 [\#56](https://github.com/betadots/hdm/pull/56) ([dependabot[bot]](https://github.com/apps/dependabot))
- Upgrade to Ruby 3 / Rails 7 and remove node.js dependency [\#55](https://github.com/betadots/hdm/pull/55) ([oneiros](https://github.com/oneiros))
- Interpolate facts with a `facts.` or `trusted.` scope \#17 [\#53](https://github.com/betadots/hdm/pull/53) ([oneiros](https://github.com/oneiros))
- Add responsive breakpoints \#18 [\#52](https://github.com/betadots/hdm/pull/52) ([oneiros](https://github.com/oneiros))
- change names [\#48](https://github.com/betadots/hdm/pull/48) ([rwaffen](https://github.com/rwaffen))
- remove .DS\_Store files [\#46](https://github.com/betadots/hdm/pull/46) ([rwaffen](https://github.com/rwaffen))
- Bump docker/login-action from 1.10.0 to 1.14.1 [\#45](https://github.com/betadots/hdm/pull/45) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump docker/build-push-action from 2.5.0 to 2.10.0 [\#44](https://github.com/betadots/hdm/pull/44) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump docker/metadata-action from 3.3.0 to 3.7.0 [\#43](https://github.com/betadots/hdm/pull/43) ([dependabot[bot]](https://github.com/apps/dependabot))
- check daily if dependabot actions are up to date [\#42](https://github.com/betadots/hdm/pull/42) ([rwaffen](https://github.com/rwaffen))
- Update documentation on how to manually install HDM. [\#40](https://github.com/betadots/hdm/pull/40) ([rwaffen](https://github.com/rwaffen))
- fix broken stuff [\#39](https://github.com/betadots/hdm/pull/39) ([rwaffen](https://github.com/rwaffen))
- Create codeql-analysis.yml [\#36](https://github.com/betadots/hdm/pull/36) ([rwaffen](https://github.com/rwaffen))
- try to build a test Docker image, but do not push [\#35](https://github.com/betadots/hdm/pull/35) ([rwaffen](https://github.com/rwaffen))
- rubocop-rails: Update 2.13.2-\>2.14.2 [\#33](https://github.com/betadots/hdm/pull/33) ([bastelfreak](https://github.com/bastelfreak))
- Fix more sec alerts [\#31](https://github.com/betadots/hdm/pull/31) ([rwaffen](https://github.com/rwaffen))
- Do not run CI jobs twice [\#30](https://github.com/betadots/hdm/pull/30) ([bastelfreak](https://github.com/bastelfreak))
- Update Ruby 2.5.8-\>2.5.9 [\#28](https://github.com/betadots/hdm/pull/28) ([bastelfreak](https://github.com/bastelfreak))
- Fix more sec alerts [\#27](https://github.com/betadots/hdm/pull/27) ([rwaffen](https://github.com/rwaffen))
- update yarn and gemfile [\#26](https://github.com/betadots/hdm/pull/26) ([rwaffen](https://github.com/rwaffen))
- Enable rubocop on CI [\#25](https://github.com/betadots/hdm/pull/25) ([bastelfreak](https://github.com/bastelfreak))
- Fix webpacker [\#24](https://github.com/betadots/hdm/pull/24) ([rwaffen](https://github.com/rwaffen))
- Enable shellcheck CI [\#23](https://github.com/betadots/hdm/pull/23) ([bastelfreak](https://github.com/bastelfreak))
- Update docker env [\#22](https://github.com/betadots/hdm/pull/22) ([rwaffen](https://github.com/rwaffen))
- Bump minimist from 1.2.5 to 1.2.6 [\#21](https://github.com/betadots/hdm/pull/21) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump puma from 5.3.1 to 5.6.4 [\#20](https://github.com/betadots/hdm/pull/20) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump url-parse from 1.5.1 to 1.5.10 [\#16](https://github.com/betadots/hdm/pull/16) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump nokogiri from 1.11.5 to 1.12.5 [\#15](https://github.com/betadots/hdm/pull/15) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump follow-redirects from 1.14.7 to 1.14.8 [\#13](https://github.com/betadots/hdm/pull/13) ([dependabot[bot]](https://github.com/apps/dependabot))
- documentation for centos8 [\#10](https://github.com/betadots/hdm/pull/10) ([tuxmea](https://github.com/tuxmea))
- Bump follow-redirects from 1.13.0 to 1.14.7 [\#9](https://github.com/betadots/hdm/pull/9) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump puppet from 7.6.1 to 7.12.1 [\#8](https://github.com/betadots/hdm/pull/8) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump ini from 1.3.5 to 1.3.8 [\#7](https://github.com/betadots/hdm/pull/7) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump elliptic from 6.5.3 to 6.5.4 [\#6](https://github.com/betadots/hdm/pull/6) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump ssri from 6.0.1 to 6.0.2 [\#5](https://github.com/betadots/hdm/pull/5) ([dependabot[bot]](https://github.com/apps/dependabot))
- Enforce authentication [\#2](https://github.com/betadots/hdm/pull/2) ([oneiros](https://github.com/oneiros))
- Allow empty passwords [\#1](https://github.com/betadots/hdm/pull/1) ([oneiros](https://github.com/oneiros))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
