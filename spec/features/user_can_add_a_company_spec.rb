require 'rails_helper'

describe "user can add a company" do
  xit "and then see pending approval" do
    VCR.use_cassette('second_denver_location') do
      industry = Industry.create(name: "Applesauce")

      user = create(:user)
      stub_login(user)

      visit '/companies'
      click_on "Add Company"
      fill_in "company_name", with: "Monocle"
      fill_in "company_website", with: "www.monocle.com"
      check "industry_ids_"
      fill_in "company_products_services", with: "Jobs"
      select "50", from: "size"
      fill_in "location_phone", with: "123-456-7890"
      fill_in "location_primary_contact", with: "Will Smith"
      fill_in "location_street_address", with: "123 Another Test St"
      fill_in "location_street_address_2", with: "Suite 400"
      fill_in "location_city", with: "Denver"
      select 'Colorado', from: 'state'
      fill_in 'location_zip_code', with: '80111'
      click_button "Create Company"

      company = Company.last
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("Company is pending approval.")
    end
  end
end

describe "user leaves required fields (name) blank" do
  xit "and then see error message" do
    VCR.use_cassette('second_denver_location') do
      industry = Industry.create(name: "Applesauce")

      user = create(:user)
      stub_login(user)

      visit '/companies'
      click_on "Add Company"
      fill_in "company_website", with: "www.monocle.com"
      check "industry_ids_"
      fill_in "company_products_services", with: "Jobs"
      select "50", from: "size"
      fill_in "location_phone", with: "123-456-7890"
      fill_in "location_primary_contact", with: "Will Smith"
      fill_in "location_street_address", with: "123 Another Test St"
      fill_in "location_street_address_2", with: "Suite 400"
      fill_in "location_city", with: "Denver"
      select 'Colorado', from: 'state'
      fill_in 'location_zip_code', with: '80111'
      click_button "Create Company"

      expect(current_path).to eq(new_company_path)
      expect(page).to have_content("Missing required fields")
    end
  end
end
