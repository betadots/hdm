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

  desc "Reset admin password"
  task :reset_admin, [:email] => :environment do |task, args|
    raise "Email argument missing" unless args.email
    admin = User.admins.where(email: args.email).first
    raise "Could not find admin #{args.email}" if admin.nil?
    new_password = SecureRandom.base36
    admin.update!(password: new_password)
    puts "The new password is:"
    puts new_password
  end
end
