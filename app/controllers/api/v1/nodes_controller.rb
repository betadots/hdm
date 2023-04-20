module Api
  module V1
    class NodesController < Api::V1::ApiController
      def index
        @nodes = Node.all
        @nodes.select! { |n| current_user.may_access?(n) }

        respond_to do |format|
          format.json do
            render json: @nodes
          end
        end
      end
    end
  end
end
