# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  # These make the rubocop experience maybe slightly less terrible
  task.options = ['-D', '-S', '-E']

  # Use Rubocop's Github Actions formatter if possible
  task.formatters << 'github' if ENV['GITHUB_ACTIONS'] == 'true'
end
# check if the rails configuration exists and load the tasks
if File.file?('config/hdm.yml')
  require_relative 'config/application'
  Rails.application.load_tasks
else
  puts "Not loading Rails specific tasks because config/hdm.yml is missing!"
end

begin
  require 'github_changelog_generator/task'
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.header = "# Changelog\n\nAll notable changes to this project will be documented in this file.\nEach new release typically also includes the latest modulesync defaults.\nThese should not affect the functionality of the module."
    config.exclude_labels = %w[duplicate question invalid wontfix wont-fix skip-changelog github_actions]
    config.user = 'betadots'
    config.project = 'hdm'
    # get branch name from git and strip off any prefixes (e.g. 'release-')
    config.future_release = `git rev-parse --abbrev-ref HEAD`.strip.split('-', 2).last
  end

  # Workaround for https://github.com/github-changelog-generator/github-changelog-generator/issues/715
  require 'rbconfig'
  if RbConfig::CONFIG['host_os'].include?('linux')
    task changelog: :environment do
      puts 'Fixing line endings...'
      changelog_file = File.join(__dir__, 'CHANGELOG.md')
      changelog_txt = File.read(changelog_file)
      new_contents = changelog_txt.gsub("\r\n", "\n")
      File.open(changelog_file, "w") { |file| file.puts new_contents }
    end
  end
rescue LoadError
  # github_changelog_generator isn't available, so we won't define a rake task with it
end
