class HieraData
  class Hierarchy
    LOOKUP_FUNCTIONS = %w(data_hash lookup_key data_dig hiera3_backend).freeze
    attr_reader :raw_hash

    def initialize(raw_hash:, base_path:)
      @raw_hash = raw_hash
      @base_path = Pathname.new(base_path)
    end

    def name
      @name ||= raw_hash.fetch("name", "Unnamed")
    end

    def lookup_function
      @lookup_function ||= LOOKUP_FUNCTIONS.find { |f| raw_hash.keys.include?(f) }
    end

    def backend
      @backend ||=
        case [lookup_function, raw_hash[lookup_function]]
        when ["data_hash", "yaml_data"]
          :yaml
        when ["data_hash", "json_data"]
          :json
        when ["lookup_key", "eyaml_lookup_key"]
          :eyaml
        else
          raise HDM::Error, "unknown backend #{raw_hash[lookup_function]}"
        end
    end

    def datadir
      return @datadir if @datadir
      path = Pathname.new(raw_hash["datadir"])
      if path.absolute?
        path
      else
        @base_path.join(path)
      end
    end

    def private_key
      if backend == :eyaml
        @base_path.join(raw_hash.dig("options", "pkcs7_private_key"))
      end
    end

    def public_key
      if backend == :eyaml
        @base_path.join(raw_hash.dig("options", "pkcs7_public_key"))
      end
    end

    def encryptable?
      backend == :eyaml &&
        File.readable?(private_key) &&
        File.readable?(public_key)
    end

    def uses_globs?
      raw_hash.has_key?("glob") || raw_hash.has_key?("globs")
    end

    def paths
      @paths ||= setup_paths
    end

    def resolved_paths(facts:)
      paths.flat_map do |path|
        resolved_path = Interpolation.interpolate_facts(path: path, facts: facts)
        if uses_globs?
          resolved_path = Interpolation
            .interpolate_globs(path: resolved_path, datadir: datadir)
        end
        resolved_path
      end
    end

    private

    def setup_paths
      base_key = uses_globs? ? "glob" : "path"
      Array(raw_hash[base_key] || raw_hash.fetch("#{base_key}s", []))
    end
  end
end
