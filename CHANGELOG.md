# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v4.0.0](https://github.com/betadots/hdm/tree/v4.0.0) (2025-11-27)

[Full Changelog](https://github.com/betadots/hdm/compare/v3.3.0...v4.0.0)

**Implemented enhancements:**

- Show env data tree [\#654](https://github.com/betadots/hdm/issues/654)
- Allow LDAP mapping for username, email [\#588](https://github.com/betadots/hdm/issues/588)
- Allow users to log in using username instead of email address [\#575](https://github.com/betadots/hdm/issues/575)
- Add option to use HDM without PuppetDB [\#570](https://github.com/betadots/hdm/issues/570)
- Add option to write a git commit message when writing data to git [\#288](https://github.com/betadots/hdm/issues/288)
- Ability to run locally with Docker [\#155](https://github.com/betadots/hdm/issues/155)
- Implement new "data tree" view [\#690](https://github.com/betadots/hdm/pull/690) ([oneiros](https://github.com/oneiros))
- bump ruby version to 3.4.5 [\#637](https://github.com/betadots/hdm/pull/637) ([rwaffen](https://github.com/rwaffen))
- chore: update rubocop to 1.77.0 [\#612](https://github.com/betadots/hdm/pull/612) ([rwaffen](https://github.com/rwaffen))
- Enhance ldap configuration [\#601](https://github.com/betadots/hdm/pull/601) ([oneiros](https://github.com/oneiros))
- Rename email to username \(\#575\) [\#598](https://github.com/betadots/hdm/pull/598) ([oneiros](https://github.com/oneiros))

**Fixed bugs:**

- using https with puppetdb [\#674](https://github.com/betadots/hdm/issues/674)
- ActiveModel::UnknownAttributeError in LookupsController\#show [\#628](https://github.com/betadots/hdm/issues/628)
- fix\(release\): add openssl gem [\#703](https://github.com/betadots/hdm/pull/703) ([tuxmea](https://github.com/tuxmea))
- Fix inconsistently used parameters [\#676](https://github.com/betadots/hdm/pull/676) ([oneiros](https://github.com/oneiros))
- fix\(vagrant\): puppet lookup [\#644](https://github.com/betadots/hdm/pull/644) ([marcusdots](https://github.com/marcusdots))
- Fix leftover old method signature [\#634](https://github.com/betadots/hdm/pull/634) ([oneiros](https://github.com/oneiros))
- Fix delete button \(\#589\) [\#600](https://github.com/betadots/hdm/pull/600) ([oneiros](https://github.com/oneiros))

**Merged pull requests:**

- build\(deps\): bump the ruby group with 3 updates [\#685](https://github.com/betadots/hdm/pull/685) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump google-protobuf from 4.32.1 to 4.33.0 in the ruby group [\#684](https://github.com/betadots/hdm/pull/684) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump rspec-openapi from 0.19.0 to 0.20.0 in the ruby group [\#683](https://github.com/betadots/hdm/pull/683) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump rack from 3.2.2 to 3.2.3 [\#682](https://github.com/betadots/hdm/pull/682) ([dependabot[bot]](https://github.com/apps/dependabot))
- Demo setup for HDM and OpenVox Orchestrator [\#681](https://github.com/betadots/hdm/pull/681) ([tuxmea](https://github.com/tuxmea))
- build\(deps\): bump library/ruby from 3.4.5-alpine3.21 to 3.4.7-alpine3.21 [\#680](https://github.com/betadots/hdm/pull/680) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump rack from 3.2.1 to 3.2.2 [\#678](https://github.com/betadots/hdm/pull/678) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump selenium-webdriver from 4.35.0 to 4.36.0 in the ruby group [\#677](https://github.com/betadots/hdm/pull/677) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump the ruby group with 2 updates [\#673](https://github.com/betadots/hdm/pull/673) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump turbo-rails from 2.0.16 to 2.0.17 in the ruby group [\#672](https://github.com/betadots/hdm/pull/672) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump rubocop from 1.80.2 to 1.81.0 in the ruby group [\#671](https://github.com/betadots/hdm/pull/671) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump puma from 7.0.3 to 7.0.4 in the ruby group [\#670](https://github.com/betadots/hdm/pull/670) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 2 updates [\#669](https://github.com/betadots/hdm/pull/669) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump rexml from 3.4.1 to 3.4.2 [\#667](https://github.com/betadots/hdm/pull/667) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump puma from 7.0.2 to 7.0.3 in the ruby group [\#664](https://github.com/betadots/hdm/pull/664) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump google-protobuf from 4.32.0 to 4.32.1 in the ruby group [\#663](https://github.com/betadots/hdm/pull/663) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#661](https://github.com/betadots/hdm/pull/661) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump puma from 6.6.1 to 7.0.1 [\#659](https://github.com/betadots/hdm/pull/659) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump rubocop from 1.80.1 to 1.80.2 in the ruby group [\#657](https://github.com/betadots/hdm/pull/657) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump rubocop from 1.80.0 to 1.80.1 in the ruby group [\#655](https://github.com/betadots/hdm/pull/655) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group with 2 updates [\#651](https://github.com/betadots/hdm/pull/651) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump git from 4.0.4 to 4.0.5 in the ruby group [\#650](https://github.com/betadots/hdm/pull/650) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump google-protobuf from 4.31.1 to 4.32.0 in the ruby group [\#649](https://github.com/betadots/hdm/pull/649) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump rubocop-rails from 2.33.2 to 2.33.3 in the ruby group [\#648](https://github.com/betadots/hdm/pull/648) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump activestorage from 8.0.2 to 8.0.2.1 [\#647](https://github.com/betadots/hdm/pull/647) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump the ruby group with 2 updates [\#645](https://github.com/betadots/hdm/pull/645) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump the ruby group across 1 directory with 2 updates [\#643](https://github.com/betadots/hdm/pull/643) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#636](https://github.com/betadots/hdm/pull/636) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump ruby-saml from 1.18.0 to 1.18.1 [\#633](https://github.com/betadots/hdm/pull/633) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#632](https://github.com/betadots/hdm/pull/632) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 2 updates [\#626](https://github.com/betadots/hdm/pull/626) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 5 updates [\#623](https://github.com/betadots/hdm/pull/623) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update docs and screenshots regarding rename of email to use… [\#620](https://github.com/betadots/hdm/pull/620) ([lbetz](https://github.com/lbetz))
- build\(deps\): bump git from 3.1.0 to 4.0.0 [\#619](https://github.com/betadots/hdm/pull/619) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 9 updates [\#610](https://github.com/betadots/hdm/pull/610) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump rack from 3.1.15 to 3.1.16 [\#604](https://github.com/betadots/hdm/pull/604) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v3.3.0](https://github.com/betadots/hdm/tree/v3.3.0) (2025-05-28)

[Full Changelog](https://github.com/betadots/hdm/compare/v3.2.0...v3.3.0)

**Implemented enhancements:**

- feat: update to ruby 3.4.4 [\#594](https://github.com/betadots/hdm/pull/594) ([rwaffen](https://github.com/rwaffen))

**Merged pull requests:**

- Add new documentation [\#592](https://github.com/betadots/hdm/pull/592) ([lbetz](https://github.com/lbetz))
- build\(deps-dev\): bump selenium-webdriver from 4.32.0 to 4.33.0 in the ruby group [\#590](https://github.com/betadots/hdm/pull/590) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#587](https://github.com/betadots/hdm/pull/587) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group with 3 updates [\#584](https://github.com/betadots/hdm/pull/584) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump rspec-openapi from 0.18.4 to 0.19.0 in the ruby group [\#583](https://github.com/betadots/hdm/pull/583) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump rack-session from 2.1.0 to 2.1.1 [\#581](https://github.com/betadots/hdm/pull/581) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#579](https://github.com/betadots/hdm/pull/579) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 2 updates [\#574](https://github.com/betadots/hdm/pull/574) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump nokogiri from 1.18.7 to 1.18.8 [\#573](https://github.com/betadots/hdm/pull/573) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 6 updates [\#569](https://github.com/betadots/hdm/pull/569) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump faraday-retry from 2.2.1 to 2.3.0 in the ruby group [\#563](https://github.com/betadots/hdm/pull/563) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump byebug from 11.1.3 to 12.0.0 [\#562](https://github.com/betadots/hdm/pull/562) ([dependabot[bot]](https://github.com/apps/dependabot))
- enable hdm encryption [\#559](https://github.com/betadots/hdm/pull/559) ([tuxmea](https://github.com/tuxmea))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#558](https://github.com/betadots/hdm/pull/558) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v3.2.0](https://github.com/betadots/hdm/tree/v3.2.0) (2025-03-26)

[Full Changelog](https://github.com/betadots/hdm/compare/v3.1.0...v3.2.0)

**Implemented enhancements:**

- Update to Ruby 3.4.2 [\#528](https://github.com/betadots/hdm/issues/528)
- Upgrade Rails to 8.x.y [\#527](https://github.com/betadots/hdm/issues/527)
- Ensure git version is shown in footer, also in container [\#518](https://github.com/betadots/hdm/issues/518)
- Adjust diff form to new structure [\#540](https://github.com/betadots/hdm/pull/540) ([oneiros](https://github.com/oneiros))
- Pick node environment from three different options [\#538](https://github.com/betadots/hdm/pull/538) ([oneiros](https://github.com/oneiros))
- Update to rails 8 [\#537](https://github.com/betadots/hdm/pull/537) ([oneiros](https://github.com/oneiros))
- Add configurable node info section to page headers [\#498](https://github.com/betadots/hdm/pull/498) ([oneiros](https://github.com/oneiros))
- Ignore `classifier_data` hierarchies [\#497](https://github.com/betadots/hdm/pull/497) ([oneiros](https://github.com/oneiros))
- feat: switch to alpine linux [\#416](https://github.com/betadots/hdm/pull/416) ([rwaffen](https://github.com/rwaffen))

**Fixed bugs:**

- mini\_racer cannot find libv8-node, breaks build [\#553](https://github.com/betadots/hdm/issues/553)
- HDM fails to show data from foreign environment [\#512](https://github.com/betadots/hdm/issues/512)
- HDM fails when using encryption [\#507](https://github.com/betadots/hdm/issues/507)
- HDM fails to load Node data on Open Source Puppet 8 [\#503](https://github.com/betadots/hdm/issues/503)
- fix: revert back on arm to older versions due to musl incompatibility [\#554](https://github.com/betadots/hdm/pull/554) ([rwaffen](https://github.com/rwaffen))
- Fix de- and encryption controllers [\#539](https://github.com/betadots/hdm/pull/539) ([oneiros](https://github.com/oneiros))
- fix: ensure git version is shown in footer [\#523](https://github.com/betadots/hdm/pull/523) ([rwaffen](https://github.com/rwaffen))

**Closed issues:**

- Provide a vagrant environment which runs HDM in development mode \(rvm\) [\#517](https://github.com/betadots/hdm/issues/517)
- On Puppet Enterprise: unknown backend classifier\_data  [\#489](https://github.com/betadots/hdm/issues/489)
- fix rubocop 1.69.0 offenses [\#482](https://github.com/betadots/hdm/issues/482)
- Name-aliases for displaying nodes [\#473](https://github.com/betadots/hdm/issues/473)

**Merged pull requests:**

- build\(deps\): bump nokogiri from 1.18.3 to 1.18.4 [\#556](https://github.com/betadots/hdm/pull/556) ([dependabot[bot]](https://github.com/apps/dependabot))
- fix: disable rubocop Rails/Delegate. its to complicated and does not make sense here [\#550](https://github.com/betadots/hdm/pull/550) ([rwaffen](https://github.com/rwaffen))
- build\(deps\): bump the ruby group across 1 directory with 10 updates [\#549](https://github.com/betadots/hdm/pull/549) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump ruby-saml from 1.17.0 to 1.18.0 [\#546](https://github.com/betadots/hdm/pull/546) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump json from 2.10.1 to 2.10.2 [\#545](https://github.com/betadots/hdm/pull/545) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump rack from 3.1.10 to 3.1.12 [\#543](https://github.com/betadots/hdm/pull/543) ([dependabot[bot]](https://github.com/apps/dependabot))
- rvm vagrant updates [\#536](https://github.com/betadots/hdm/pull/536) ([tuxmea](https://github.com/tuxmea))
- build\(deps\): bump nokogiri from 1.18.2 to 1.18.3 [\#530](https://github.com/betadots/hdm/pull/530) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump library/ruby from 3.4.1-alpine3.21 to 3.4.2-alpine3.21 [\#525](https://github.com/betadots/hdm/pull/525) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump the ruby group across 1 directory with 2 updates [\#522](https://github.com/betadots/hdm/pull/522) ([dependabot[bot]](https://github.com/apps/dependabot))
- feat: disable Style/SafeNavigationChainLength [\#520](https://github.com/betadots/hdm/pull/520) ([rwaffen](https://github.com/rwaffen))
- feat: add Vagrant setup for testing and development [\#519](https://github.com/betadots/hdm/pull/519) ([tuxmea](https://github.com/tuxmea))
- build\(deps\): bump rack from 3.1.8 to 3.1.10 [\#516](https://github.com/betadots/hdm/pull/516) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump net-imap from 0.5.0 to 0.5.6 [\#515](https://github.com/betadots/hdm/pull/515) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump ruby from 3.3.5-slim-bookworm to 3.4.1-slim-bookworm [\#496](https://github.com/betadots/hdm/pull/496) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump actionpack from 7.2.1.1 to 7.2.2.1 [\#491](https://github.com/betadots/hdm/pull/491) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump rails-html-sanitizer from 1.6.0 to 1.6.1 [\#483](https://github.com/betadots/hdm/pull/483) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v3.1.0](https://github.com/betadots/hdm/tree/v3.1.0) (2024-12-03)

[Full Changelog](https://github.com/betadots/hdm/compare/v3.0.0...v3.1.0)

**Implemented enhancements:**

- Performance tuning PQL queries [\#366](https://github.com/betadots/hdm/issues/366)
- Upgrade to Rails 7.2 [\#463](https://github.com/betadots/hdm/pull/463) ([oneiros](https://github.com/oneiros))
- feat: do multi stage build [\#455](https://github.com/betadots/hdm/pull/455) ([rwaffen](https://github.com/rwaffen))
- Replace `inventory` with `nodes` endpoint [\#381](https://github.com/betadots/hdm/pull/381) ([oneiros](https://github.com/oneiros))

**Merged pull requests:**

- build\(deps\): bump rexml from 3.3.8 to 3.3.9 [\#470](https://github.com/betadots/hdm/pull/470) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#469](https://github.com/betadots/hdm/pull/469) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group with 2 updates [\#466](https://github.com/betadots/hdm/pull/466) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 3 updates [\#465](https://github.com/betadots/hdm/pull/465) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump actiontext from 7.1.4 to 7.1.4.1 [\#460](https://github.com/betadots/hdm/pull/460) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group with 2 updates [\#459](https://github.com/betadots/hdm/pull/459) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump importmap-rails from 2.0.2 to 2.0.3 in the ruby group [\#457](https://github.com/betadots/hdm/pull/457) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump importmap-rails from 2.0.1 to 2.0.2 in the ruby group [\#456](https://github.com/betadots/hdm/pull/456) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v3.0.0](https://github.com/betadots/hdm/tree/v3.0.0) (2024-09-26)

[Full Changelog](https://github.com/betadots/hdm/compare/v2.1.0...v3.0.0)

**Implemented enhancements:**

- Add basic system tests [\#367](https://github.com/betadots/hdm/issues/367)
- Use YJIT in our Container [\#362](https://github.com/betadots/hdm/issues/362)
- Add version to footer [\#340](https://github.com/betadots/hdm/issues/340)
- Caching files [\#332](https://github.com/betadots/hdm/issues/332)
- New feature: Show data in modules [\#331](https://github.com/betadots/hdm/issues/331)
- HDM should be able to read global hiera data [\#330](https://github.com/betadots/hdm/issues/330)
- New feature: comparing data for a node between environments [\#301](https://github.com/betadots/hdm/issues/301)
- feat: update to ruby 3.3.5 [\#437](https://github.com/betadots/hdm/pull/437) ([rwaffen](https://github.com/rwaffen))
- feat: update rubocop and implement suggestions [\#436](https://github.com/betadots/hdm/pull/436) ([rwaffen](https://github.com/rwaffen))
- Enable YJIT [\#402](https://github.com/betadots/hdm/pull/402) ([rwaffen](https://github.com/rwaffen))
- Add two very basic system tests [\#373](https://github.com/betadots/hdm/pull/373) ([oneiros](https://github.com/oneiros))
- Allow to query the module layer [\#360](https://github.com/betadots/hdm/pull/360) ([oneiros](https://github.com/oneiros))
- Show version number in footer \#340 [\#353](https://github.com/betadots/hdm/pull/353) ([oneiros](https://github.com/oneiros))
- Take global layer into account [\#351](https://github.com/betadots/hdm/pull/351) ([oneiros](https://github.com/oneiros))
- Add diff view to lookup results \#301 [\#320](https://github.com/betadots/hdm/pull/320) ([oneiros](https://github.com/oneiros))

**Merged pull requests:**

- build\(deps\): bump webrick from 1.8.1 to 1.8.2 [\#452](https://github.com/betadots/hdm/pull/452) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump sqlite3 from 1.7.3 to 2.1.0 [\#451](https://github.com/betadots/hdm/pull/451) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group with 3 updates [\#450](https://github.com/betadots/hdm/pull/450) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump google-protobuf from 4.27.3 to 4.27.5 [\#448](https://github.com/betadots/hdm/pull/448) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group with 2 updates [\#447](https://github.com/betadots/hdm/pull/447) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump turbo-rails from 2.0.7 to 2.0.8 in the ruby group [\#446](https://github.com/betadots/hdm/pull/446) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump the ruby group across 1 directory with 2 updates [\#445](https://github.com/betadots/hdm/pull/445) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump puppet from 8.8.1 to 8.9.0 in the ruby group across 1 directory [\#442](https://github.com/betadots/hdm/pull/442) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps\): bump ruby-saml from 1.16.0 to 1.17.0 [\#440](https://github.com/betadots/hdm/pull/440) ([dependabot[bot]](https://github.com/apps/dependabot))
- build\(deps-dev\): bump rubocop-rails from 2.26.0 to 2.26.1 in the ruby group [\#439](https://github.com/betadots/hdm/pull/439) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 4 updates [\#438](https://github.com/betadots/hdm/pull/438) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rexml from 3.3.4 to 3.3.6 [\#427](https://github.com/betadots/hdm/pull/427) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 2 updates [\#425](https://github.com/betadots/hdm/pull/425) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump mini\_racer from 0.13.0 to 0.14.0 in the ruby group [\#420](https://github.com/betadots/hdm/pull/420) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rexml from 3.3.2 to 3.3.3 [\#418](https://github.com/betadots/hdm/pull/418) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 3 updates [\#417](https://github.com/betadots/hdm/pull/417) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 2 updates [\#413](https://github.com/betadots/hdm/pull/413) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 3 updates [\#411](https://github.com/betadots/hdm/pull/411) ([dependabot[bot]](https://github.com/apps/dependabot))
- Updates permissions for dependabot automerge, ordering of gemfile and simplify gemfile.lock platforms [\#410](https://github.com/betadots/hdm/pull/410) ([rwaffen](https://github.com/rwaffen))
- Bump ruby from 3.3.3-slim-bookworm to 3.3.4-slim-bookworm [\#407](https://github.com/betadots/hdm/pull/407) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 3 updates [\#406](https://github.com/betadots/hdm/pull/406) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 2 updates [\#401](https://github.com/betadots/hdm/pull/401) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump ruby from 3.3.2-slim-bookworm to 3.3.3-slim-bookworm [\#399](https://github.com/betadots/hdm/pull/399) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 6 updates [\#396](https://github.com/betadots/hdm/pull/396) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump actionpack from 7.1.3.3 to 7.1.3.4 [\#393](https://github.com/betadots/hdm/pull/393) ([dependabot[bot]](https://github.com/apps/dependabot))
- .gitignore: add vendor/ruby [\#391](https://github.com/betadots/hdm/pull/391) ([bastelfreak](https://github.com/bastelfreak))
- Bump ruby from 3.3.1-slim-bookworm to 3.3.2-slim-bookworm [\#388](https://github.com/betadots/hdm/pull/388) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rails from 7.1.3.2 to 7.1.3.3 [\#384](https://github.com/betadots/hdm/pull/384) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 3 updates [\#382](https://github.com/betadots/hdm/pull/382) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rexml from 3.2.6 to 3.2.8 [\#379](https://github.com/betadots/hdm/pull/379) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump nokogiri from 1.16.4 to 1.16.5 [\#377](https://github.com/betadots/hdm/pull/377) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump git from 1.19.1 to 2.0.0 [\#376](https://github.com/betadots/hdm/pull/376) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump hiera-eyaml from 3.4.0 to 4.1.0 [\#375](https://github.com/betadots/hdm/pull/375) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.63.4 to 1.63.5 in the ruby group [\#374](https://github.com/betadots/hdm/pull/374) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.18.2 to 0.18.3 in the ruby group [\#372](https://github.com/betadots/hdm/pull/372) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group across 1 directory with 3 updates [\#371](https://github.com/betadots/hdm/pull/371) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update to Ruby 3.3.1 [\#369](https://github.com/betadots/hdm/pull/369) ([rwaffen](https://github.com/rwaffen))
- Bump the ruby group across 1 directory with 3 updates [\#368](https://github.com/betadots/hdm/pull/368) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.17.0 to 0.18.2 in the ruby group across 1 directory [\#361](https://github.com/betadots/hdm/pull/361) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.63.1 to 1.63.2 in the ruby group [\#358](https://github.com/betadots/hdm/pull/358) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group with 2 updates [\#357](https://github.com/betadots/hdm/pull/357) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump puppet from 8.5.1 to 8.6.0 in the ruby group [\#356](https://github.com/betadots/hdm/pull/356) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.63.0 to 1.63.1 in the ruby group [\#352](https://github.com/betadots/hdm/pull/352) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.62.1 to 1.63.0 in the ruby group [\#350](https://github.com/betadots/hdm/pull/350) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group with 3 updates [\#349](https://github.com/betadots/hdm/pull/349) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the ruby group with 2 updates [\#346](https://github.com/betadots/hdm/pull/346) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump faker from 3.2.3 to 3.3.0 [\#342](https://github.com/betadots/hdm/pull/342) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rdoc from 6.6.2 to 6.6.3.1 [\#341](https://github.com/betadots/hdm/pull/341) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rspec-openapi from 0.14.0 to 0.15.0 [\#339](https://github.com/betadots/hdm/pull/339) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump mini\_racer from 0.8.0 to 0.9.0 [\#338](https://github.com/betadots/hdm/pull/338) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop-rails from 2.24.0 to 2.24.1 [\#337](https://github.com/betadots/hdm/pull/337) ([dependabot[bot]](https://github.com/apps/dependabot))

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
- Bump nokogiri from 1.16.0 to 1.16.2 [\#289](https://github.com/betadots/hdm/pull/289) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump sqlite3 from 1.7.1 to 1.7.2 [\#286](https://github.com/betadots/hdm/pull/286) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update rubocop to 1.60.2 [\#285](https://github.com/betadots/hdm/pull/285) ([rwaffen](https://github.com/rwaffen))
- Bump capybara from 3.39.2 to 3.40.0 [\#282](https://github.com/betadots/hdm/pull/282) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump sqlite3 from 1.7.0 to 1.7.1 [\#280](https://github.com/betadots/hdm/pull/280) ([dependabot[bot]](https://github.com/apps/dependabot))
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

## [v1.0.1](https://github.com/betadots/hdm/tree/v1.0.1) (2023-01-31)

[Full Changelog](https://github.com/betadots/hdm/compare/v1.0.0...v1.0.1)

**Merged pull requests:**

- add upgrade infos [\#137](https://github.com/betadots/hdm/pull/137) ([rwaffen](https://github.com/rwaffen))
- add faraday middeware [\#136](https://github.com/betadots/hdm/pull/136) ([rwaffen](https://github.com/rwaffen))

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
- Key search [\#83](https://github.com/betadots/hdm/pull/83) ([oneiros](https://github.com/oneiros))

## [v0.0.2](https://github.com/betadots/hdm/tree/v0.0.2) (2022-09-13)

[Full Changelog](https://github.com/betadots/hdm/compare/v0.0.1...v0.0.2)

**Fixed bugs:**

- Dependabot - RCE bug with Serialized Columns in Active Record [\#75](https://github.com/betadots/hdm/issues/75)

**Merged pull requests:**

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

- Update docuemntation [\#74](https://github.com/betadots/hdm/pull/74) ([tuxmea](https://github.com/tuxmea))
- Bump rails-html-sanitizer from 1.4.2 to 1.4.3 [\#72](https://github.com/betadots/hdm/pull/72) ([dependabot[bot]](https://github.com/apps/dependabot))
- LDAP authentication. [\#67](https://github.com/betadots/hdm/pull/67) ([oneiros](https://github.com/oneiros))
- 61 update documentation and docker build [\#66](https://github.com/betadots/hdm/pull/66) ([rwaffen](https://github.com/rwaffen))
- Bump nokogiri from 1.13.4 to 1.13.6 [\#62](https://github.com/betadots/hdm/pull/62) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rack from 2.2.3 to 2.2.3.1 [\#60](https://github.com/betadots/hdm/pull/60) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump eventsource from 1.1.0 to 1.1.1 [\#59](https://github.com/betadots/hdm/pull/59) ([dependabot[bot]](https://github.com/apps/dependabot))
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
