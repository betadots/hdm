# Workaround to make guard bundler works with bundler >= v1.12.0
# more info https://github.com/guard/guard-bundler/issues/32
Open3.popen3("gem contents bundler") do |i, o|
  Kernel.system("gem install bundler --pre", out: File::NULL) if o.read.empty?
end

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :minitest, all_on_start: false, spring: "RAILS_ENV=test COVERAGE=true STORAGE=local rails test", bundler: false, autorun: false do
  # Rails 4
  watch(%r{^app/(.+).rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+).rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test.rb$})
  watch(%r{^test/test_helper.rb$}) { 'test' }
end

guard 'spring', bundler: true do
  watch('Gemfile.lock')
  watch(%r{^config/})
  ignore(%r{^config/locales/})
  ignore(%r{^config/routes.rb})
  watch(%r{^spec/(support|factories)/})
  watch(%r{^spec/factory.rb})
end
