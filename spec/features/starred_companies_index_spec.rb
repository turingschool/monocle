require 'rails_helper'

RSpec.feature "User navigates to the starred companies path" do
  scenario "they see all companies they have starred" do
    bob = create(:user)
    stub_login(bob)
    2.times { create(:location) }
    Company.all.each do |company|
      bob.companies << company
    end
    ann = create(:user)
    create(:location)
    anns_favorite = Company.last

    visit root_path
    click_on "My Starred Companies"

    expect(current_path).to eq(starred_companies_path)
    expect(page).to have_content("Company Name:", count: 2)
    bob.companies.each do |company|
      expect(page).to have_link(company.name, href: company_path(company))
      expect(page).to have_content(company.locations.first.phone)
    end
    expect(page).to_not have_content(anns_favorite.name)
  end
end
