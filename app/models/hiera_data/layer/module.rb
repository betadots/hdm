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
          contents = hash.select { |k, _v| key_matches_module?(k) }
          module_lookup_options = scoped_lookup_options(hash["lookup_options"])
          contents["lookup_options"] = module_lookup_options if module_lookup_options.present?
          contents
        end
      end

      private

      def key_matches_module?(key)
        key.match(/^#{@namespace}::/)
      end

      # A module may only declare lookup_options for keys within its own
      # namespace (Puppet 8 / Hiera 5 behavior). Any entry targeting a key
      # outside `<namespace>::` is ignored.
      def scoped_lookup_options(lookup_options)
        return unless lookup_options.is_a?(Hash)

        lookup_options.select { |key, _options| lookup_options_key_matches_module?(key) }
      end

      def lookup_options_key_matches_module?(key)
        if key.to_s.start_with?("^")
          # Regexp entry: only keep it when it is strictly scoped to the module
          # namespace to avoid a module influencing foreign keys.
          key.to_s.start_with?("^#{@namespace}::")
        else
          key_matches_module?(key.to_s)
        end
      end
    end
  end
end
