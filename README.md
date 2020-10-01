# Hiera Data Manager

Hiera Data Manager, aka HDM, is a webfrontend for vizualising and managing Hiera data.

The data is able to be viewed and modified by a person:
* without knowledge on Git
* without knowledge on Puppet
* simply with a web browser

#### Table of Contents

1. [Prerequisites](#prerequisites)
1. [Using HDM](#using-hdm)
1. [Development Setup](#development-setup)
1. [Production Setup](#production-setup)

## Prerequisites:

1. you must have a hiera.yaml file in each Puppet environment
1. you must use config version 5
1. you must set defaults like data\_hash in hiera.yaml file
1. you must access PuppetDB via https (either with certificate or token)
1. Hiera Data must be in directory data within puppet environment

# Using HDM

HDM starts with letting you select a desired environment where you want to check or change data.

![select environment](/docs/hdm/02_HDM_env.png)

Next you can select a node. We query PuppetDB to find existing environments, nodes and their facter values:

![select node](/docs/hdm/03_HDM_node.png)

Now you can see all hiera keys a node has within the environment hiera data:

![hiera keys](/docs/hdm/04_HDM_node_data.png)

When selecting a key we show the hierachies and vizualize whether a hierarchy has data for a key and which one is the default:

![hiera data](/docs/hdm/05_HDM_node_data_view.png)

You can now change data on node level.
HDM writes the data back to a file.

## Development Setup

You need a Puppet Master with PupeptDB. The most simple approach is to use our PSICK vagrant environemnts.

1. Preparation (on Workstation)

Besides vagrant you need two plugins:

    # You need the pe_build plugin
    vagrant plugin install vagrant-pe_build
    # You need the vagrant-vbguest plugin to inject the vbguest extension into the box at runtime
    vagrant plugin install vagrant-vbguest

If you want to connect mupltiple machines you want to install vagrant hostmanager plugin:

    # Optional (might require your sudo password when starting VM with vagrant
    # the plugin will add ip/hostname to your local machine /etc/hosts file)
    vagrant plugin install vagrant-hostmanager

If any of the commands cuase errors, please verify that you are using system ruby.
If you are using `rvm` you can check with `rvm list` and switch to system ruby running `rvm use system`

2. Use vagrant from PSICK repo

Now you can clone PSICK repo:

    git clone https://github.com/example42/psick.git
    cd psick/vagrant/environments/pe
    # Start the puppet. It will download PE tarball, install it and run puppet agent
    vagrant up puppet.pe.psick.io
    vagrant reload puppet.pe.psick.io   # In case of errors. See Note 1
    vagrant provision puppet.pe.psick.io # See Note 1

Note 1: The first time a new PE tarball is downloaded from the net you may have an error as what follows, when provisioning the puppet:

    bash: line 2: /vagrant/.pe_build/puppet-enterprise-2016.2.1-el-7-x86_64/puppet-enterprise-installer: No such file or directory

It looks like the newly downloaded PE tarball, placed in the `.pe_build` directory of this Vagrant environment, is not immediately available on the VM under its `/vagrant` directory.


    # Login into puppet
    vagrant ssh puppet.pe.psick.io
    sudo -i

Next the puppet access token is required:

    # generate an access token - note: username: admin, password: puppetlabs
    puppet-access login -l 2y

If this produces an error like `Unhandled exception: locale::facet::_S_create_c_locale name not valid` you want to check your locale settings by running `locale`.
When running on a macOS System you have to unset the LC\_CTYPE local: `unset LC_CTYPE`


3. Clone HDM repo:

```
    cd
    git clone https://github.com/example42/hdm.git
    cd hdm/
```

4. add required packages

```
    yum install -y gcc-c++ sqlite-devel zlib-devel
```


5. sqlite database
  it's just a file, no need to configure any service

6. install gems

```
    /opt/puppetlabs/puppet/bin/gem install bundler
    /opt/puppetlabs/puppet/bin/bundle install --path vendor
```

7. install nodejs and yarn

```
    curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash
    sudo yum install -y nodejs
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
    sudo yum install -y yarn
```


8. yarn updates

```
    /opt/puppetlabs/puppet/bin/bundle exec yarn install --check-files
```

9. generate db content

```
    /opt/puppetlabs/puppet/bin/bundle exec rails db:migrate
```

10. run hdm:

You can use our start shell script `bash ./start.sh` or you can run the following set of commands:

    # Where can HDM find the Puppet environemnts directory?
    export HDM__CONFIG_DIR="/etc/puppetlabs/code"

    # At the moment having PuppetDB is a hard requirement. HDM gets list of Puppet environments and nodes from PuppetDB
    export HDM__PUPPET_DB__ENABLED=true
    # If you are using a self signed certificate, you need to set:
    export HDM__PUPPET_DB__SELF_SIGNED_CERT=true
    # URL of PuppetDB service - we prefer https
    export HDM__PUPPET_DB__SERVER="https://localhost:8081"
    # In Puppet Enterprise one can use a token to access PuppetDB. In Puppet Open SOurce you need to configre a SSL certificate and add it to PuppetDB whitelisted clients
    export HDM__PUPPET_DB__TOKEN=$(cat ~/.puppetlabs/token)

    # HDM can now run in read-only mode:
    export HDM__READ_ONLY=true

    export WEBPACKER_DEV_SERVER_HOST=0.0.0.0
    export RAILS_ENV=development
    /opt/puppetlabs/puppet/bin/bundle exec ./bin/webpack-dev-server &
    /opt/puppetlabs/puppet/bin/bundle exec rails s -b 0.0.0.0 &

11. Open Webservices in your browser

HDM:
    http://puppet.pe.psick.io:3000

Puppet Master:
    https://puppet.pe.psick.io

Login: admin/puppetlabs


## Production Setup

Run the steps from [Development Setup](#development-setup) steps 1 to 9, only how we run HDM will be different

### Passenger

#### Debian

Install passenger as described in https://www.phusionpassenger.com/library/install/nginx/install/oss/stretch/

#### CentOS

Install passenger as described in https://www.phusionpassenger.com/library/install/nginx/install/oss/el7/

### Nginx

Configure Nginx, you can use the [example](docs/nginx_example.conf) as base config.

### Assets

Rails in production does not compile assets dynamically, needs to precompile all the assets with `rails assets:precompile`

# Copyright

example42 GmbH - 2019 - 2020

