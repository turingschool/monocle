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
  allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(admin)
end

def moderator_logs_in
  moderator = User.create({username: 'tester', slack_uid: 'tester', slack_access_token: 1, role: 1})
  allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(moderator)
end

def user_logs_in
  user = User.create({username: 'tester', slack_uid: 'tester', slack_access_token: 1})
  allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(user)
end

def create_unapproved_company(name = 'TestCo')
  industry = Industry.create(name: "Applesauce")
  company = Company.create({
      name: name,
      website: "www.monocle.com",
      headquarters: "Denver, CO",
      products_services: "Jobs",
      status: 0
    })
  company.industries << industry
  company.locations << Location.create({
    street_address: '123 Test St',
    phone: "123-456-789",
    primary_contact: "Dan Broadbent",
    city: "Denver",
    state: "Colorado",
    zip_code: "80202",
    status: 1
  })
  Company.last
end

def create_approved_company(name = 'TestCo')
  create_unapproved_company(name)
  company = Company.last
  company.update(status: 1)
  Company.last
end

def add_approved_location_to_company(company)
  company.locations << Location.create(
    street_address: '123 Another Test St',
    phone: "987-654-3210",
    primary_contact: "Nate Anderson",
    city: "Boulder",
    state: "Colorado",
    zip_code: "80303",
    status: 1
  )
end

def create_note_with_company_and_user
  user = User.create({username: 'tester', slack_uid: 'tester', slack_access_token: 1})
  company = Company.create({
      name: "Monocle",
      website: "www.monocle.com",
      headquarters: "Denver, CO",
      products_services: "Jobs"
    })
  note = Note.create({
      title: "Solid Company",
      body: "They are solid.",
      user_id: user.id,
      company_id:  company.id })
end
