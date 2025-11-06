class HieraData
  class DataFile
    attr_reader :path, :file

    delegate :content, :exist?, :writable?, :keys,
             :content_for_key, :[], :raw_content,
             to: :file

    def initialize(path:, facts: {}, options: {}, type: :yaml)
      @path = path
      @facts = facts
      @options = options
      @replaced_from_git = false
      setup_git_location
      @file = create_file(type)
    end

    def write_key(key, value)
      action = @file.has_key?(key) ? :change : :add
      @file.write_key(key, value)
      @git_repo&.commit!(action, path)
    end

    def remove_key(key)
      @file.remove_key(key)
      @git_repo&.commit!(:remove, path)
    end

    def replaced_from_git?
      @replaced_from_git
    end

    private

    def setup_git_location
      return unless (git_data = matching_git_location)

      @git_repo = GitRepo.new(git_data[:git_url])
      interpolated_path_in_repo = Interpolation
                                  .interpolate_facts(path: git_data[:path_in_repo], facts: @facts)
                                  .delete_prefix("/")
      path_in_repo = @git_repo.local_path.join(interpolated_path_in_repo).to_s
      path_in_repo << "/" unless path_in_repo.last == "/"
      @path = Pathname.new(
        @path.to_s.sub(git_data[:replaces_datadir_interpolated],
                       path_in_repo.to_s)
      )
      @replaced_from_git = true
    end

    def matching_git_location
      Rails.configuration.hdm.git_data&.find do |git_data|
        replaces_datadir = Interpolation
                           .interpolate_facts(path: git_data[:datadir], facts: @facts)
        replaces_datadir << "/" unless replaces_datadir.last == "/"
        git_data[:replaces_datadir_interpolated] = replaces_datadir
        @path.to_s.start_with?(replaces_datadir)
      end
    end

    def create_file(type)
      case type
      when :eyaml
        EYamlFile.new(path: @path, options: @options)
      when :yaml
        YamlFile.new(path: @path)
      else
        raise Hdm::Error, "unsupported data file type #{type}"
      end
    end
  end
end
