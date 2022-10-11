# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pagy', '~> 5.10'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
# seeds and tests
gem 'faker', '~> 2.23'

# User Authentication
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'pundit', '~> 2.2'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
end

group :development do
  gem 'brakeman', '~> 5.3.1'
  gem 'bullet', '~> 7.0', '>= 7.0.3'
  gem 'lefthook', '~> 1.1.1'
  gem 'rubocop', '~> 1.36', require: false
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'webdrivers'
end

gem 'redis', '~> 4.8'
gem 'sidekiq', '~> 6.5'
gem 'sidekiq-cron', '~> 1.7'

gem "sentry-ruby", '~> 5.5.0'
gem "sentry-rails", '~> 5.5.0'
gem "sentry-sidekiq", '~> 5.5.0'
gem "sentry-delayed_job", '~> 5.5.0'