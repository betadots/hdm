class HieraData
  module Layer
    class Module < Base
      def initialize(environment:, key:)
        super()
        @environment = HieraData::Environment.new(name: environment)
        @namespace = key&.match(/^(.+?)::/)&.captures&.first
      end

      def name = "module"

      def description = @namespace

      def base_path
        @environment.module_path(module_name: @namespace)
      end

      def present?
        @namespace && super
      end

      def all_keys(facts:)
        super.select { |k| key_matches_module?(k) }
      end

      def file_contents(facts:, decrypt: false)
        super.map do |hash|
          hash.select { |k, _v| key_matches_module?(k) }
        end
      end

      private

      def key_matches_module?(key)
        key.match(/^#{@namespace}::/)
      end
    end
  end
end
