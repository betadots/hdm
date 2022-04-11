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

The token will be saved in `/root/.puppetlabs/token`

If this produces an error like `Unhandled exception: locale::facet::_S_create_c_locale name not valid` you want to check your locale settings by running locale.
When logging in from a macOS System you have to unset the LC\_CTYPE local: `unset LC_CTYPE`

Setting a localw can be done by running

    export LANG=en_US.UTF-8

## Mock certificate information

Create a new external fact file:

    mkdir -p /etc/puppetlabs/facter/facts.d
    echo -e "role=puppet\nzone=pe\nenv=devel\ndatacenter=vagrant\n" > /etc/puppetlabs/facter/facts.d/hdm.txt

Now run puppet agent to add new facts to puppetdb: `puppet agent --test`

## HDM

See [MANUAL_INSTALL.md](MANUAL_INSTALL.md)

Login:

Puppet Enterprise: `https://puppet.pe.psick.io`

Login: admin
Password: puppetlabs

HDM: `http://puppet.pe.psick.io:3000`

If this does not work you can use localhost: `http://localhost:3000`
