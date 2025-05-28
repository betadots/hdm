# HDM - Hiera Data Manager

![Hiera Data Manager logo](/app/assets/images/logo_full.png)

Copyright 2023-2025 betadots GmbH

This Rails application displays [Puppet](https://github.com/puppetlabs/puppet) Hiera data and offers a WebGUI to read/update/create that configuration.

## Features

* Shows where values of the key come from
* Merge values if a special behavior for their keys are given
* Optional management of data inside a git repository
* Easy to setup via container
* Authentication via
  * local SQLite database
  * LDAP and SAML connection to a Server, e.g. Microsoft Active Directory
  * Admins only manage additional user accounts, no data
* Autorization (Role Based Access Controll) via Groups
  * Down to environment, node and key level
* Smart proxy for integration in [foreman](https://github.com/betadots/foreman_hdm)

## Documentation

A complete documentation of setup and using HDM including [screenshots](doc/images) is located in [doc/](doc/).

## Installation

At the moment manual installation is only tested on Debian, Ubuntu and Enterprise Linux. But we highly recommend to use the Docker image!

To take a first look at HDM or for development purposes, starting it as a Docker container WITHOUT a persistent database is sufficient.

```console
docker run -it --rm -p 3000:3000 \
    -e DEVELOP=1 \
    -e SECRET_KEY_BASE=$(openssl rand -hex 16) \
    ghcr.io/betadots/hdm:development
```

For both setup methods, see [doc/01_Setup.md](doc/01_Setup.md). For automated docker setups we recommend using Puppet code. A working profile example can be found in [PUPPET.md](PUPPET.md)

## How to develop or contribute?

see [DEVELOPMENT.md](DEVELOPMENT.md)

see [CONTRIBUTING.md](CONTRIBUTING.md)
