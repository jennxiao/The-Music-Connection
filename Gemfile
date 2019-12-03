source 'https://rubygems.org'

gem 'bootstrap', '~> 4.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# for secure stoage of API keys
gem 'figaro'
gem 'pusher'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'sysrandom', '~> 1.0', '>= 1.0.5'

# Implementation of Hungarian Algorithm
gem 'munkres', '~> 0.1.0'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# part 2: Storing Sensitive Data
gem 'attr_encrypted'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3', '~> 1.3.13'
  gem 'byebug'
  #Added guard to watch for when we modify code or test files
  gem 'guard'
  gem 'guard-cucumber'
  gem 'guard-shell'
  gem 'mini_racer' # Solves linux console error some versions of rails give if no javascript runtime environment is given
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  #gem 'sqlite3', '~> 1.3.13'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Ruby static code analyzer and formatter
  gem 'rubocop', '~> 0.77.0', require: false
end

group :production do
  gem 'pg', '~> 0.20' # use PostgreSQL in production (Heroku)
  gem 'rails_12factor'  # Heroku-specific production settings
end

# setup Cucumber, RSpec, Guard support
group :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_bot_rails'
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels' # basic imperative step defs
  gem 'geckodriver-helper' # JavaScript testing for cucumber
  gem 'selenium-webdriver' # JavaScript testing for cucumber
  gem 'puma' # JavaScript testing for cucumber
  gem 'database_cleaner' # required by Cucumber
  gem 'launchy'
end

gem 'bundler'
