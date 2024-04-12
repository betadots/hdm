module Api
  module V1
    class KeysController < Api::V1::ApiController
      before_action :load_environment_and_node

      def index
        @keys = Key.all_for(@node, environment: @environment)
        @keys.select! { |k| current_user.may_access?(k) }

        respond_to do |format|
          format.json do
            render json: @keys.to_json
          end
        end
      end

      def show
        @key = Key.new(name: params[:id])
        authorize! :show, @key

        respond_to do |format|
          format.json do
            render json: values_per_hierarchy_and_file
          end
        end
      end

      private

      def values_per_hierarchy_and_file
        @environment.environment_layer.hierarchies.map do |hierarchy|
          files = hierarchy.files_for(node: @node).map do |file|
            { path: file.path, value: file.value_for(key: @key).value }
          end
          { hierarchy_name: hierarchy.name, files: }
        end
      end

      def load_environment_and_node
        @node = Node.find(params[:node_id])
        authorize! :show, @node
        @environment = if params[:environment_id].present?
                         Environment.find(params[:environment_id])
                       else
                         @node.environment
                       end
        authorize! :show, @environment
      end
    end
  end
end
