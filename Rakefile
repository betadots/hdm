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
