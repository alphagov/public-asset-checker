require "simplecov"
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
require "shoulda/matchers"
require "capybara/rails"
require "webmock/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

GovukTest.configure

RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.expose_dsl_globally = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true

  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def stub_get(url, value)
  stub_request(:get, url).to_return(
    status: 200,
    body: value,
  )
end

def stub_post(url, category, new_value, old_value)
  stub_request(:post, ENV["SLACK_WEBHOOK_URL"])
    .with(body: payload(url, category, new_value, old_value))
    .to_return(status: 200, body: "")
end

def payload(url, category, new_value, old_value)
  { payload:
    {
      channel: ENV["SLACK_CHANNEL"],
      username: ENV["SLACK_USERNAME"],
      text: "#{category}: #{url} old [#{old_value}] new [#{new_value}]",
    }.to_json }
end
