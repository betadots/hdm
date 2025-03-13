class HieraData
  module Layer
    class Environment < Base
      def initialize(environment:)
        super()
        @environment = HieraData::Environment.new(name: environment)
      end

      # rubocop:disable Rails/Delegate
      def base_path = @environment.base_path
      # rubocop:enable Rails/Delegate

      def name = "environment"

      def description = @environment.name
    end
  end
end
