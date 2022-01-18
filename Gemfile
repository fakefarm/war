source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.0.2'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

gem 'hashie'
gem 'faraday', '1.9.3'
gem 'faraday_middleware'

group :development, :test do
  gem 'dotenv-rails', '2.7.6'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug', '~> 3.8'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rb-readline'
  gem 'rspec-rails', '~> 5.0.2'
  gem 'shoulda-matchers'
end

group :development do
  gem 'spring'
  gem 'listen'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner-active_record'
  gem 'webmock'
end

