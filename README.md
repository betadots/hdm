# HDM - Hiera Data Manager

Copyright 2022 betadots GmbH
Copyright 2021 example42 GmbH

This Rails application displays [Puppet](https://github.com/puppetlabs/puppet) Hiera data and offers a WebGUI to read/update/create that configuration.

You can find screenshots in the [screenshots](screenshots) directory.

## Usermanagement

A fresh installation needs an admin which has to be created first with the WebGUI. That admin can not read the Puppet configuration. He/She can only create/delete new users. Normal users have the ability to read/change/delete the Puppet configuration.

## Manual installation

At the moment manual install is only tested on macOS, CentOS 7 and 8 Streams. But we highly recommend to use the Docker image!

See [MANUAL_INSTALL.md](MANUAL_INSTALL.md)

## Docker

See [DOCKER.md](DOCKER.md)

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
