# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise'
gem 'interactor', '~> 3.0'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'simple_form'
gem 'slim'
gem 'sprockets-rails'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'capybara'
end
