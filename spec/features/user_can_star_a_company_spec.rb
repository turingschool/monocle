require 'rails_helper'

RSpec.feature "User can star a company" do
  xit "they see the company they have starred" do
    VCR.use_cassette('company_creation') do
      company = create_approved_company
      user_logs_in

      visit '/'
      click_on "TestCo"

      expect(current_path).to eq("/companies/#{company.id}")
      click_button "Star"

      expect(current_path).to eq("/companies/#{company.id}")
      expect(page).to have_button("Unstar")

      click_on "My Starred Companies"
      expect(current_path).to eq("/starred_companies")
      expect(page).to have_content("TestCo")
    end
  end
end
