# Installation (Manual)

The Hiera Data Manager (HDM) is an ruby on rails application. So we do a setup based on the Ruby Version Manager (RVM) to serve the required ruby version. In general and for older platforms, we recommend operation in a [container](#installation-via-docker).

HDM application is **served on port 3000** by default.

## Prepare

* Debian 12 and Ubuntu >= 22.04

```console
sudo apt update
sudo apt install -y apt-transport-https gpg libyaml-dev git
```

* Enterprise Linux 9

```console
sudo dnf install -y gpg libyaml-devel git
```

### Ruby Version manager (RVM)

```console
curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg --import -
curl -sSL https://get.rvm.io | sudo bash -s stable
```

## Hiera Data Manager (HDM)

To install HDM into `/opt/hdm`:

```console
sudo git clone https://github.com/betadots/hdm.git /opt/hdm
```

### Setup Ruby

Switch to user 'root' to finish the setup. First install the required ruby version with all dependent GEMs.

```console
cd /opt/hdm
source /etc/profile.d/rvm.sh
rvm install $(cat .ruby-version)
rvm use $(cat .ruby-version)
bundle config set --local path 'vendor/bundle'
bundle config set --local with 'release'
bundle install
```

### Configuration

Adapt and apply the configuration, see [here](02_Configuration.md) for more details.

```console
cp config/hdm.yml.template config/hdm.yml
vim config/hdm.yml
```

Create database and set secret.

```console
bundle exec rails db:setup
```

### Daemon

* Debian and Ubuntu

```console
DEST=/etc/default/hdm
```

* Enterprise Linux

```console
DEST=/etc/sysconfig/hdm
```

Set secret into environment file and copy it and the systemd unit to the platform depend destination.

```console
SECRET=$(openssl rand -hex 16) && sed "s|^SECRET_KEY_BASE=.*$|SECRET_KEY_BASE=${SECRET}|" config/hdm.sysconfig > $DEST
chmod 640 $DEST
sed "s|^EnvironmentFile=.*$|EnvironmentFile=${DEST}|" config/hdm.service > /etc/systemd/system/hdm.service
```

Finally reload the systemd daemon and start the HDM service:

```console
systemctl daemon-reload
systemctl enable --now hdm.service
systemctl status hdm.service
```

Optional: If you do not use `/opt/hdm` as setup folder use a drop-in override!

```console
mkdir /etc/systemd/system/hdm.service.d
```

```text
# /etc/systemd/system/hdm.service.d/override

[Service]
WorkingDirectory=
WorkingDirectory=-/usr/local/hdm
```

Do not forget to reload the systemd daemon before restart `hdm.service`.

### Start Process (maybe for Development)

If you don't wanna start the daemon via `systemd', do by hand:

```console
export RAILS_DEVELOPMENT_HOSTS=$(hostname -f)
bundle exec rails server -e production -b 0.0.0.0 -p 3000
```

The secret can also be store in memory (envvar SECRET_KEY_BASE) or as file:

```console
SECRET_KEY_BASE=$(openssl rand -hex 16)
echo $SECRET_KEY_BASE | EDITOR="vim" bundle exec rails credentials:edit
```

# Installation via Docker

To have all the HDM external parts together we recommend to put this into a sub folder called `hdm_env`.
The structure might look like this:

```text
./hdm_env
  ├── certs
  │   ├── puppetdb.ca.pem
  │   ├── puppetdb.cert.pem
  │   └── puppetdb.key.pem
  ├── database.yml
  ├── db
  │   ├── development.sqlite3
  │   ├── ...
  │   └── production.sqlite3
  ├── hdm.yml
  ├── hiera
  │   └── hiera files ...
  └── hiera.yaml
```

If you are running this directly on the puppet compiler the directory `hiera` might not be needed. But if you have `hiera` as a seperate repository this might be helpfull. You also can mount it directly in the compose file.

To avoid any trouble with access to the cert files, it might be better to copy them to `certs` directory and adjust the mode so you can use them for sure.

The folder `db` might be a volume mounted into your container to save the user database outside of the container. See [docker-compose.yaml](../docker-compose.yaml).

```yaml
---
services:
  hdm:
    image: ghcr.io/betadots/hdm:latest
    container_name: hdm
    environment:
      - TZ=Europe/Berlin
      - SECRET_KEY_BASE="a_l0ng_c0mpl3x_strinG" # f.e.: openssl rand -hex 16
    volumes:
      - ./hdm_env/db:/hdm_env/db
      - ./hdm_env/certs:/hdm_env/certs:ro
      - ./hdm_env/hdm.yml:/hdm/config/hdm.yml:ro
      - ./hdm_env/database.yml:/hdm/config/database.yml:ro
    #   #### mount hiera as data dir in each pseudo env, if you have a seperate hiera repo
    #   - /hdm_env/hiera:/etc/puppetlabs/code/environments/pre_development/data:ro
    #   - /hdm_env/hiera:/etc/puppetlabs/code/environments/development/data:ro
    #   - /hdm_env/hiera:/etc/puppetlabs/code/environments/test/data:ro
    #   - /hdm_env/hiera:/etc/puppetlabs/code/environments/production/data:ro
      #### mount actual code directory from puppetserver
      - /etc/puppetlabs/code:/etc/puppetlabs/code/:ro
    ports:
      - 3000:3000
    restart: unless-stopped
```

To save the SQLite DB files outside of the container, we habe to inject a different `database.yml` to change the path. Full details for configuration is describe [here](02_Configuration.md).

```yaml
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

production:
  <<: *default
  database: /hdm_env/db/production.sqlite3
```

## Local Build

If you wanna build the container locally, use the `Dockerfile` from this repo.

```console
DOCKER_BUILDKIT=1 docker build -t hdm .
```
