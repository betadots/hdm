class HieraData
  class GitRepo
    BASE_PATH = Rails.root.join("repos").freeze

    def initialize(url)
      @url = Gitable::URI.parse(url)
      @repo = setup_repo
    rescue TypeError, Git::GitExecuteError, Addressable::URI::InvalidURIError => e
      raise Hdm::Error.new(e)
    end

    def commit!(action, path)
      @repo.add(path)
      @repo.commit(message_for(action))
      @repo.push("origin", @repo.current_branch)
    rescue Git::GitExecuteError => e
      raise Hdm::Error.new(e)
    end

    def local_path
      @local_path ||= BASE_PATH.join(@url.project_name)
    end

    private

    def setup_repo
      FileUtils.mkdir_p(BASE_PATH)
      if File.exist?(local_path)
        Git.open(local_path)
      else
        Git.clone(@url.to_s, local_path)
      end
    end

    def message_for(action)
      prefix = case action
               when :add
                 "Add"
               when :change
                 "Change"
               when :remove
                 "Remove"
               else
                 raise "unknown action"
               end
      message = "#{prefix} value via hdm"
      if user = Current.user
        message << "\n\n"
        message << "hdm user: #{user.full_name} <#{user.email}>"
      end
      message
    end
  end
end
