ENV['RAILS_ENV'] ||= 'test'

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start "rails"
end

require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/mock'
require_relative "support/fake_puppet_db"
require_relative "support/openapi"
require_relative "support/sign_in_helper"

# Start FakePuppetDB-Server
server_thread = Thread.new do
  Rackup::Server.start(app: FakePuppetDB.new, Host: "localhost", Port: 8085)
end
server_thread.join(1)

SAML_TEST_CONFIG = {
  sp_entity_id: "hdm-test",
  idp_sso_service_url: "https://testsso",
  idp_cert_fingerprint: "test"
}.freeze

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors) unless ENV["COVERAGE"] || ENV["OPENAPI"]

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def with_temp_file(path, &)
      FileUtils.rm_f(path)
      yield
    ensure
      FileUtils.rm_f(path)
    end

    def json
      JSON.parse(response.body)
    end
  end
end

module ActionDispatch
  class IntegrationTest
    include SignInHelper
  end
end
