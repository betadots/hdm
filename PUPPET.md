# Profile for HDM installation

## Requirements:
  - puppetlabs-docker Module
  - must be added to a node where Puppet code gets deployed
  - must have access to Puppet DB

## HDM on Puppet server

### Puppet profile

```puppet
class profile::puppet::hdm () {
  # Ensure Docker is installed
  include docker
  # generate directories and files
  $directories = [
    '/etc/hdm',
    '/etc/hdm/db',
  ]
  $dbs = [
    '/etc/hdm/db/development.sqlite3',
    '/etc/hdm/db/production.sqlite3',
  ]
  file { $directories:
    ensure => directory,
  }
  file { '/etc/hdm/hdm.yml':
    ensure => file,
    source => 'puppet:///modules/profile/hdm/hdm.yml',
  }
  file { '/etc/hdm/database.yml':
    ensure => file,
    source => 'puppet:///modules/profile/hdm/database.yml',
  }
  file { $dbs:
    ensure => file,
  }
  # get and run the image
  docker::image { 'ghcr.io/betadots/hdm':
    image_tag => 'main',
  }

  docker::run { 'hdm':
    image    => 'ghcr.io/betadots/hdm:main',
    env      => [
      'TZ=Europe/Berlin',
      "RAILS_DEVELOPMENT_HOSTS=puppet.${trusted['extensions']['pp_network']}",
    ],
    volumes  => [
      '/etc/hdm/:/etc/hdm',
      '/etc/puppetlabs/code:/etc/puppetlabs/code:ro',
      '/etc/hdm/hdm.yml:/hdm/config/hdm.yml:ro',
      '/etc/hdm/database.yml:/hdm/config/database.yml:ro',
    ],
    hostname => "puppet.${trusted['extensions']['pp_network']}",
    ports    => ['3000'],
    net      => 'host',
  }
}
```
### HDM Database config

```yaml
---
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  database: /etc/hdm/db/development.sqlite3

test:
  <<: *default
  database: /etc/hdm/db/test.sqlite3

production:
  <<: *default
  database: /etc/hdm/db/production.sqlite3
```

### HDM config

```yaml
---
development:
  read_only: true
  allow_encryption: false
  puppet_db:
    server: "http://localhost:8080"
  config_dir: "/etc/puppetlabs/code"
```

## Deploying on a remote system (using PuppetDB SSL)

```puppet
class profile::puppet::hdm () {
  include docker
  $directories = [
    '/etc/hdm',
    '/etc/hdm/certs',
    '/etc/hdm/db',
  ]
  file { $directories:
    ensure => directory,
  }
  file { '/etc/hdm/hdm.yml':
    ensure => file,
    source => 'puppet:///modules/profile/hdm/hdm.yml',
  }
  file { '/etc/hdm/database.yml':
    ensure => file,
    source => 'puppet:///modules/profile/hdm/database.yml',
  }
  file { '/etc/hdm/certs/puppet.ca.pem':
    ensure => file,
    source => '/etc/puppetlabs/puppet/ssl/certs/ca.pem',
  }
  file { '/etc/hdm/certs/puppet.cert.pem':
    ensure => file,
    source => "/etc/puppetlabs/puppet/ssl/certs/puppet.${trusted['extensions']['pp_network']}.pem",
  }
  file { '/etc/hdm/certs/puppet.key.pem':
    ensure => file,
    source => "/etc/puppetlabs/puppet/ssl/private_keys/puppet.${trusted['extensions']['pp_network']}.pem",
  }
  $dbs = [
    '/etc/hdm/db/development.sqlite3',
    '/etc/hdm/db/production.sqlite3',
  ]
  file { $dbs:
    ensure => file,
  }
  docker::image { 'ghcr.io/betadots/hdm':
    image_tag => 'main',
  }

  docker::run { 'hdm':
    image    => 'ghcr.io/betadots/hdm:main',
    env      => [
      'TZ=Europe/Berlin',
      "RAILS_DEVELOPMENT_HOSTS=puppet.${trusted['extensions']['pp_network']}",
    ],
    volumes  => [
      '/etc/hdm/:/etc/hdm',
      '/etc/puppetlabs/code:/etc/puppetlabs/code:ro',
      '/etc/hdm/hdm.yml:/hdm/config/hdm.yml:ro',
      '/etc/hdm/database.yml:/hdm/config/database.yml:ro',
    ],
    hostname => "puppet.${trusted['extensions']['pp_network']}",
    ports    => ['3000'],
    net      => 'host',
  }
}
```

### HDM Database config

```yaml
---
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  database: /etc/hdm/db/development.sqlite3

test:
  <<: *default
  database: /etc/hdm/db/test.sqlite3

production:
  <<: *default
  database: /etc/hdm/db/production.sqlite3
```

### HDM config

```yaml
---
development:
  read_only: true
  allow_encryption: false
  puppet_db:
    server: "https://<puppetdb host>:8081"  # Adopt to your PuppetDB FQDN
    pem:
      key: "/etc/hdm/certs/puppet.key.pem"
      cert: "/etc/hdm/certs/puppet.cert.pem"
      ca_file: "/etc/hdm/certs/puppet.ca.pem"
  config_dir: "/etc/puppetlabs/code"
```
