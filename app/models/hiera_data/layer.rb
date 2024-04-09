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

      private

      def config
        @config ||= Config.new(hiera_yaml)
      end

      def find_hierarchy(hierarchy_name:)
        config.hierarchies.find { |h| h.name == hierarchy_name }
      end

      def hiera_yaml
        filename = Rails.configuration.hdm.hiera_config_file || "hiera.yaml"
        base_path.join(filename)
      end
    end

    class Global < Base
      def base_path
        Pathname.new("/etc/puppetlabs/puppet")
      end

      def name
        "global"
      end

      def to_param
        name
      end
    end

    class Environment < Base
      def initialize(environment:)
        super()
        @environment = environment
      end

      def base_path
        Pathname.new(Rails.configuration.hdm.config_dir)
                .join("environments", @environment)
      end

      def name
        "environment"
      end

      def to_param
        name
      end
    end

    class Module < Base
      # TODO
    end

    def self.for(environment:)
      [Global.new, Environment.new(environment:)].select(&:present?)
    end
  end
end
