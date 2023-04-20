require "test_helper"

module Api
  module V1
    class EnvironmentsTest < ActionDispatch::IntegrationTest
      openapi! if respond_to?(:openapi!)

      test "GET /index returns a list of available environments" do
        get "/api/v1/environments", headers: basic_auth_header, as: :json
        assert_response :success
      end
    end
  end
end
