require "test_helper"

module Api
  module V1
    class KeysTest < ActionDispatch::IntegrationTest
      openapi! if respond_to?(:openapi!)

      test "GET /index returns a list of applicable keys" do
        get "/api/v1/environments/development/nodes/test.host/keys", headers: basic_auth_header, as: :json
        assert_response :success
      end

      test "GET /show returns per-hierarchy and per-file values" do
        get "/api/v1/environments/development/nodes/test.host/keys/foobar::enable_firstrun", headers: basic_auth_header, as: :json
        assert_response :success
      end
    end
  end
end
