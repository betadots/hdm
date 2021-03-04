# Development

Usually one needs a puppet master completeley configured.

One can use the psick vargant PE environment and spin up a centos 7 based Puppet Enterprise Master.

## Vagrant setup

The environment needs some vagrant plugins to be fully functional:

    vagrant plugin install vagrant-hostmanager vagrant-vbguest vagrant-pe_build

# PSICK - Puppet Systems Infrastructure Constructoin Kit

Now one can clone the psick repository.

    git clone https://github.com/example42/psick
    cd psick

Next on needs to install the modules. This is done by installing r10k ruby gem and running r10k.
Therefore one must have a ruby installation at hand (we recommend using the ruby-version which is mentioned in .ruby-version file (2.5.8)

    bundle install --path vendor

Now we can install the puppet modules:

    bundle exec r10k puppetfile install -v

Now we can spin up the vargant based puppet master:

    cd vagrant/environments/pe
    vargant up puppet.pe.psick.io

Next one can log in into the system:

    vagrant ssh puppet.pe.psick.io
    sudo -i

Now a puppet access token must be generated:

    # generate an access token - note: username: admin, password: puppetlabs
    puppet-access login -l 2y

If this produces an error like `Unhandled exception: locale::facet::_S_create_c_locale name not valid` you want to check your locale settings by running locale.
When running on a macOS System you have to unset the LC_CTYPE local: `unset LC_CTYPE`

Setting a localw can be done by running

    export LANG=en_US.UTF-8

## HDM

Now one can clone the hdm repository:

    cd
    git clone https://github.com/example42/hdm.git
    cd hdm/

add required packages

    yum install -y gcc-c++ sqlite-devel zlib-devel

install gems

    /opt/puppetlabs/puppet/bin/gem install bundler
    /opt/puppetlabs/puppet/bin/bundle install --path vendor


install nodejs and yarn

    curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash
    sudo yum install -y nodejs
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
    sudo yum install -y yarn

Create the database with:

    bundle exec rails db:create
    bundle exec rails db:migrate
    bundle exec rails db:seed

Start the webserver with:

    bundle exec rails server

Login:

Puppet Enterprise: `https://puppet.pe.psick.io`

Login: admin
Password: puppetlabs

HDM: `http://puppet.pe.psick.io:3000`


