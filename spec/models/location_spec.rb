require 'rails_helper'

RSpec.describe Location, type: :model do
  it "has a latitude and longitude after being created" do
    VCR.use_cassette("geocode_location") do
      location =  Location.create(street_address: '1510 Blake St.',
                                  city:           'Denver',
                                  state:          'CO',
                                  zip_code:       '80202')
      expect(location.latitude).to eq(39.7496354)
      expect(location.longitude).to eq(-105.0001058)
    end
  end
end
