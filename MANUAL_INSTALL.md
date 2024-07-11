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

On Alma 8 you must install libyaml-devel:

    dnf install -y libyaml-devel

Now you can install the required ruby version:

    rvm install 3.3.4
    rvm use 3.3.4

### **Main part**

    yum install -y git vim
    cd /opt
    git clone https://github.com/betadots/hdm.git
    cd /opt/hdm
    bundle config set --local path 'vendor/bundle'
    bundle config set --local with 'development'
    bundle install

### **Configure hdm**

    cp /opt/hdm/config/hdm.yml.template /opt/hdm/config/hdm.yml
    # vim /opt/hdm/config/hdm.yml # adopt config
    bundle exec rails db:setup
    echo "secret" | EDITOR="vim" bundle exec rails credentials:edit
    export RAILS_DEVELOPMENT_HOSTS=$(hostname -f)
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
