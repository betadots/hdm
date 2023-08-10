module Api
  module V1
    class EnvironmentsController < Api::V1::ApiController
      def index
        @environments = Environment.all
        @environments.select! { |e| current_user.may_access?(e) }

        respond_to do |format|
          format.json do
            render json: @environments
          end
        end
      end
    end
  end
end
