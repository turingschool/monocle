require 'rails_helper'

RSpec.describe "Census service" do
  context 'GET /api/v1/users' do
    it "can get users from census" do
      VCR.use_cassette('.census-app') do
        url = "/api/v1/users"
        access_token = "#{ENV['census_access_token']}"

        census_results = CensusService.new.get_users(url, access_token)

        expect(census_results).to be_instance_of(Array)
        expect(census_results.first).to be_instance_of(Hash)
        expect(census_results.first).to have_key(:first_name)
        expect(census_results.first).to have_key(:last_name)
      end
    end
  end
end