require 'rails_helper'

RSpec.feature "User navigates to individual companies page", type: :feature do
  xit "they see the details for that company" do
    VCR.use_cassette('company_creation') do
      user = create(:user)
      stub_login(user)
      create_approved_company
      company = Company.first

      visit companies_path
      click_on company.name

      expect(page).to have_content(company.name)
      expect(page).to have_content(company.locations.first.street_address)
      expect(page).to have_content(company.locations.first.city_state_zip)
      expect(page).to have_content(company.locations.first.phone)
      expect(page).to have_content(company.website)
      expect(page).to have_content(company.headquarters)
      expect(page).to have_content(company.products_services)
      expect(page).to have_content(company.size)
      expect(page).to have_content(company.locations.first.primary_contact)
    end
  end
end
