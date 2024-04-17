class HieraData
  module Layer
    class Environment < Base
      def initialize(environment:)
        super()
        @environment = HieraData::Environment.new(name: environment)
      end

      def base_path = @environment.base_path

      def name = "environment"

      def description = @environment.name
    end
  end
end
