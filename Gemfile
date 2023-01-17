source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").chomp

gem "rails", "7.0.4"

gem "bootsnap", require: false
gem "govuk_app_config"
gem "govuk_publishing_components"
gem "jbuilder"
gem "pg"
gem "plek"
gem "puma"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "uglifier"

group :development, :test do
  gem "byebug"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "govuk_test"
  gem "rspec-rails"
  gem "rubocop-govuk", require: false
end

group :development do
  gem "listen"
  gem "web-console"
end

group :test do
  gem "simplecov"
end
