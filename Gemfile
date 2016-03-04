source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.beta3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
group :production do
  gem 'pg'
  gem 'mysql2'
end

# Uses ohm to provide an abstraction-layer for redis-models
# https://github.com/soveran/ohm
# https://github.com/cyx/ohm-contrib
gem 'ohm'
gem 'ohm-contrib'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use serializer to return correct format to ember_cli
gem 'active_model_serializers'

# Use Unicorn as the app server
gem 'unicorn'

# Try puma as a substitute for thin
gem 'puma', group: :development

# Use Capistrano for deployment
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'rvm1-capistrano3', require: false

# This is needed. because cap doesn't support submodules anymore and we have to use our own strategy
gem 'capistrano-git-submodule-strategy', '~> 0.1', :github => 'ekho/capistrano-git-submodule-strategy'

# Adds task to manage puma via capistrano
gem 'capistrano3-puma' , group: :development

# Use highline to manage console-input like passwords for capistrano
gem 'highline'

# we use ember-cli for our frontend-app
gem "ember-cli-rails", '0.5.1'

group :development, :test do
  # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'pry'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Pretty print objects
  gem 'awesome_print'

  # generates pretty UML-diagrams of controllers and models
  gem 'railroady'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # For live-reload of ember-app
  gem 'guard'
  gem 'guard-livereload'

  # We want to check certain things before commit to repo
  gem 'pre-commit'

  # We want to catch mails in development and tests
  gem 'mailcatcher'

  # Test your javascript
  gem 'konacha'
end

# Cucumber for BDD
group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner', '<= 1.0.1'
  gem 'factory_girl_rails'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'headless'
  gem 'email_spec'
  gem 'capybara-screenshot'

  # we want coverage-reports
  gem 'simplecov', :require => false

  # include rspec for unit- and functional tests
  gem 'rspec-rails', '~> 3.0'
end

# For running tests parallel
gem "parallel_tests", :group => :development

# We use devise (https://github.com/plataformatec/devise) for authentication and authorization
gem 'devise', git: 'https://github.com/plataformatec/devise.git'

# We want to use https://github.com/CanCanCommunity/cancancan for authorization
gem 'cancancan', '~> 1.10'

# We us countries to provide iso-3166-1 compatible country-references
gem 'countries'

# We use i18n-js to make our translations from backend available in frontend-app
gem "i18n-js", ">= 3.0.0.rc11"

# Integrates TinyMCE
gem 'tinymce-rails'

# Tracks changes to models
gem 'paper_trail', '~> 4.0.0'

# Handles file-attachements
gem "paperclip", "~> 4.3"

# We want to store stuff app-wide per request, but hesitate to use Thread.current
gem 'request_store'
