# Development

Please make sure that you have installed the right Ruby version (2.5.8) before you start your work. https://rvm.io is a good tool to do that.

In case you are using an Apple M1 Chip you might run into trouble building 
Ruby. A work around for that is using the command `rvm install 2.5.8 --with-cflags="-Wno-error=implicit-function-declaration"`

- Clone the repository and `cd` into the directory.
- Do a `bundle install`.
- Install nodejs `brew install node` (https://brew.sh)
- We need `yarn`, install it: `npm install -g yarn`
- Install the needed packages: `yarn install --check-files`
- Create the database with `rails db:create`
- Run the migrations with `rails db:migrate`
- Seed the roles with `rails db:seed`
- Start the webserver with `rails server`
- Use your browser to open http://localhost:3000

You can reset your database anytime with a `rails db:reset`.

The example development puppet configuration can be found in the directory
`test/fixtures/files/puppet`
