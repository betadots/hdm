class HieraData
  class YamlFile
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def exist?
      File.exist?(path)
    end

    def writable?
      if exist?
        File.writable?(path)
      else
        File.writable?(File.dirname(path))
      end
    end

    def keys
      return [] unless exist?
      content.keys
    end

    def content
      return nil unless exist?
      @content ||= (YAML.load_file(path) || {})
    end

    def [](key)
      content[key] if content
    end

    def has_key?(key)
      (content || {}).has_key?(key)
    end

    def content_for_key(key)
      return nil unless content
      return nil unless content.has_key?(key)

      value = content[key]

      return "true" if value == true
      return "false" if value == false
      return value if [String, Integer, Float].include?(value.class)

      value_string = value.to_yaml
      value_string.sub(/\A---(\n| )/, '').gsub(/^$\n/, '')
    end

    def write_key(key, value)
      new_content = (content || {})
      new_content[key] = value

      File.open(path, File::RDWR|File::CREAT, 0644) do |f|
        f.flock(File::LOCK_EX)
        f.rewind
        f.write(new_content.to_yaml)
        f.flush
        f.truncate(f.pos)
      end
    end

    def remove_key(key)
      new_content = (content ? content : {})
      new_content.delete(key)

      File.open(path, File::RDWR|File::CREAT, 0644) do |f|
        f.flock(File::LOCK_EX)
        f.rewind
        f.write(new_content.to_yaml)
        f.flush
        f.truncate(f.pos)
      end
    end
  end
end
