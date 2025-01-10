source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").chomp

gem "rails", "7.1.5.1"

gem "bootsnap", require: false
gem "faraday"
gem "govuk_app_config"
gem "jbuilder"
gem "pg"
gem "puma"
gem "slack-notifier"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "uglifier"

group :development, :test do
  gem "byebug"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "faker"
  gem "govuk_test"
  gem "rspec-rails"
  gem "rubocop-govuk", require: false
end

group :development do
  gem "listen"
  # gem "web-console"
end

group :test do
  gem "brakeman"
  gem "capybara"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "simplecov"
  gem "webmock"
end
