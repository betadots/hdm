# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v2.1.0](https://github.com/betadots/hdm/tree/v2.1.0) (2024-03-21)

[Full Changelog](https://github.com/betadots/hdm/compare/v2.0.0...v2.1.0)

**Implemented enhancements:**

- Add favicon [\#322](https://github.com/betadots/hdm/pull/322) ([oneiros](https://github.com/oneiros))

**Fixed bugs:**

- globs do not show data on v2.0.0 [\#329](https://github.com/betadots/hdm/issues/329)
- Interpolate variables in datadir used for globs \#329 [\#333](https://github.com/betadots/hdm/pull/333) ([oneiros](https://github.com/oneiros))

**Merged pull requests:**

- Bump sqlite3 from 1.7.2 to 1.7.3 [\#334](https://github.com/betadots/hdm/pull/334) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump turbo-rails from 2.0.4 to 2.0.5 [\#328](https://github.com/betadots/hdm/pull/328) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.62.0 to 1.62.1 [\#327](https://github.com/betadots/hdm/pull/327) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.13.0 to 0.14.0 [\#326](https://github.com/betadots/hdm/pull/326) ([dependabot[bot]](https://github.com/apps/dependabot))
- add CONTRIBUTING.md [\#325](https://github.com/betadots/hdm/pull/325) ([rwaffen](https://github.com/rwaffen))
- Update rubocop to 1.62.0 [\#324](https://github.com/betadots/hdm/pull/324) ([rwaffen](https://github.com/rwaffen))
- Bump puppet from 8.5.0 to 8.5.1 [\#321](https://github.com/betadots/hdm/pull/321) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.12.0 to 0.13.0 [\#318](https://github.com/betadots/hdm/pull/318) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop-rails from 2.23.1 to 2.24.0 [\#317](https://github.com/betadots/hdm/pull/317) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v2.0.0](https://github.com/betadots/hdm/tree/v2.0.0) (2024-03-01)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.4.1...v2.0.0)

**Implemented enhancements:**

- Allow facts in datadir [\#284](https://github.com/betadots/hdm/issues/284)
- Update to Ruby 3.3.0 [\#307](https://github.com/betadots/hdm/pull/307) ([rwaffen](https://github.com/rwaffen))
- Convert hash keys to strings \#293 [\#302](https://github.com/betadots/hdm/pull/302) ([oneiros](https://github.com/oneiros))
- Remove unused dependency `redis` [\#300](https://github.com/betadots/hdm/pull/300) ([oneiros](https://github.com/oneiros))
- Allow doing lookups [\#283](https://github.com/betadots/hdm/pull/283) ([oneiros](https://github.com/oneiros))

**Fixed bugs:**

- CI Bug with google-protobuf-3.25.2-x86\_64-linux  [\#313](https://github.com/betadots/hdm/issues/313)
- Custom function mapping not working [\#293](https://github.com/betadots/hdm/issues/293)
- using main in development mode raises exception "link\_tree argument must be a directory" [\#287](https://github.com/betadots/hdm/issues/287)

**Closed issues:**

- Update to Ruby 3.3.0? [\#305](https://github.com/betadots/hdm/issues/305)
- add git parsing to Rakefile to determine future\_version [\#259](https://github.com/betadots/hdm/issues/259)
- Foreman HDM integration [\#132](https://github.com/betadots/hdm/issues/132)
- Documentation on disabing authentication [\#79](https://github.com/betadots/hdm/issues/79)
- Documentation [\#69](https://github.com/betadots/hdm/issues/69)
- documentation how to use ldaps [\#68](https://github.com/betadots/hdm/issues/68)

**Merged pull requests:**

- Bump puppet from 8.4.0 to 8.5.0 [\#312](https://github.com/betadots/hdm/pull/312) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump listen from 3.8.0 to 3.9.0 [\#311](https://github.com/betadots/hdm/pull/311) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump turbo-rails from 2.0.3 to 2.0.4 [\#310](https://github.com/betadots/hdm/pull/310) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rails from 7.1.3 to 7.1.3.2 [\#309](https://github.com/betadots/hdm/pull/309) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update Release Howto [\#308](https://github.com/betadots/hdm/pull/308) ([rwaffen](https://github.com/rwaffen))
- Bump selenium-webdriver from 4.17.0 to 4.18.1 [\#306](https://github.com/betadots/hdm/pull/306) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump turbo-rails from 1.5.0 to 2.0.3 [\#304](https://github.com/betadots/hdm/pull/304) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.11.0 to 0.12.0 [\#303](https://github.com/betadots/hdm/pull/303) ([dependabot[bot]](https://github.com/apps/dependabot))
- move trivy to own pipeline [\#290](https://github.com/betadots/hdm/pull/290) ([rwaffen](https://github.com/rwaffen))
- Bump nokogiri from 1.16.0 to 1.16.2 [\#289](https://github.com/betadots/hdm/pull/289) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump sqlite3 from 1.7.1 to 1.7.2 [\#286](https://github.com/betadots/hdm/pull/286) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update rubocop to 1.60.2 [\#285](https://github.com/betadots/hdm/pull/285) ([rwaffen](https://github.com/rwaffen))
- Bump capybara from 3.39.2 to 3.40.0 [\#282](https://github.com/betadots/hdm/pull/282) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump sqlite3 from 1.7.0 to 1.7.1 [\#280](https://github.com/betadots/hdm/pull/280) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump peter-evans/dockerhub-description from 3 to 4 [\#279](https://github.com/betadots/hdm/pull/279) ([dependabot[bot]](https://github.com/apps/dependabot))
- Updates to documentation [\#277](https://github.com/betadots/hdm/pull/277) ([tuxmea](https://github.com/tuxmea))
- Bump selenium-webdriver from 4.16.0 to 4.17.0 [\#274](https://github.com/betadots/hdm/pull/274) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v1.4.1](https://github.com/betadots/hdm/tree/v1.4.1) (2024-01-24)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.4.0...v1.4.1)

**Implemented enhancements:**

- Initial start up page [\#234](https://github.com/betadots/hdm/issues/234)
- HDM container should be able to make use of a different port. [\#205](https://github.com/betadots/hdm/issues/205)
- Verify new config - Add option to make use of SSO [\#95](https://github.com/betadots/hdm/issues/95)
- Check possibility for hdm to run locally without authentication [\#54](https://github.com/betadots/hdm/issues/54)

**Fixed bugs:**

- HDM does not initialize database [\#275](https://github.com/betadots/hdm/issues/275)
- Unable to set a user to have API role [\#272](https://github.com/betadots/hdm/issues/272)

**Merged pull requests:**

- Permit role parameter \#272 [\#273](https://github.com/betadots/hdm/pull/273) ([oneiros](https://github.com/oneiros))
- Improve first access flow \#234 [\#271](https://github.com/betadots/hdm/pull/271) ([oneiros](https://github.com/oneiros))
- Bump puppet from 8.3.1 to 8.4.0 [\#270](https://github.com/betadots/hdm/pull/270) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump stimulus-rails from 1.3.0 to 1.3.3 [\#269](https://github.com/betadots/hdm/pull/269) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.10.0 to 0.11.0 [\#268](https://github.com/betadots/hdm/pull/268) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump net-ldap from 0.18.0 to 0.19.0 [\#267](https://github.com/betadots/hdm/pull/267) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rails from 7.1.2 to 7.1.3 [\#266](https://github.com/betadots/hdm/pull/266) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump faker from 3.2.2 to 3.2.3 [\#265](https://github.com/betadots/hdm/pull/265) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump git from 1.18.0 to 1.19.1 [\#262](https://github.com/betadots/hdm/pull/262) ([dependabot[bot]](https://github.com/apps/dependabot))
- do not ignore github action changes anymore [\#261](https://github.com/betadots/hdm/pull/261) ([rwaffen](https://github.com/rwaffen))
- also push to dockerhub [\#260](https://github.com/betadots/hdm/pull/260) ([rwaffen](https://github.com/rwaffen))
- Bump rubocop-performance from 1.20.0 to 1.20.2 [\#255](https://github.com/betadots/hdm/pull/255) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump puma from 6.4.0 to 6.4.2 [\#254](https://github.com/betadots/hdm/pull/254) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump importmap-rails from 1.2.3 to 2.0.1 [\#253](https://github.com/betadots/hdm/pull/253) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop-capybara from 2.19.0 to 2.20.0 [\#251](https://github.com/betadots/hdm/pull/251) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump factory\_bot\_rails from 6.4.2 to 6.4.3 [\#250](https://github.com/betadots/hdm/pull/250) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump dartsass-sprockets from 3.0.0 to 3.1.0 [\#249](https://github.com/betadots/hdm/pull/249) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump sqlite3 from 1.6.9 to 1.7.0 [\#247](https://github.com/betadots/hdm/pull/247) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop-rails from 2.23.0 to 2.23.1 [\#245](https://github.com/betadots/hdm/pull/245) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v1.4.0](https://github.com/betadots/hdm/tree/v1.4.0) (2024-01-10)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.3.0...v1.4.0)

**Fixed bugs:**

- fix setting hostname and port [\#257](https://github.com/betadots/hdm/pull/257) ([tuxmea](https://github.com/tuxmea))

**Closed issues:**

- Update Screenshots [\#222](https://github.com/betadots/hdm/issues/222)

**Merged pull requests:**

- Correct the CMD syntax [\#256](https://github.com/betadots/hdm/pull/256) ([tuxmea](https://github.com/tuxmea))
- Bump rubocop-rails from 2.22.2 to 2.23.0 [\#240](https://github.com/betadots/hdm/pull/240) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop-performance from 1.19.1 to 1.20.0 [\#239](https://github.com/betadots/hdm/pull/239) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump github/codeql-action from 2 to 3 [\#238](https://github.com/betadots/hdm/pull/238) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.9.0 to 0.10.0 [\#237](https://github.com/betadots/hdm/pull/237) ([dependabot[bot]](https://github.com/apps/dependabot))
- add search screenshots [\#236](https://github.com/betadots/hdm/pull/236) ([tuxmea](https://github.com/tuxmea))
- Screenshots [\#235](https://github.com/betadots/hdm/pull/235) ([tuxmea](https://github.com/tuxmea))
- how to release documentation [\#233](https://github.com/betadots/hdm/pull/233) ([tuxmea](https://github.com/tuxmea))

## [v1.3.0](https://github.com/betadots/hdm/tree/v1.3.0) (2023-12-08)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.2.0...v1.3.0)

**Implemented enhancements:**

- Allow API usage [\#87](https://github.com/betadots/hdm/issues/87)

**Fixed bugs:**

- Setting a key to an empty array produces an error [\#215](https://github.com/betadots/hdm/issues/215)
- hiera.yaml without datadir explicitly set causes an error upon selecting a node [\#204](https://github.com/betadots/hdm/issues/204)
- admin user cannot be created [\#187](https://github.com/betadots/hdm/issues/187)
- No custom lookup function allowed [\#162](https://github.com/betadots/hdm/issues/162)

**Closed issues:**

- Re-enable container scanning [\#176](https://github.com/betadots/hdm/issues/176)
- Read-only \(setting|file\) and encrypted eyaml values [\#163](https://github.com/betadots/hdm/issues/163)

**Merged pull requests:**

- Bump selenium-webdriver from 4.15.0 to 4.16.0 [\#231](https://github.com/betadots/hdm/pull/231) ([dependabot[bot]](https://github.com/apps/dependabot))
- Allow selection of hdm container port [\#229](https://github.com/betadots/hdm/pull/229) ([tuxmea](https://github.com/tuxmea))
- Bump sqlite3 from 1.6.8 to 1.6.9 [\#228](https://github.com/betadots/hdm/pull/228) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump factory\_bot\_rails from 6.2.0 to 6.4.2 [\#227](https://github.com/betadots/hdm/pull/227) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump bootstrap-icons-helper from 2.0.1 to 2.0.2 [\#226](https://github.com/betadots/hdm/pull/226) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop-rails from 2.22.1 to 2.22.2 [\#224](https://github.com/betadots/hdm/pull/224) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump bcrypt from 3.1.19 to 3.1.20 [\#223](https://github.com/betadots/hdm/pull/223) ([dependabot[bot]](https://github.com/apps/dependabot))
- add a readme as index to render screenshots page on github [\#221](https://github.com/betadots/hdm/pull/221) ([rwaffen](https://github.com/rwaffen))
- Bump friendly\_id from 5.5.0 to 5.5.1 [\#220](https://github.com/betadots/hdm/pull/220) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rails from 7.1.1 to 7.1.2 [\#219](https://github.com/betadots/hdm/pull/219) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump puppet from 8.2.0 to 8.3.1 [\#218](https://github.com/betadots/hdm/pull/218) ([dependabot[bot]](https://github.com/apps/dependabot))
- Support empty yaml array [\#217](https://github.com/betadots/hdm/pull/217) ([oneiros](https://github.com/oneiros))
- Migration to Bootstrap 5 [\#216](https://github.com/betadots/hdm/pull/216) ([oneiros](https://github.com/oneiros))
- Bump faker from 3.2.1 to 3.2.2 [\#214](https://github.com/betadots/hdm/pull/214) ([dependabot[bot]](https://github.com/apps/dependabot))
- Upgrade to rails 7.1 [\#213](https://github.com/betadots/hdm/pull/213) ([oneiros](https://github.com/oneiros))
- Fix for emtpy `defaults` section \#204 [\#212](https://github.com/betadots/hdm/pull/212) ([oneiros](https://github.com/oneiros))
- Bump rubocop-rails from 2.21.2 to 2.22.1 [\#211](https://github.com/betadots/hdm/pull/211) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump redis from 5.0.7 to 5.0.8 [\#206](https://github.com/betadots/hdm/pull/206) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.56.4 to 1.57.1 [\#203](https://github.com/betadots/hdm/pull/203) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump sqlite3 from 1.6.6 to 1.6.7 [\#199](https://github.com/betadots/hdm/pull/199) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.8.1 to 0.9.0 [\#196](https://github.com/betadots/hdm/pull/196) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump selenium-webdriver from 4.13.1 to 4.14.0 [\#195](https://github.com/betadots/hdm/pull/195) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump ruby-saml from 1.15.0 to 1.16.0 [\#194](https://github.com/betadots/hdm/pull/194) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump voxpupuli/gha-build-and-publish-a-container from 1 to 2 [\#193](https://github.com/betadots/hdm/pull/193) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop-rails from 2.21.1 to 2.21.2 [\#191](https://github.com/betadots/hdm/pull/191) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.56.3 to 1.56.4 [\#190](https://github.com/betadots/hdm/pull/190) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump selenium-webdriver from 4.12.0 to 4.13.1 [\#189](https://github.com/betadots/hdm/pull/189) ([dependabot[bot]](https://github.com/apps/dependabot))
- Set role correctly. [\#188](https://github.com/betadots/hdm/pull/188) ([oneiros](https://github.com/oneiros))
- Bump puma from 6.3.1 to 6.4.0 [\#186](https://github.com/betadots/hdm/pull/186) ([dependabot[bot]](https://github.com/apps/dependabot))
- rubocop: introduce rubocop-performance [\#182](https://github.com/betadots/hdm/pull/182) ([bastelfreak](https://github.com/bastelfreak))
- Bump selenium-webdriver and webdrivers [\#181](https://github.com/betadots/hdm/pull/181) ([dependabot[bot]](https://github.com/apps/dependabot))
- rubocop: pin to specific versions to avoid broken main branch [\#175](https://github.com/betadots/hdm/pull/175) ([bastelfreak](https://github.com/bastelfreak))
- Unify display of values \#163 [\#174](https://github.com/betadots/hdm/pull/174) ([oneiros](https://github.com/oneiros))
- update gemset [\#171](https://github.com/betadots/hdm/pull/171) ([rwaffen](https://github.com/rwaffen))
- Bump puma from 6.3.0 to 6.3.1 [\#167](https://github.com/betadots/hdm/pull/167) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump protocol-http1 from 0.15.0 to 0.15.1 [\#166](https://github.com/betadots/hdm/pull/166) ([dependabot[bot]](https://github.com/apps/dependabot))
- Allow custom lookup functions [\#165](https://github.com/betadots/hdm/pull/165) ([oneiros](https://github.com/oneiros))
- Upgrade dependencies. [\#164](https://github.com/betadots/hdm/pull/164) ([oneiros](https://github.com/oneiros))
- HDM API [\#153](https://github.com/betadots/hdm/pull/153) ([oneiros](https://github.com/oneiros))

## [v1.2.0](https://github.com/betadots/hdm/tree/v1.2.0) (2023-06-15)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.1.0...v1.2.0)

**Implemented enhancements:**

- Show current used values when selecting nodes from different environment [\#151](https://github.com/betadots/hdm/issues/151)
- Edge case: PuppetDB still has an information regarding an environment, but the environment does no longer exist on file system [\#147](https://github.com/betadots/hdm/issues/147)

**Fixed bugs:**

- Hiera data dir can not be set to a fact [\#157](https://github.com/betadots/hdm/issues/157)

**Closed issues:**

- Define a CI/CD strategy [\#3](https://github.com/betadots/hdm/issues/3)

**Merged pull requests:**

- Interpolate facts in datadir setting \#157 [\#160](https://github.com/betadots/hdm/pull/160) ([oneiros](https://github.com/oneiros))
- Bump docker/login-action from 2.1.0 to 2.2.0 [\#159](https://github.com/betadots/hdm/pull/159) ([dependabot[bot]](https://github.com/apps/dependabot))
- Display value differences to actual environment [\#158](https://github.com/betadots/hdm/pull/158) ([oneiros](https://github.com/oneiros))
- Disable environments not available in fs \#147 [\#156](https://github.com/betadots/hdm/pull/156) ([oneiros](https://github.com/oneiros))

## [v1.1.0](https://github.com/betadots/hdm/tree/v1.1.0) (2023-04-17)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.0.1...v1.1.0)

**Implemented enhancements:**

- Update to ruby 3.2.x [\#148](https://github.com/betadots/hdm/issues/148)
- show unused environments [\#140](https://github.com/betadots/hdm/issues/140)
- Add SSL offloading information [\#107](https://github.com/betadots/hdm/issues/107)
- Bump nokogiri from 1.14.2 to 1.14.3 [\#150](https://github.com/betadots/hdm/pull/150) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rack from 2.2.6.3 to 2.2.6.4 [\#145](https://github.com/betadots/hdm/pull/145) ([dependabot[bot]](https://github.com/apps/dependabot))
- update rails gems [\#144](https://github.com/betadots/hdm/pull/144) ([rwaffen](https://github.com/rwaffen))
- Bump rack from 2.2.6.2 to 2.2.6.3 [\#143](https://github.com/betadots/hdm/pull/143) ([dependabot[bot]](https://github.com/apps/dependabot))
- Initial support for SAML SSO \#95 [\#142](https://github.com/betadots/hdm/pull/142) ([oneiros](https://github.com/oneiros))

**Fixed bugs:**

- Error if datadir is not set in hiera.yaml [\#108](https://github.com/betadots/hdm/issues/108)
- Deep merge hiera defaults \#108 [\#141](https://github.com/betadots/hdm/pull/141) ([oneiros](https://github.com/oneiros))

**Closed issues:**

- Cleanup existing rubocop violations [\#29](https://github.com/betadots/hdm/issues/29)

**Merged pull requests:**

- Update to Ruby 3.2.2 [\#149](https://github.com/betadots/hdm/pull/149) ([rwaffen](https://github.com/rwaffen))
- Show unused environments and allow matching nodes to other environments [\#146](https://github.com/betadots/hdm/pull/146) ([oneiros](https://github.com/oneiros))
- Bump docker/build-push-action from 3 to 4 [\#139](https://github.com/betadots/hdm/pull/139) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v1.0.1](https://github.com/betadots/hdm/tree/v1.0.1) (2023-01-31)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.0.0...v1.0.1)

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
