# MacOS

## **RVM**

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

## **yarn/nodejs**

    brew install node@14
    npm install -g yarn

## **Main part**

    git clone https://github.com/betadots/hdm.git
    cd hdm
    bundle config set --local path 'vendor/bundle'
    bundle config set --local with 'development'
    bundle install
    yarn install --check-files

## **Configure hdm**

    cp config/hdm.yml.template config/hdm.yml
    # vim config/hdm.yml # adopt config
    bundle exec rails db:setup
    echo "secret" | EDITOR="vim" bundle exec rails credentials:edit
    bundle exec rails server &

For development there is per default a fake_puppet_db configured.
It can be startet on a second shell:

    ./bin/fake_puppet_db &

## **General things**
- HDM binds per default to port `3000`. fake_puppet_db binds to `8083`.
- In case of layout errors you can run `bundle exec rails tmp:clear`.
- To reset your database run at anytime `bundle exec rails db:reset`.
- The example development puppet configuration can be found in the directory
`test/fixtures/files/puppet`.

# Integration environment (TBD)

#TODO: Setup a environment with VMs to have a real puppetserver and puppetdb for testing.
