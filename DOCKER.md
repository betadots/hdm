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

to save the SQLite DB files outside of the container, we habe to inject a different database.yml to change the path. When there is a mount into the container for hdm_env you might place it there, or change it to your desired location.

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

This file can be used as default file for all or only one environment. You dont need this if you have this already in your environment. But it is usefull if you have a seperate hiera repository and only mounting pseudo environments into your docker.

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

For docker compose see [`docker-compose.yaml`](docker-compose.yaml).

# Build the container

If you want to build the container locally, there is a Dockerfile for the container. This can be done with:

    cd hdm
    docker build -t hdm .
