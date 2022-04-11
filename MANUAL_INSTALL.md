# Manual install

## General

HDM binds per default to port 3000.

## Ruby

Make sure you have the necessary ruby version on your system avaiable. You might use rvm or rbenv.
The needed version cann be found here: [.ruby-version](.ruby-version).

## CentOS 8 Streams

### **RVM**

As root do:

    command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
    command curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
    curl -sSL https://get.rvm.io | bash -s stable

    source /etc/profile.d/rvm.sh

    rvm install 2.5.9
    rvm use 2.5.9
    gem install bundler

### **yarn/nodejs**

    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
    curl --silent --location https://rpm.nodesource.com/setup_14.x | bash
    yum install -y yarn

### **Main part**

    yum install -y git vim
    cd /opt
    git clone https://github.com/betadots/hdm.git
    cd /opt/hdm
    bundle config set --local path 'vendor/bundle'
    bundle config set --local with 'development'
    bundle install
    yarn install --check-files

### **Configure hdm**

    cp /opt/hdm/config/hdm.yml.template /opt/hdm/config/hdm.yml
    # vim /opt/hdm/config/hdm.yml # adopt config
    bundle exec rails db:setup
    echo "secret" | EDITOR="vim" bundle exec rails credentials:edit
    bundle exec rails server -b 0.0.0.0 & # or use systemd unit from `config` folder.

### **systemd**

    cp /opt/hdm/config/hdm.service /etc/systemd/system/hdm.service
    systemctl daemon-reload
    systemctl start hdm.service
    systemctl status hdm.service

## CentOS 7

You will need sqlite >= 3.8.x

    yum install -y https://kojipkgs.fedoraproject.org//packages/sqlite/3.8.11/1.fc21/x86_64/sqlite-3.8.11-1.fc21.x86_64.rpm
    yum install -y https://kojipkgs.fedoraproject.org//packages/sqlite/3.8.11/1.fc21/x86_64/sqlite-devel-3.8.11-1.fc21.x86_64.rpm

After doing this, follow the CentOS 8 Streams instructions.

## MacOS (for development)

### **RVM**

    gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable

    # reload shell

In case you are using an Apple M1 Chip you might run into trouble building
Ruby. A work around for that is using the command

    rvm install 2.5.9 --with-cflags="-Wno-error=implicit-function-declaration"

On intel you can proceed with the following:

    rvm install 2.5.9
    rvm use 2.5.9
    gem install bundler

### **yarn/nodejs**

    brew install node@14
    npm install -g yarn

### **Main part**

    git clone https://github.com/betadots/hdm.git
    cd hdm
    bundle config set --local path 'vendor/bundle'
    bundle config set --local with 'development'
    bundle install
    yarn install --check-files

### **Configure hdm**

    cp config/hdm.yml.template config/hdm.yml
    # vim config/hdm.yml # adopt config
    bundle exec rails db:setup
    echo "secret" | EDITOR="vim" bundle exec rails credentials:edit
    bundle exec rails server &

For development there is per default a fake_puppet_db configured.
It can be startet on a second shell:

    ./bin/fake_puppet_db &

In case of layout errors you can run `bundle exec rails tmp:clear`.
To reset your database run at anytime `rails db:reset`.
The example development puppet configuration can be found in the directory
`test/fixtures/files/puppet`.
