#!/bin/bash

echo "DNF: Clean metadata"
sudo dnf clean all

echo "Installing Repo Packages"
echo "foreman"
sudo dnf -y localinstall https://yum.theforeman.org/releases/3.15/el9/x86_64/foreman-release.rpm
echo "OpenVox 8"
sudo dnf -y localinstall https://yum.voxpupuli.org/openvox8-release-el-9.noarch.rpm

echo "DNF update"
sudo dnf -y update

echo "installing some tools: tree vim net-tools"
sudo dnf -y install tree vim net-tools git

echo "Katello installation part"
sudo dnf -y install foreman-installer

echo "Fix /etc/hosts"
sudo sed -i -e "/127.0.1.1 o/d" /etc/hosts

echo "Foreman Installation"
sudo foreman-installer \
  --scenario foreman \
  --enable-foreman-plugin-remote-execution \
  --enable-foreman-proxy-plugin-remote-execution-script \
  --enable-foreman-cli-remote-execution \
  --enable-foreman-cli-tasks \
  --enable-foreman-plugin-tasks \
  --enable-foreman-plugin-puppetdb \
  --foreman-initial-admin-password='betadots_foreman_2025' \
  --puppet-autosign-entries='*' \
  --puppet-client-package='openvox-agent' \
  --puppet-server-package='openvox-server'

echo "Installing r10k"
sudo /opt/puppetlabs/puppet/bin/gem install r10k --no-document

echo "preparing hdm for git"
sudo mkdir -p /etc/hdm
sudo git config --global --add safe.directory /etc/hdm

echo "Preparing Puppet Environment"
sudo mkdir -p /etc/puppetlabs/code/environments/
sudo rm -fr /etc/puppetlabs/code/environments/production
sudo cp -r /vagrant/hdm/production /etc/puppetlabs/code/environments/
sudo cp -r /vagrant/hdm/feat_23498 /etc/puppetlabs/code/environments/
sudo cp -r /vagrant/hdm/keys /etc/puppetlabs/puppet/
sudo chmod 0644 /etc/puppetlabs/puppet/keys/private_key.pkcs7.pem
sudo chown -R puppet:puppet /etc/puppetlabs/puppet/keys/
echo "Installing puppet modules"
pushd /etc/puppetlabs/code/environments/production
sudo /opt/puppetlabs/puppet/bin/r10k puppetfile install -v
popd

echo "Preparing custom facts"
sudo mkdir -p /etc/puppetlabs/facter/facts.d
sudo cp /vagrant/hdm/openvox_facts.yaml /etc/puppetlabs/facter/facts.d/custom_facts.yaml

echo "Fix for rvm.io certificate"
wget --no-check-certificate -O- https://rvm.io/mpapis.asc | sudo gpg --batch --import
wget --no-check-certificate -O- https://rvm.io/pkuczynski.asc | sudo gpg --batch --import

echo "Running Puppet"
sudo /opt/puppetlabs/puppet/bin/puppet config set --section agent server openvox.hdm.workshop.betadots.training
sudo /opt/puppetlabs/puppet/bin/puppet config set --section main reports foreman,puppetdb
sudo /opt/puppetlabs/puppet/bin/puppet config set --section server autosign true
sudo systemctl restart puppetserver
sudo /opt/puppetlabs/puppet/bin/puppet agent -t

echo "Installing Foreman HDM"
sudo foreman-installer --enable-foreman-plugin-hdm --enable-foreman-proxy-plugin-hdm --foreman-proxy-plugin-hdm-hdm-url http://openvox.hdm.workshop.betadots.training:3000

echo "Uploading facts to PuppetDB"
sudo /opt/puppetlabs/bin/puppet agent -t

if [[ -e /vagrant/puppet-bolt-4.0.0-1.el9.x86_64.rpm && -e /vagrant/rubygem-smart_proxy_openbolt-0.0.1-1.el9.noarch.rpm && -e /vagrant/rubygem-foreman_openbolt-0.0.1-1.el9.noarch.rpm ]]; then
  echo "Installing OpenVox Orchestrator"
  sudo rpm -ihv /vagrant/puppet-bolt-4.0.0-1.el9.x86_64.rpm /vagrant/rubygem-smart_proxy_openbolt-0.0.1-1.el9.noarch.rpm /vagrant/rubygem-foreman_openbolt-0.0.1-1.el9.noarch.rpm
  if [[ $(grep foreman-tasks /usr/share/gems/gems/foreman_openbolt-0.0.1/lib/foreman_openbolt.rb) ]]; then
    echo "Patch already applied"
  else
    sudo sed -n -i "p;3a require 'foreman-tasks'" /usr/share/gems/gems/foreman_openbolt-0.0.1/lib/foreman_openbolt.rb
  fi

  echo "Activating OpenVox Orchestrator"
  sudo systemctl restart foreman-proxy
  sudo foreman-rake db:migrate
  sudo foreman-rake db:seed
  sudo foreman-rake openbolt:refresh_proxies
  sudo systemctl restart foreman
else
  echo "No OpenVox Orchestrator Packages found. Skipping"
fi

echo "Jetzt einloggen, root user werden"
echo "vagrant ssh openvox.hdm.workshop.betadots.training"
echo "sudo -i"
echo "### HDM:"
echo "Im Browser: https://openvox.hdm.workshop.betadots.training"
echo "Login: admin, Passwort: betadots_foreman_2025"
echo " -> Infrastructure -> Smart Proxies -> Refresh"
echo " -> Hosts -> All Hosts -> openvox.hdm.workshop.betadots.training -> Edit -> HDM Smart Proxy hinzufügen."
echo "Schritt wiederholen für apache host"
