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

    def paths
      @paths ||=
        Array(raw_hash["path"] || raw_hash.fetch("paths", []))
    end

    def resolved_paths(facts:)
      paths.map do |path|
        groups = path.scan(/%{([^}]+)}/)
        groups.flatten!
        groups.each { |x| x.gsub!(/^::/, '')}

        resolved_path = path.dup

        groups.each do |fact|
          facts_value = facts.dig(*fact.split("."))
          next unless facts_value
          resolved_path.gsub!(/%{(::)?#{fact}}/, facts_value)
        end

        resolved_path
      end
    end
  end
end
