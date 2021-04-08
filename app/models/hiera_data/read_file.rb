class HieraData
  class ReadFile
    attr_reader :config_dir, :path, :facts, :full_path, :fact_matched

    def initialize(config_dir:, path:, facts:)
      @config_dir = config_dir
      @path = path
      @facts = facts
      @fact_matched = false
      calculate_full_path
    end

    def exist?
      File.exist?(full_path)
    end

    def keys
      return [] unless exist?
      content.keys
    end

    def content
      return nil unless exist?
      @content ||= YAML.load(File.read(full_path))
    end

    def content_for_key(key)
      return nil unless content
      return nil unless content.has_key?(key)

      value = content[key]
      return "true" if value == true
      return "false" if value == false
      return value if [String, Integer, Float].include?(value.class)

      value_string = value.to_yaml
      value_string.gsub!("---\n", '').gsub!(/^$\n/, '')
      value_string
    end

    def calculated_path
      @converted_path
    end

    def write_key(key, value)
      new_content = (content ? content : {})
      new_content[key] = value

      File.open(@full_path, File::RDWR|File::CREAT, 0644) {|f|
        f.flock(File::LOCK_EX)
        f.rewind
        f.write(new_content.to_yaml)
        f.flush
        f.truncate(f.pos)
      }
    end

    def remove_key(key)
      new_content = (content ? content : {})
      new_content.delete(key)

      File.open(@full_path, File::RDWR|File::CREAT, 0644) {|f|
        f.flock(File::LOCK_EX)
        f.rewind
        f.write(new_content.to_yaml)
        f.flush
        f.truncate(f.pos)
      }
    end

    private
      def calculate_full_path
        groups = path.scan(/%{([^}]+)}/)
        groups.flatten!
        groups.each { |x| x.gsub!(/^::/, '')}

        @converted_path = path.dup
        @fact_matched = true unless @converted_path.match?(/\%{.*}/)

        groups.each do |fact|
          facts_value = facts.dig(*fact.split("."))
          next unless facts_value

          @fact_matched = true if @converted_path.gsub!("%{::#{fact}}", facts_value)
          @fact_matched = true if @converted_path.gsub!("%{#{fact}}", facts_value)
        end
        @full_path = "#{config_dir}/#{@converted_path}"
      end
  end
end
