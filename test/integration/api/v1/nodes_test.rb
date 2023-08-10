require "test_helper"

module Api
  module V1
    class NodesTest < ActionDispatch::IntegrationTest
      openapi! if respond_to?(:openapi!)

      test "GET /index returns a list of available nodes" do
        get "/api/v1/nodes", headers: basic_auth_header, as: :json
        assert_response :success
      end
    end
  end
end
