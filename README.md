# HDM - Hiera Data Manager

Copyright 2021 example42 GmbH

This Rails application displays [Puppet](https://github.com/puppetlabs/puppet) Hiera data and offers a WebGUI to read/update/create that configuration.

You can find screenshots in the [screenshots](screenshots) directory.

## Usermanagement

A fresh installation needs an admin which has to be created first with the WebGUI. That admin can not read the Puppet configuration. He/She can only create/delete new users. Normal users have the ability to read/change/delete the Puppet configuration.

## Setup

At the moment setup is ony tested on Mac OS and CentOS 7.

### Mac OS

Please make sure that you have installed the right Ruby version (2.5.8) before you start your work. https://rvm.io is a good tool to do that.

In case you are using an Apple M1 Chip you might run into trouble building
Ruby. A work around for that is using the command `rvm install 2.5.8 --with-cflags="-Wno-error=implicit-function-declaration"`

- Clone the repository and `cd` into the directory.
- Do `bundle config set --local path 'vendor/bundle'`
- Do `bundle config set --local with 'development'`
- Do `bundle install`.
- Install nodejs
  - `brew install node@14` (https://brew.sh)
  - or `sudo port install nmp6 yarn`
  - node 15 does not work yet
- We need `yarn`, install it: `npm install -g yarn`

- Install the needed packages: `yarn install --check-files`

### CentOS 7

Install Puppet Agent package from Puppetlabs.

This will provide us with an up to date Ruby version.

- Install required packages:

```
yum install -y https://kojipkgs.fedoraproject.org//packages/sqlite/3.8.11/1.fc21/x86_64/sqlite-devel-3.8.11-1.fc21.x86_64.rpm
yum install -y https://kojipkgs.fedoraproject.org//packages/sqlite/3.8.11/1.fc21/x86_64/sqlite-3.8.11-1.fc21.x86_64.rpm
yum install -y gcc-c++ zlib-devel
```

- Install Ruby Gems

```
/opt/puppetlabs/puppet/bin/gem install bundler
/opt/puppetlabs/puppet/bin/bundle install --path vendor
```

- Install NodeJS

```
curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash
sudo yum install -y nodejs
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install -y yarn
yarn install --check-files
```

### General HDM Setup

- Create a configuration file using the template: `cp config/hdm.yml.template config/hdm.yml`
- Create the database with `bundle exec rails db:setup`
- Generate a new encrypted credentials file: `echo "test" |EDITOR=vim bundle exec rails credentials:edit` (Note: You may need to adopt this. Never forget to set  the `EDITOR` env variable)
- Start the webserver with `bundle exec rails server &`
- STart the fake puppetdb process (if configured in hdm.yml) `./bin/fake_puppet_db &`
- Use your browser to open http://localhost:3000

- In case of layout errors: `bundle exec rails tmp:clear`

You can reset your database anytime with a `rails db:reset`.

The example development puppet configuration can be found in the directory
`test/fixtures/files/puppet`

## Docker

### Build

There is a Dockerfile to build a container. This can be done with:

    cd hdm
    docker build -t hdm .

### Docker Compose

For docker-compose see `docker-compose.yaml` or use this example:

    ---
    version: '3.5'
    services:
      hdm:
        image: example42/hdm:latest
        container_name: hdm
        volumes:
          # keep db outside of container
          - /srv/data/hdm/db:/hdm/data/db
        ports:
          - 3000:3000
        restart: unless-stopped

## Use git repositories instead of "live" yaml files

HDM can edit live hiera yaml files directly in the file system. While this might
be fine for smaller installations, it might not be desireable in many others.

In those cases you should make sure that the user HDM runs as has no write
access to the files. If you still want to be able to make changes, you should
consider making them in a git repository instead. This will afford you a full
history of edits and the possibility to roll back changes if necessary.

HDM supports this by allowing you to substitute directories from the file system
hosting the live hiera files with directories from a git repository.

Say your live data lives in `/etc/puppetlabs/code/myenv/data`. To replace this
with data from the git repository at `githost.example.com:puppet/hiera_data.git`
where the corresponding directory is called `environments/myenv/data` add the
following to `config/hdm.yml`:

```yaml
production:
  # ... existing production config ...
  git_data:
    - datadir: /etc/puppetlabs/code/myenv/data
      git_url: git@githost.example.com:puppet/hiera_data.git
      path_in_repo: environments/myenv/data
```

You can substitute as many directories with ones from git repositories as you
like.

Please note that the user HDM runs as needs to be able to clone the repository.
Cloned repos are stored in HDM's `repos` directory. Repositories are cloned
the first time they are needed. This might take a long time, so HDM also
provides a task to prefetch all needed repositories:

```sh
bundle exec rails hdm:clone_repos
```

Any changes made to files from a git repository will be commited and pushed back
to the origin repository. Please note that HDM will not pull updates from the
origin repository and is **not** able to resolve possible conflicts, so you might
want to make sure that your repository is only edited by HDM.

