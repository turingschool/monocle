require 'rails_helper'

RSpec.describe "Census service" do
  context 'GET /api/v1/users' do
    xit "can get users from census by name" do
      VCR.use_cassette('.census-app') do
        name = 'scherer'

        url = "/api/v1/users/by_name"
        access_token = "#{ENV['census_access_token']}"

        census_results = CensusService.new.get_users_by_name(url, access_token, name)

        expect(census_results).to be_instance_of(Array)
        expect(census_results.first).to be_instance_of(Hash)
        expect(census_results.first).to have_key(:first_name)
        expect(census_results.first).to have_key(:last_name)
      end
    end
    xit "can get all users from census" do
      VCR.use_cassette('.census-app-all-users') do
        url = "/api/v1/users/"
        access_token = "#{ENV['census_access_token']}"

        census_results = CensusService.new.get_all_users(url, access_token)

        expect(census_results).to be_instance_of(Array)
        expect(census_results.first).to be_instance_of(Hash)
        expect(census_results.first).to have_key(:first_name)
        expect(census_results.first).to have_key(:last_name)
      end
    end
  end
end
