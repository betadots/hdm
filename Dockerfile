FROM ruby:2.5.8-buster
COPY . /hdm
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y npm nodejs yarn
WORKDIR /hdm
RUN rm Gemfile.lock
RUN bundle install --path vendor
RUN yarn install --check-files
RUN bundle exec rails db:create
RUN bundle exec rails db:migrate
RUN bundle exec rails db:seed

EXPOSE 3000
CMD 'cd /hdm; bundle exec rails server'
