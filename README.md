# HDM - Hiera Data Manager

![Hiera Data Manager logo](/app/assets/images/logo_full.png)

Copyright 2023 betadots GmbH

This Rails application displays [Puppet](https://github.com/puppetlabs/puppet) Hiera data and offers a WebGUI to read/update/create that configuration.

You can find screenshots in the [screenshots](SCREENSHOTS.md).

## Manual installation

At the moment manual installation is only tested on macOS, CentOS 7 and 8 Streams. But we highly recommend to use the Docker image!

See [MANUAL_INSTALL.md](MANUAL_INSTALL.md)

## Automated installation

Docker containers are made available. You can find more information in [DOCKER.md](DOCKER.md).
For automated installations we recommend using Puppet code. A working profile example can be found in [PUPPET.md](PUPPET.md)

## Configuration Options

HDM needs a configuration file (hdm.yml). Location depends on installation method:

- Manual installation: within the HDM git clone in `config/hdm.yml`
- Docker installation: on the docker host in `/etc/hdm/hdm.yml`

Configurations are provided as a Hash. The main hash key describes the Rails environment HDM is running in:

- Manual installation: depending on RAILS ENVIRONMENT env var - defaults to `development`
- Docker installation: set to `production`

The following configuration options are possible:

```yaml
# hdm.yml
production:
  authentication_disabled: false    # disable user auth and management

  read_only: true                   # read/write mode?

  allow_encryption: false           # encypting eyaml

  puppet_db:                        # PuppetDB access - plain text (default)
    server: http://localhost:8080
  puppet_db:                        # PuppetDB access-  PE token auth
    server: 'https://localhost:8081'
    token: '/etc/hdm/puppetdb.token'
    cacert: '<path to cacert>'
  puppet_db:                        # PuppetDB access - SSL Cert auth
    server: 'https://localhost:8081'
    pem:
      key: <path to key>
      cert: <path to cert>
      ca_file: <path to ca_file>

  hiera_config_file: "hiera.yaml"   # hiera config file name

  config_dir: /etc/puppetlabs/code  # puppet code directory

  global_hiera_yaml: /etc/puppetlabs/puppet/hiera.yaml

  base_module_path: "/etc/puppetlabs/puppet/code:/opt/puppetlabs/puppet/modules" # optional, in case you overwrite `basemodulepath` in puppet.conf

  ldap:                             # LDAP User auth
    host: 'localhost'
    port: 389
    base_dn: 'ou=hdm,dc=nodomain'
    bind_dn: 'cn=admin,dc=nodomain'
    bind_dn_password: 'openldap'
    ldaps: false
```

## Usermanagement

Usermanagement can be disabled in HDM config file by specifying the `authentication_disabled` option.

A fresh installation needs an admin which has to be created first with the WebGUI. That admin can not read the Puppet configuration. He/She can only create/delete new users. Normal users have the ability to read/change/delete the Puppet configuration data.

## Use git repositories instead of "live" yaml files

HDM can edit live hiera yaml files directly in the file system. While this might
be fine for smaller installations, it might not be desireable in many others.

In those cases you should make sure that the user HDM runs as has no write
access to the files. If you still want to be able to make changes, you should
consider making them in a git repository instead. This will afford you a full
history of edits and the possibility to roll back changes if necessary.

HDM supports this by allowing you to substitute directories from the file system
hosting the live hiera files with directories from a git repository.

Say your live data lives in `/etc/puppetlabs/code/myenv/data`. To replace this
with data from the git repository at `githost.example.com:puppet/hiera_data.git`
where the corresponding directory is called `environments/myenv/data` add the
following to `config/hdm.yml`:

```yaml
production:
  # ... existing production config ...
  git_data:
    - datadir: /etc/puppetlabs/code/myenv/data
      git_url: git@githost.example.com:puppet/hiera_data.git
      path_in_repo: environments/myenv/data
```

You can substitute as many directories with ones from git repositories as you
like.

Please note that the user HDM runs as needs to be able to clone the repository.
Cloned repos are stored in HDM's `repos` directory. Repositories are cloned
the first time they are needed. This might take a long time, so HDM also
provides a task to prefetch all needed repositories:

```sh
bundle exec rails hdm:clone_repos
```

Any changes made to files from a git repository will be commited and pushed back
to the origin repository. Please note that HDM will not pull updates from the
origin repository and is **not** able to resolve possible conflicts, so you might
want to make sure that your repository is only edited by HDM.

## :warning: Update to >= 1.0.0

### Set rails secret

Don't forget to set SECRET_KEY_BASE env var in docker run, docker-compose, systemd or hieradata.

```shell
openssl rand -hex 16
9dea7603c008dec285e4b231602a00b2

SECRET_KEY_BASE="9dea7603c008dec285e4b231602a00b2"


docker run -it --rm -p 3000:3000 -e DEVELOP=1 -e SECRET_KEY_BASE=9dea7603c008dec285e4b231602a00b2 ghcr.io/betadots/hdm:development
```

See [`docker-compose.yaml`](docker-compose.yaml).

### Update db file

Move existing db/development.sqlite3 to db/production.sqlite3

```bash
docker exec -it <container_id> bash
mv db/development.sqlite3 db/production.sqlite3
bin/rails db:environment:set RAILS_ENV=production
```

## How to contribute?

see [CONTRIBUTING.md](CONTRIBUTING.md)
