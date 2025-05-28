# Configuration

## hdm.yml

The main config file is divided into individual sections. Each section represents all OpenVox/Puppet environments of one Server and its control repositories (`config_dir`). So don't make the mistake of confusing the config sections here with the OpenVox/Puppet environments like production or test.

```yaml
test:
  read_only: false
  allow_encryption: true
  puppetdb:
    server: http://localhost:8082
  config_dir: /etc/puppetlabs/code

production:
  read_only: true
  allow_encryption: false
  puppetdb:
    server: http://localhost:8080
  config_dir: /etc/puppetlabs/code
```

| Key | Value |
| --------- | -------- |
| authentication_disabled | Switches off authentication and enables anonymous use. Defaults to `false`. |
| readonly | Set to `true`, no changes to values in Hiera are possible. |
| allow_encryption | Sets whether encrypted keys may be decrypted or not. |
| puppetdb | Settings for the connection to the OpenVoxDB/PuppetDB. Details see [here](#puppetdb). |
| config_dir | Path to the directory where the `environments` sub folder s stored. |
| hiera_config_file | File name of hiera config file. Default to `hiera.yaml`. |
| global_hiera_yaml | Optional. Path to the global layer's `hiera.yaml`. |
| base_module_path | Optional. If you wanna overwrite `basemodulepath` from `puppet.conf`. |
| ldap | Optional. Settings for LDAP server for authentication. Details see [here](#ldap). |
| saml | Optional. Settings for SAML service for authentication. Details see [here](#saml). |
| git_data | Optional array. Replaces hiera data in the file system with data from a git repo. Details see [here](#git_data). |

Examples are shown in [hdm.yml.template](../config/hdm.yml.template).

### puppetdb

| Subkey | Value |
| --------- | -------- |
| server | URL to connect to. When using https make sure the server name matches the one inside the certificate. |
| pem | With subkeys `key`, `cert`, `ca_file`. Paths to private key, certificate and CA cert for client cert authentication. Use a copy of these files to avoid permission problems. |
| token | Token to authenticate against `server`. |
| cacert | Optional. CA cert from OpenVox/Puppet CA to validate cert from `server`. |

### ldap

| Subkey | Value |
| --------- | -------- |
| host | LDAP server hostname or fqdn. |
| port | Connect `host` on this port. |
| base_dn | Base search. |
| bind_dn | LDAP DN to bind and use for authentication. |
| bind_dn_password | The required password for `bind_dn`. |

### saml

| Subkey | Value |
| --------- | -------- |
| sp_entity_id | The entity id. |
| idp_sso_service_url | The SAML service URL. |
| idp_cert_fingerprint | Fingerprint to validate the service certificate. Do not use both `idp_cert_fingerprint` and `idp_cert`.|
| idp_cert | CA cert to validate the service certificate. Do not use if `idp_cert_fingerprint` is already used. |

### git_data

| Subkey | Value |
| --------- | -------- |
| datadir | Absolute path to the 'live' data in the `config_dir`.. |
| git_url | Clone URL, e.g. `git@githost.example.com:puppet/hiera_data.git`. |
| path_in_repo | Relativ path of the hiera data inside the git repo. |

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

## database.yml

Only SQLite3 is currently supported as database backend. The config file `./config/database.yml` (Manual Setup) looks like the following: 

```yaml
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  database: db/production.sqlite3
```

Each section refers to the section of the same name in `hdm.yml` and defines a database for it.

| Key | Value |
| --------- | -------- |
| adapter | Database adapter, only `sqlite3` is supported. |
| pool | Size of the connection pool. |
| timeout | Connection timeout. |
| database | Path to the database file. |
