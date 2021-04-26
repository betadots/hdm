Development and Test Data

This data structure is used by the fake\_puppetdb service.

1. Environments

Puppet environments are located in test/fixtures/files/puppet/environments

Within an environment a hiery.yaml file may exist.
Data are within the configured datadir.

2. Nodes

Nodes are read from test/fixtures/files/puppet/nodes directory.
For each node a yaml file exists. The file name is the node name.
Within the yaml file, the required facts are set.

