ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

def admin_logs_in
  admin = User.create({username: 'tester', slack_uid: 'tester', slack_access_token: 1, role: 2})
  ApplicationController.any_instance.stubs(:current_user).returns(admin)
end

def moderator_logs_in
  moderator = User.create({username: 'tester', slack_uid: 'tester', slack_access_token: 1, role: 1})
  ApplicationController.any_instance.stubs(:current_user).returns(moderator)
end

def user_logs_in
  user = User.create({username: 'tester', slack_uid: 'tester', slack_access_token: 1})
  ApplicationController.any_instance.stubs(:current_user).returns(user)
end
