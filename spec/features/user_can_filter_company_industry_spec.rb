require 'rails_helper'

feature "user can filter company by industry" do
  it "can see all companies with that industry" do
    VCR.use_cassette('filter_industry') do
      create_company_with_industry("Tech", "Company 1")
      create_company_with_industry("Finance", "Company 2")
      user_logs_in

      visit '/'

      expect(page).to have_content('Company 1')
      expect(page).to have_content('Company 2')

      find(:css, "#industry_ids_[value='Tech']").set(true)
      click_on "Submit Industries"

      expect(page).to have_content('Company 1')
      expect(page).not_to have_content('Company 2')
    end
  end

  it "can see all companies with multiple industries selected" do
    VCR.use_cassette('filter_multi_industries') do
      create_company_with_industry("Tech", "Company 1")
      create_company_with_industry("Finance", "Company 2")
      create_company_with_industry("Health", "Company 3")
      user_logs_in

      visit '/'

      expect(page).to have_content('Company 1')
      expect(page).to have_content('Company 2')
      expect(page).to have_content('Company 3')

      find(:css, "#industry_ids_[value='Tech']").set(true)
      find(:css, "#industry_ids_[value='Finance']").set(true)
      click_on "Submit Industries"

      expect(page).to have_content('Company 1')
      expect(page).to have_content('Company 2')
      expect(page).not_to have_content('Company 3')
    end
  end
end
