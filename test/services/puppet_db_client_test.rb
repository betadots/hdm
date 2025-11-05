require 'test_helper'

class PuppetDbClientTest < ActiveSupport::TestCase
  test "::client can be called with `pem` configuration" do
    old_config = Rails.configuration.hdm.puppet_db
    Rails.configuration.hdm.puppet_db = {
      server: "https://localhost",
      pem: {
        cert: "tmp/test.certomat",
        key: "tmp/test.key",
        ca_file: "tmp/test.ca"
      }
    }

    client = PuppetDbClient.client
    assert_kind_of PuppetDB::Client, client

    Rails.configuration.hdm.puppet_db = old_config
    # Some of the options passed above get promoted to class level default options, so we need to reset them here
    PuppetDB::Client.default_options = {}
  end
end
