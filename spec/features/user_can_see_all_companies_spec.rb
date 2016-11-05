require 'rails_helper'

RSpec.feature "User navigates to company directory", type: :feature do
  it "they see all companies" do
    category = create(:category_with_companies, companies_count: 3)
    companies = category.companies

    visit root_path
    click_on "Company Directory"

    expect(page).to have_content("Company Name", count: Company.count)

    expect(page).to have_content(companies.first.name)
    expect(page).to have_content(companies.first.street_address)
    expect(page).to have_content(companies.first.city_state_zip)
    expect(page).to have_content(companies.first.phone)
    expect(page).to have_content(companies.first.website)

    expect(page).to have_content(companies.last.name)
    expect(page).to have_content(companies.last.street_address)
    expect(page).to have_content(companies.last.city_state_zip)
    expect(page).to have_content(companies.last.phone)
    expect(page).to have_content(companies.last.website)
  end
end
