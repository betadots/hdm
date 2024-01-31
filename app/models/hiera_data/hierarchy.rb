class HieraData
  class Hierarchy
    LOOKUP_FUNCTIONS = %w[lookup_key data_hash data_dig hiera3_backend].freeze
    BACKENDS = {
      "data_hash" => {
        "json_data" => :json,
        "yaml_data" => :yaml
      },
      "lookup_key" => {
        "eyaml_lookup_key" => :eyaml
      }
    }.freeze

    attr_reader :raw_hash

    def initialize(raw_hash:, base_path:)
      @raw_hash = raw_hash
      @base_path = Pathname.new(base_path)
    end

    def name
      @name ||= raw_hash.fetch("name", "Unnamed")
    end

    def lookup_function
      @lookup_function ||= LOOKUP_FUNCTIONS.find { |f| raw_hash.keys.include?(f) } # rubocop:disable Performance/InefficientHashSearch
    end

    def backend
      @backend ||= determine_backend
    end

    def datadir(facts: nil)
      return @datadir if @datadir

      raw_datadir = raw_hash["datadir"]
      raw_datadir = Interpolation.interpolate_facts(path: raw_datadir, facts:) if facts
      path = Pathname.new(raw_datadir)
      if path.absolute?
        path
      else
        @base_path.join(path)
      end
    end

    def private_key
      return unless backend == :eyaml

      @base_path.join(raw_hash.dig("options", "pkcs7_private_key"))
    end

    def public_key
      return unless backend == :eyaml

      @base_path.join(raw_hash.dig("options", "pkcs7_public_key"))
    end

    def file_options
      {
        public_key:,
        private_key:
      }.compact
    end

    def encryptable?
      backend == :eyaml &&
        File.readable?(private_key) &&
        File.readable?(public_key)
    end

    def uses_globs?
      raw_hash.key?("glob") || raw_hash.key?("globs")
    end

    def paths
      @paths ||= setup_paths
    end

    def resolved_paths(facts:)
      paths.flat_map do |path|
        resolved_path = Interpolation.interpolate_facts(path:, facts:)
        if uses_globs?
          resolved_path = Interpolation
                          .interpolate_globs(path: resolved_path, datadir:)
        end
        resolved_path
      end
    end

    def candidate_files
      paths.flat_map do |path|
        globbed_path = Interpolation.replace_variables_with_globs(path)
        Interpolation.interpolate_globs(path: globbed_path, datadir:)
      end
    end

    private

    def setup_paths
      base_key = uses_globs? ? "glob" : "path"
      Array(raw_hash[base_key] || raw_hash.fetch("#{base_key}s", []))
    end

    def determine_backend
      key = lookup_function
      value = raw_hash[lookup_function]
      backends = BACKENDS
      custom_mappings = Rails.configuration.hdm[:custom_lookup_function_mapping]
      backends = backends.deep_merge({ "lookup_key" => custom_mappings.stringify_keys }) if custom_mappings.present?
      backends.fetch(key).fetch(value).to_sym
    rescue KeyError
      raise Hdm::Error, "unknown backend #{value}"
    end
  end
end
