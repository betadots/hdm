export HDM__CONFIG_DIR="/etc/puppetlabs/code/environments"
export HDM__PUPPET_DB__ENABLED=true
export HDM__PUPPET_DB__SELF_SIGNED_CERT=true
export HDM__PUPPET_DB__TOKEN=$(cat ~/.puppetlabs/token)
export HDM__PUPPET_DB__SERVER="https://localhost:8081"
export WEBPACKER_DEV_SERVER_HOST=0.0.0.0
export RAILS_ENV=development
/opt/puppetlabs/puppet/bin/bundle exec ./bin/webpack-dev-server &
/opt/puppetlabs/puppet/bin/bundle exec rails s -b 0.0.0.0 &
