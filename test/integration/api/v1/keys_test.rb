require "test_helper"

module Api
  module V1
    class KeysTest < ActionDispatch::IntegrationTest
      openapi! if respond_to?(:openapi!)

      class NestedInEnvironmentTest < ActionDispatch::IntegrationTest
        openapi! if respond_to?(:openapi!)

        test "it returns a list of applicable keys from the given environment" do
          get "/api/v1/environments/development/nodes/test.host/keys", headers: basic_auth_header, as: :json
          assert_response :success
        end

        test "it returns per-hierarchy and per-file values from the given environment" do
          get "/api/v1/environments/development/nodes/test.host/keys/foobar::enable_firstrun", headers: basic_auth_header, as: :json
          assert_response :success
        end
      end

      class WithoutEnvironmentTest < ActionDispatch::IntegrationTest
        openapi! if respond_to?(:openapi!)

        test "it returns a list of applicable keys" do
          get "/api/v1/nodes/test.host/keys", headers: basic_auth_header, as: :json
          assert_response :success
        end

        test "it returns per-hierarchy and per-file values" do
          get "/api/v1/nodes/test.host/keys/foobar::enable_firstrun", headers: basic_auth_header, as: :json
          assert_response :success
        end
      end
    end
  end
end
