# The project

This Rails application displays a [Puppet](https://github.com/puppetlabs/puppet) configuration and offers a WebGUI to update/create that configuration.

In the first step we use the example development puppet configuration in `test/fixtures/files/puppet`. After that we impliment an API call to the puppet server.

## Usermanagement

A fresh installation needs an admin which has to be created first with the WebGUI. That admin can not read the Puppet configuration. He/She can only create/delete new users. Normal users have the ability to read/change/delete the Puppet configuration.

## Development

Please make sure that you have installed the right Ruby version (2.5.8) before you start your work. https://rvm.io is a good tool to do that.

In case you are using an Apple M1 Chip you might run into trouble building 
Ruby. A work around for that is using the command `rvm install 2.5.8 --with-cflags="-Wno-error=implicit-function-declaration"`

- Clone the repository and `cd` into the directory.
- Do a `bundle install --path vendor`.
- Install nodejs:
  - `brew install node` (https://brew.sh) or
  - `port install nmp6`
- We need `yarn`, install it: `npm install yarn`
- Install the needed packages: `yarn install --check-files`
- Create the database with `bundle exec rails db:create`
- Run the migrations with `bundle exec rails db:migrate`
- Seed the roles with `bundle exec rails db:seed`
- Start the webserver with `bundle exec rails server`
- Use your browser to open http://localhost:3000

You can reset your database anytime with a `rails db:reset`.

The example development puppet configuration can be found in the directory
`test/fixtures/files/puppet`
