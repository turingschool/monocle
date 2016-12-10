require 'rails_helper'

RSpec.feature "Guest user attempts to visit" do
  context "companies#index" do
    scenario "they get a 404 page" do
      visit companies_path

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
      expect(page).to_not have_css(".navbar")
      expect(page).to_not have_content("Directory")
    end
  end

  context "companies#show" do
    scenario "they get a 404 page" do
      company = create(:company)
      visit company_path(company)

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
      expect(page).to_not have_css(".navbar")
      expect(page).to_not have_content("Directory")
    end
  end

end
