require 'rails_helper'

RSpec.describe 'User visits company page' do
  it 'Sees multiple addresses for one company' do
    VCR.use_cassette('company_creation') do
      company = create_approved_company('TestCo')
      user_logs_in
      add_approved_location_to_company(company)
      visit company_path(company)

      expect(page).to have_content(company.locations.first.street_address)
      expect(page).to have_content(company.locations.last.street_address)
    end
  end
end
