require 'rails_helper'

describe 'As a logged in user' do

  before(:each) do
    user_logs_in
  end

  context 'when I visit a company show page' do
    scenario 'I enter an invalid zipcode and get an error' do

      company = create_approved_company("Test Company")
      visit '/companies/1'

      expect(page).to have_content("Add Findings")

      select '2', from: 'finding_viability'
      check 'finding_hiring'
      click_on "Submit findings"
    end
  end
end
