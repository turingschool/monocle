require 'rails_helper'

RSpec.describe 'user adds address to company' do
  it 'submits additional address from company show page' do
    user_logs_in
    company = create_approved_company
    visit company_path(company)
    click_on 'Submit Additional Location'
    fill_in 'location_street_address', with: '123 Another Test St'
    fill_in 'location_phone', with: '987-654-3210'
    fill_in 'location_primary_contact', with: 'Nate Anderson'
    fill_in 'location_city', with: 'Denver'
    select 'Colorado', from: 'state'
    fill_in 'location_zip_code', with: '80111'
    click_on "Submit New Location For #{company.name}"

    expect(page).to have_content('Location pending approval by moderator')
    expect(page).to_not have_content('Nate Anderson')
  end
end
