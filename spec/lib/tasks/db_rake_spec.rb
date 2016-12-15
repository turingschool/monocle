# Reference: https://robots.thoughtbot.com/test-rake-tasks-like-a-boss

require 'rails_helper'
require 'rake'

RSpec.describe "db:seed_test_fixture" do
  include_context "rake"

  xit "seeds the test database from the fixture data" do
    fixture_file = "agricultural_technology.txt"
    path = File.join(Rails.root, "data", "test_fixtures_data", fixture_file)

    subject.invoke(path)

    expect(Industry.count).to eq(1)
    expect(Industry.last.name).to eq(File.basename(fixture_file, ".txt"))
    expect(Company.count).to eq(22)

    expect(Company.first.industries.first).to eq(Industry.last)
    expect(Company.first.name).to eq("ADVANCED REGENERATIVE THERAPIES")
    expect(Company.first.locations.first.street_address).to eq("320 E. Vine Drive, Suite 122")
    expect(Company.first.locations.first.city_state_zip).to eq("Fort Collins, CO 80524")
    expect(Company.first.locations.first.phone).to eq("970-222-9831")
    expect(Company.first.website).to eq("www.art4dvm.com")
    expect(Company.first.headquarters).to eq("Fort Collins")
    expect(Company.first.products_services).to eq("Uses stem cells derived from the bone marrow of equine and canine to treat equine athlete joint injuries.")
    expect(Company.first.locations.first.primary_contact).to eq("Cristin Keohan, laboratory director")
    expect(Company.first.locations.first.city.name).to eq("Fort Collins")
    expect(Company.first.locations.first.state.name).to eq("CO")
    expect(Company.first.locations.first.zip_code.zip_code).to eq("80524")


    expect(Company.last.industries.first).to eq(Industry.last)
    expect(Company.last.name).to eq("ZEOPONIX INC.")
    expect(Company.last.locations.first.street_address).to eq("P.O. Box 19105")
    expect(Company.last.locations.first.city_state_zip).to eq("Boulder, CO 80308")
    expect(Company.last.locations.first.phone).to eq("303-673-0098")
    expect(Company.last.website).to eq("www.zeoponix.com")
    expect(Company.last.headquarters).to eq("Boulder")
    expect(Company.last.products_services).to eq("Zeoponic soil amendment/fertilizer, NASA spin off, high efficiency ion exchange nutrient delivery; horticulture, sports/golf, forestry, agriculture, landscaping, greenroofs, aquaponics, reclamation.")
    expect(Company.last.locations.first.primary_contact).to eq("Richard Andrews, CEO")
    expect(Company.last.locations.first.city.name).to eq("Boulder")
    expect(Company.last.locations.first.state.name).to eq("CO")
    expect(Company.last.locations.first.zip_code.zip_code).to eq("80308")
  end
end
