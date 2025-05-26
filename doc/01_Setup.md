# Installation

The Hiera Data Manager is an ruby on rails application. So we do a setup based on the Ruby Version Manager (RVM) to serve the required ruby version.

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

Adapt and apply the configuration, see [here](02_Configuration.md) for more details.

```console
cp /opt/hdm/config/hdm.yml.template /opt/hdm/config/hdm.yml
vim /opt/hdm/config/hdm.yml
```

Create database, set secret and start the deamon.

```console
bundle exec rails db:setup
echo "secret" | EDITOR="vim" bundle exec rails credentials:edit
cp /opt/hdm/config/hdm.service /etc/systemd/system/hdm.service
systemctl daemon-reload
systemctl enable --now hdm.service
systemctl status hdm.service
```
