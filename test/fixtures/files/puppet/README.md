Development Data

1. mock selection of "puppet environment" and set it static to "production"
1. mock selection of nodes and their facts:
    - hostname: by reading filenames (without .yaml ending) from nodes directory
    - host facts: by reading the selected node file

hiera config file options to use:

1. no hiera yaml file (taking defaults from puppet hiera)
1. minimal hiera: use hiera\_minimal.yaml
1. complex: use hiera.yaml
1. wrong config version: use hiera\_v3.yaml (this should produce an error as we only support config:5 hiera.yaml files)

Attn: the "environment" directory is old data. We keep it to expand the test data in a later stage.

