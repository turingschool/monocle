require 'rails_helper'

RSpec.describe 'As a logged in user' do

  before(:each) do
    user_logs_in
  end

  context 'when I visit /companies' do
    VCR.use_cassette('comapanies_filtering') do
      xscenario 'I enter an invalid zipcode and get an error', :js => true do
        denver_co  = create_denver_company
        boulder_co = create_boulder_company

        visit '/companies'

        check('companies_within')

        fill_in 'zip', with: '023'
        click_button 'Go'

        expect(page).to have_content('Please enter a valid zipcode')
        expect(page).to have_content(denver_co.locations.first.street_address)
        expect(page).to have_content(boulder_co.locations.first.street_address)
      end
    end
  end
end
