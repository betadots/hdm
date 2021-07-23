class HieraData
  class YamlFile
    attr_reader :path

    def initialize(path:)
      @path = path
      setup_git_location
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
      @content ||= YAML.load(File.read(path))
    end

    def [](key)
      content[key] if content
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

    def write_key(key, value)
      new_content = (content ? content : {})
      action = new_content.has_key?(key) ? :change : :add
      new_content[key] = value

      File.open(path, File::RDWR|File::CREAT, 0644) do |f|
        f.flock(File::LOCK_EX)
        f.rewind
        f.write(new_content.to_yaml)
        f.flush
        f.truncate(f.pos)
      end
      @git_repo&.commit!(action, path)
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
      @git_repo&.commit!(:remove, path)
    end

    private

    def setup_git_location
      if git_data = matching_git_location
        @git_repo = GitRepo.new(git_data[:git_url])
        path_in_repo = @git_repo.local_path.join(git_data[:path_in_repo].delete_prefix("/")).to_s
        path_in_repo << "/" unless path_in_repo.last == "/"
        @path = Pathname.new(@path.to_s.sub(git_data[:datadir], path_in_repo.to_s))
      end
    end

    def matching_git_location
      Rails.configuration.hdm["git_data"]&.find do |git_data|
        replaces_datadir = git_data[:datadir]
        replaces_datadir << "/" unless replaces_datadir.last == "/"
        @path.to_s.start_with?(replaces_datadir)
      end
    end
  end
end
