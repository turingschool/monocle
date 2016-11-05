require 'rails_helper'

RSpec.feature "User navigates to individual companies page", type: :feature do
  it "they see the details for that company" do
    company = create(:company)

    visit companies_path
    click_on company.name

    expect(page).to have_content(company.name)
    expect(page).to have_content(company.street_address)
    expect(page).to have_content(company.city_state_zip)
    expect(page).to have_content(company.phone)
    expect(page).to have_content(company.website)
    expect(page).to have_content(company.headquarters)
    expect(page).to have_content(company.products_services)
    expect(page).to have_content(company.person_in_charge)
  end
end
