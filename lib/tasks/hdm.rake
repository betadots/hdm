namespace :hdm do
  desc "Prefetch all configured git repositories"
  task :clone_repos => :environment do
    if Rails.configuration.hdm[:git_data].is_a?(Array)
      Rails.configuration.hdm[:git_data].each do |git_data|
        url = git_data[:git_url]
        puts "Cloning #{url}"
        HieraData::GitRepo.new(url)
      end
      puts "Done."
    end
  end
end
