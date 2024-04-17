class HieraData
  module Layer
    class Base
      delegate :hierarchies, to: :config

      def present?
        File.exist?(hiera_yaml)
      end

      def all_keys(facts:)
        hierarchies.flat_map { |h| h.all_keys(facts:) }.sort.uniq
      end

      def file_contents(facts:, decrypt: false)
        hierarchies.flat_map { |h| h.file_contents(facts:, decrypt:) }
      end

      def to_param
        name
      end

      private

      def config
        @config ||= Config.new(hiera_yaml)
      end

      def hiera_yaml
        filename = Rails.configuration.hdm.hiera_config_file || "hiera.yaml"
        base_path&.join(filename) || ""
      end
    end
  end
end
