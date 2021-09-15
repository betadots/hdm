class HieraData
  class DataFile
    attr_reader :path, :file

    delegate :exist?, :writable?, :keys, :content_for_key, :[],
      to: :file

    def initialize(path:, facts: {}, type: :yaml)
      @path = path
      setup_git_location
      @file = create_file(type)
    end

    def write_key(key, value)
      @file.write_key(key, value)
      @git_repo&.commit!(action, path)
    end

    def remove_key(key)
      @file.remove_key(key)
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

    def create_file(type)
      case type
      when :yaml
        YamlFile.new(path: @path)
      else
        raise HDM::Error, "unsupported data file type #{type}"
      end
    end
  end
end
