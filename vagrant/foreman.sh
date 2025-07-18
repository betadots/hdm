#!/bin/bash

echo "DNF: Clean metadata"
sudo dnf clean all

echo "Installing Repo Packages"
echo "foreman"
sudo dnf -y localinstall https://yum.theforeman.org/releases/3.13/el9/x86_64/foreman-release.rpm
echo "Puppet 8"
sudo dnf -y localinstall https://yum.puppet.com/puppet8-release-el-9.noarch.rpm

echo "DNF update"
sudo dnf -y update

echo "installing some tools: tree vim net-tools"
sudo dnf -y install tree vim net-tools git

echo "Katello installation part"
sudo dnf -y install foreman-installer

echo "Fix /etc/hosts"
sudo sed -i -e "/127.0.1.1 p/d" /etc/hosts

echo "Foreman Installation"
sudo foreman-installer \
  --scenario foreman \
  --enable-foreman-plugin-remote-execution \
  --enable-foreman-proxy-plugin-remote-execution-script \
  --enable-foreman-cli-remote-execution \
  --enable-foreman-cli-tasks \
  --enable-foreman-plugin-tasks \
  --enable-foreman-plugin-puppetdb \
  --foreman-initial-admin-password='betadots_foreman_2025'

echo "Installing r10k"
sudo /opt/puppetlabs/puppet/bin/gem install r10k --no-document

echo "preparing hdm for git"
sudo mkdir -p /etc/hdm
sudo git config --global --add safe.directory /etc/hdm

=======
echo "Preparing Puppet Environment"
sudo mkdir -p /etc/puppetlabs/code/environments/
sudo cp -R /vagrant/hdm/production /etc/puppetlabs/code/environments/production
sudo cp -R /vagrant/hdm/feat_23498 /etc/puppetlabs/code/environments/feat_23498
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

echo "Running Puppet"
sudo /opt/pupeptlabs/puppet/bin/puppet config set --section agent server openvox.hdm.workshop.betadots.training
sudo /opt/puppetlabs/puppet/bin/puppet agent -t
sudo /opt/puppetlabs/puppet/bin/puppet config set --section main reports foreman,puppetdb
sudo systemctl restart puppetserver

echo "Installing Foreman HDM"
sudo foreman-installer --enable-foreman-plugin-hdm --enable-foreman-proxy-plugin-hdm --foreman-proxy-plugin-hdm-hdm-url http://openvox.hdm.workshop.betadots.training:3000

echo "Uploading facts to PuppetDB"
sudo /opt/puppetlabs/bin/puppet agent -t

echo "Jetzt einloggen, root user werden"
echo "vagrant ssh openvox.hdm.workshop.betadots.training"
echo "sudo -i"
echo "### HDM:"
echo "Im Browser: https://openvox.hdm.workshop.betadots.training"
echo "Login: admin, Passwort: betadots_foreman_2025"
echo " -> Infrastructure -> Smart Proxies -> Refresh"
echo " -> Hosts -> All Hosts -> openvox.hdm.workshop.betadots.training -> Edit -> HDM Smart Proxy hinzufügen."
echo "Schritt wiederholen für apache host"
