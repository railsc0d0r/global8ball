# Require and start simplecov at the very first moment
require 'simplecov'
SimpleCov.start 'rails'

# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'
require 'capybara-screenshot/cucumber'

# Make sure this require is after you require cucumber/rails/world.
require 'email_spec' # add this line if you use spork
require 'email_spec/cucumber'

# drop db, create new and migrate
require 'rake'
Rails.application.load_tasks
Rake::Task['test:prepare'].invoke

# Build ember-app
Rake::Task['ember:compile'].invoke

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
Capybara.default_selector = :css

# Use phantomjs for javascript-testing, because it's faster than webkit
require 'capybara/poltergeist'

# Prepare localStorage for phantomjs
phantomjs_local_storage_path = Rails.root.join('tmp', 'phantomjs', ENV['TEST_ENV_NUMBER'] || "0")
FileUtils.mkdir_p phantomjs_local_storage_path unless Dir.exists? phantomjs_local_storage_path

phantomjs_options = ["--local-storage-path=#{phantomjs_local_storage_path}/"]

# Extra poltergeist w/o js-error-handling
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
      app,
      {
          # debug: true,
          window_size: [1600,768],
          # js_errors: false,
          inspector: true,
          phantomjs_options: phantomjs_options,
          phantomjs_logger: File.open("#{Rails.root}/log/test_phantomjs.log", "a"),
          timeout: 300
      }
  )
end

# Extra selenium w/ defaults
Capybara.register_driver :selenium do |app|
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 120

  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/zip" # content-type of file that will be downloaded

  Capybara::Selenium::Driver.new(app, :browser => :firefox, profile: profile, http_client: http_client)
end

Capybara.javascript_driver = :poltergeist

# Keep up to the number of screenshots specified in the hash
Capybara::Screenshot.prune_strategy = { keep: 10 }

# On failure take a screenshot
Capybara::Screenshot.autosave_on_failure = true

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation
# Cucumber::Rails::Database.javascript_strategy = :deletion

# Use thin as testserver - Fixes issues w/ console-ouput and enhances performance
# => http://stackoverflow.com/a/25214510
Capybara.server do |app, port|
 require 'rack/handler/thin'
 Rack::Handler::Thin.run(app, :Port => port)
end

# Setting timeout while waiting for element to appear
Capybara.default_max_wait_time = 15

# Make sure this require is after you require cucumber/rails/world.
require 'email_spec/cucumber'

# for selenium
require 'headless'
headless = Headless.new

Before() do
  # Create Role "Administrator" because otherwise FactoryGirl behaves strange when creating AuthObjects like employees or players
  FactoryGirl.create(:role, name: "Administrator")
end

Before('@dont_run') do |scenario, block|
  scenario.skip_invoke!
end

Before('@fs') do |scenario|
  RailsUpload.setup
  RailsUpload.clear
end

Before('@javascript') do |scenario, block|
  # Clear localStorage from FS
  FileUtils.rm_rf Dir.glob phantomjs_local_storage_path.join('*')
  
  # Set Capybara.server explicitly
  Capybara.server_port = 8888 + ENV['TEST_ENV_NUMBER'].to_i

  # Switch to poltergeist explicitly
  Capybara.current_driver = :poltergeist
end

Before('@selenium') do |scenario, block|
  Capybara.current_driver = :selenium

  headless.start
  sleep 2
end

After('@selenium') do |scenario, block|
  # clear localStorage
  page.execute_script('localStorage.clear();')
  headless.stop

  if scenario.exception.is_a? Timeout::Error
    # restart Selenium driver
    Capybara.send(:session_pool).delete_if { |key, value| key =~ /selenium/i }
  end

  sleep 2
end

After('@javascript') do |scenario|
  page.driver.restart if page.driver.respond_to? :restart
end

at_exit do
  begin
    # We wait for all test-procs to finish before continuing
    if ParallelTests.first_process?
      ParallelTests.wait_for_other_processes_to_finish
    end
  rescue NameError # We infer, that we don't run tests parallel, because ParallelTests wasn't found
  end
  headless.destroy
end
