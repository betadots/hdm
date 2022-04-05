# Build the container

There is a Dockerfile to build a container. This can be done with:

    cd hdm
    docker build -t hdm .

# hdm_env for docker

to have all the hdm external parts together we recommend to put this into a folder called `hdm_env`.
The structure might look like this:

    hdm_env/
      ├── certs
      │   ├── puppetdb.ca.pem
      │   ├── puppetdb.cert.pem
      │   └── puppetdb.key.pem
      ├── database.yml
      ├── db
      │   ├── development.sqlite3
      │   └── test.sqlite3
      ├── hdm.yml
      ├── hiera
      │   └── hiera files ...
      └── hiera.yaml

If you are running this directly on the puppet compiler the hiera directory might not be needed. But if you have hiera as a seperate repository this might be helpfull. You also can mount it directly in the compose file.

## hdm config example

    development:
      read_only: true
      allow_encryption: false
      puppet_db:
        server: "https://puppetdb.example.com:8081"
        pem:
          key: "/hdm_env/certs/puppet.key.pem"
          cert: "/hdm_env/certs/puppet.cert.pem"
          ca_file: "/hdm_env/certs/puppet.ca.pem"
      config_dir: "/etc/puppetlabs/code"

      # if not set, the default value 'hiera.yaml' of your environment is used
      hiera_config_file: "/hdm_env/hiera.yaml"


## hdm database config example

    default: &default
      adapter: sqlite3
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      timeout: 5000

    development:
      <<: *default
      database: /hdm_env/db/development.sqlite3

    test:
      <<: *default
      database: /hdm_env/db/test.sqlite3

    production:
      <<: *default
      database: /hdm_env/db/production.sqlite3

## hdm hiera config example (Optional)

This file can be used as default file for all ore only one environment. You dont need this if you have this already in your environment.

    ---
    version: 5
    defaults:
      datadir: 'data'
      data_hash: 'yaml_data'

    hierarchy:
      - name: "Hiera general Yaml"
        paths:
          - "os/%{::os.name}-%{::os.release.full}.yaml"
          - "os/%{::os.name}-%{::os.release.major}.yaml"
          - "os/%{::os.name}.yaml"
          - "os/%{::os.family}-%{::os.release.major}.yaml"
          - "os/%{::os.family}.yaml"

      - name: "Puppet Environments"
        path: "env/%{::environment}.yaml"

      - name: "Common Yaml"
        path: "common.yaml"

# Docker Compose

For docker compose see `docker-compose.yaml` or use this example:

    ---
    version: "3.5"
    services:
      hdm:
        image: betadots/hdm
        container_name: hdm
        environment:
          - TZ=Europe/Berlin
        volumes:
          # folder to save the rails sqlite
          - /hdm_env/db:/hdm_env/db
          # certs to talk to puppetdb
          - /hdm_env/certs:/hdm_env/certs:ro
          # hdm main config
          - { type: 'bind', source: '/hdm_env/hdm.yml', target: '/hdm/config/hdm.yml', read_only: true }
          # hdm database config
          - { type: 'bind', source: '/hdm_env/database.yml', target: '/hdm/config/database.yml', read_only: true }

          ##### mount hiera as data dir
          - /hdm_env/hiera:/etc/puppetlabs/code/environments/pre_development/data:ro
          - /hdm_env/hiera:/etc/puppetlabs/code/environments/development/data:ro
          - /hdm_env/hiera:/etc/puppetlabs/code/environments/test/data:ro
          - /hdm_env/hiera:/etc/puppetlabs/code/environments/production/data:ro

        ports:
          - 3000:3000
        restart: unless-stopped
