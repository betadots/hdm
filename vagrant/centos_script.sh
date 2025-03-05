#!/bin/bash

echo "DNF: Clean metadata"
sudo dnf clean all

echo "Installing Repo Packages"
echo "foreman"
sudo dnf -y localinstall https://yum.theforeman.org/releases/3.13/el9/x86_64/foreman-release.rpm
echo "Puppet 7"
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
  --foreman-initial-admin-password='betadots_foreman_2024'

echo "Installing r10k"
sudo /opt/puppetlabs/puppet/bin/gem install r10k --no-document
echo "Installing puppet modules"
sudo mkdir -p /etc/puppetlabs/code/environments/production
sudo cp /vagrant/Puppetfile /etc/puppetlabs/code/environments/production/
pushd /etc/puppetlabs/code/environments/production
sudo /opt/puppetlabs/puppet/bin/r10k puppetfile install -v
popd

echo "Preparing Puppet Environment"
sudo mkdir -p /etc/puppetlabs/code/environments/production/data/nodes
sudo mkdir -p /etc/puppetlabs/code/environments/production/manifests
sudo cp /vagrant/hdm/site.pp /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo cp /vagrant/hdm/centos_data.yaml /etc/puppetlabs/code/environments/production/data/nodes/puppet.hdm.betadots.training.yaml
sudo cp /vagrant/hdm/common_data.yaml /etc/puppetlabs/code/environments/production/data/common.yaml

echo "preparing hdm for git"
sudo mkdir -p /etc/hdm
sudo git config --global --add safe.directory /etc/hdm

echo "Running Puppet"
sudo /opt/puppetlabs/puppet/bin/puppet agent -t
sudo /opt/puppetlabs/puppet/bin/puppet config set --section main reports foreman,puppetdb
sudo systemctl restart puppetserver

echo "Installing Foreman HDM"
sudo foreman-installer --enable-foreman-plugin-hdm --enable-foreman-proxy-plugin-hdm --foreman-proxy-plugin-hdm-hdm-url http://puppet.workshop.betadots.training:3000

echo "Uploading facts to PuppetDB"
sudo /opt/puppetlabs/bin/puppet agent -t

echo "Jetzt einloggen, root user werden"
echo "vagrant ssh puppet.betadots.training"
echo "sudo -i"
echo "### HDM:"
echo "Im Browser: https://puppet.hdm.betadots.training"
echo "Login: admin, Passwort: betadots_foreman_2024"
echo " -> Infrastructure -> Smart Proxies -> Refresh"
echo " -> Hosts -> All Hosts -> puppet.hdm.betadots.training -> Edit -> HDM Smart Proxy hinzufügen."
