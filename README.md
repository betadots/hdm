# Hiera Data Manager

Hiera Data Manager, aka HDM, is a webfrontend for vizualising and managing Hiera data.

The data is able to be viewed and modified by a person:
* without knowledge on Git
* without knowledge on Puppet
* simply with a web browser

## Prerequisites:

1. you must have a hiera.yaml file in each Puppet environment
1. you must set defaults like data_hash in hiera.yaml file
1. you must have a single hierarchy entry and use paths parameter
1. you must access PuppetDB via https
1. Hiera Data must be in directory data within puppet environment

## Development Setup

1. Clone repo:

```
    cd
    git clone git@gitlab.com:example42/hdm.git
    cd hdm/
```

2. add required packages

```
    yum install -y gcc-c++ sqlite-devel zlib-devel
```


3. sqlite database
  it's just a file, no need to configure any service

4. install gems

```
    /opt/puppetlabs/puppet/bin/gem install bundler
    /opt/puppetlabs/puppet/bin/bundle install --path vendor
```

5. install nodejs and yarn

```
    curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash
    sudo yum install -y nodejs
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
    sudo yum install -y yarn
```


6. yarn updates

```
    /opt/puppetlabs/puppet/bin/bundle exec yarn install --check-files
```

7. generate db content

```
    mkdir puppet
    /opt/puppetlabs/puppet/bin/bundle exec rails db:migrate
```

8. run hdm:

```
    export HDM__CONFIG_DIR="/etc/puppetlabs/code"

    export HDM__PUPPET_DB__ENABLED=true
    # If you are using a self signed certificate, you need to set:
    export HDM__PUPPET_DB__SELF_SIGNED_CERT=true
    export HDM__PUPPET_DB__SERVER="https://localhost:8081"

    export WEBPACKER_DEV_SERVER_HOST=0.0.0.0
    export RAILS_ENV=development
    /opt/puppetlabs/puppet/bin/bundle exec ./bin/webpack-dev-server &
    /opt/puppetlabs/puppet/bin/bundle exec rails s -b 0.0.0.0 &
```

When using Puppet Enterprise you must create a token:

```
    puppet-access login -l 2y
```

and add the following environment variable:

```
    export HDM__PUPPET_DB__TOKEN=$(cat ~/.puppetlabs/token)
```


9. access via ip and port 3000

consider opening port 3000 or disable the firewall.


## Production Setup

Run the steps from 1 to 7, only how we run HDM will be different

### Passenger

#### Debian

Install passenger as described in https://www.phusionpassenger.com/library/install/nginx/install/oss/stretch/

#### CentOS

Install passenger as described in https://www.phusionpassenger.com/library/install/nginx/install/oss/el7/

### Nginx

Configure Nginx, you can use the [example](docs/nginx_example.conf) as base config.

### Assets

Rails in production does not compile assets dynamically, needs to precompile all the assets with `rails assets:precompile`

