# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# User Authentication
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'pundit', '~> 2.2'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'web-console'

  gem 'brakeman', '~> 5.3.1'
  gem 'lefthook', '~> 1.1.1'
  gem 'rubocop', '~> 1.36', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
# For seeds
gem 'faker', '~> 2.23'
