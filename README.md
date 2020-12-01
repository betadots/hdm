# Development

Please make sure that you have installed the right Ruby version (2.5.8) before you start your work. https://rvm.io is a good tool to do that.

- Clone the repository and `cd` into the directory.
- Do a `bundle install`.
- Create the database with `rails db:create`
- Run the migrations with `rails db:migrate`
- Seed the roles with `rails db:seed`
- Start the webserver with `rails server`
- Use your browser to open http://localhost:3000

You can reset your database anytime with a `rails db:reset`.

The example development puppet configuration can be found in the directory
`test/fixtures/files/puppet`
