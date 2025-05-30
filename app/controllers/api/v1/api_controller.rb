module Api
  module V1
    class ApiController < ApplicationController
      attr_reader :current_user

      rescue_from Hdm::Error, with: :return_error_json
      rescue_from CanCan::AccessDenied, with: :access_denied

      before_action :authentication_required

      helper_method :current_user

      private

      def authentication_required
        @current_user =
          if Rails.configuration.hdm.authentication_disabled
            DummyUser.new
          else
            authenticate_with_http_basic do |username, password|
              u = User.api.find_by(username: username.downcase)
              u&.authenticate(password)
            end
          end
        access_denied unless @current_user
      end

      def load_environments
        @environments = Environment.all
        @environments.select! { |e| current_user.may_access?(e) }
        @environment = Environment.find(params[:environment_id])
        authorize! :show, @environment
      end

      def return_error_json(error)
        @error = error
        render json: error.message, status: :internal_server_error
      end

      def access_denied
        render json: "forbidden", status: :forbidden
      end
    end
  end
end
