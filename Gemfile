# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "devise", "~> 4.8", ">= 4.8.1"
gem "faker", "~> 2.23"
gem "importmap-rails"
gem "jbuilder"
gem "omniauth", "~> 2.1", ">= 2.1.1"
gem "omniauth-google-oauth2", "~> 1.1", ">= 1.1.1"
gem "omniauth-rails_csrf_protection", "~> 1.0", ">= 1.0.1"
gem "open-uri", "~> 0.3.0"
gem "pagy", "~> 5.10"
gem "pay", "~> 6.8"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "pundit", "~> 2.2"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "stimulus-rails"
gem "stripe", "~> 9.1"
gem "turbo-rails"

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.2"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.5"
  gem "rspec-rails", "~> 5.1", ">= 5.1.2"
end

group :development do
  gem "brakeman", "~> 5.3.1"
  gem "bullet", "~> 7.0", ">= 7.0.3"
  gem "lefthook", "~> 1.1.1"
  gem "rubocop", "~> 1.56", ">= 1.56.3", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", "~> 2.21", require: false
  gem "rubocop-rspec", "~> 2.24", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", "~> 0.21.2", require: false
  gem "webdrivers"
end

gem "redis", "~> 4.8"
gem "sidekiq", "~> 6.5"
gem "sidekiq-cron", "~> 1.7"

gem "sentry-delayed_job", "~> 5.5.0"
gem "sentry-rails", "~> 5.5.0"
gem "sentry-ruby", "~> 5.5.0"
gem "sentry-sidekiq", "~> 5.5.0"

gem "sendgrid-ruby", "~> 6.6"
