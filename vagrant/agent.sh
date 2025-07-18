#!/bin/bash

echo "DNF: Clean metadata"
sudo dnf clean all

echo "Installing Repo Packages"
echo "Puppet 8"
sudo dnf -y localinstall https://yum.puppet.com/puppet8-release-el-9.noarch.rpm

echo "DNF update"
sudo dnf -y update

echo "installing some tools: tree vim net-tools"
sudo dnf -y install tree vim net-tools puppet-agent

echo "Fix /etc/hosts"
sudo sed -i -e "/127.0.1.1 p/d" /etc/hosts
cat '10.100.10.101 openvox.hdm.workshop.betadots.training' | sudo tee -a /etc/hosts

echo "Preparing custom facts"
sudo mkdir -p /etc/puppetlabs/facter/facts.d
sudo cp /vagrant/hdm/agent_facts.yaml /etc/puppetlabs/facter/facts.d/custom_facts.yaml
echo "Running Puppet"
sudo /opt/pupeptlabs/puppet/bin/puppet config set --section agent server openvox.hdm.workshop.betadots.training
sudo /opt/puppetlabs/puppet/bin/puppet agent -t

