require 'rails_helper'

feature "user can filter company by size" do
  it "can see a companies with that size" do
    VCR.use_cassette('filter_company_size') do
      create_company_with_size("2-10")
      create_company_with_size("11-50")
      user_logs_in

      visit '/'

      expect(page).to have_content('Company 2-10')
      expect(page).to have_content('Company 11-50')
      find(:css, "#company_size_[value='2-10']").set(true)
      click_on "Submit"
      expect(page).to have_content('Company 2-10')
      expect(page).not_to have_content('Company 11-50')
    end
  end

  it "can see multiple companies with different sizes" do
    VCR.use_cassette('filter_mult_company_sizes') do
      create_company_with_size("2-10")
      create_company_with_size("11-50")
      create_company_with_size("51-200")
      user_logs_in

      visit '/'

      expect(page).to have_content('Company 2-10')
      expect(page).to have_content('Company 11-50')
      expect(page).to have_content('Company 51-200')
      find(:css, "#company_size_[value='2-10']").set(true)
      find(:css, "#company_size_[value='11-50']").set(true)
      click_on "Submit"
      expect(page).to have_content('Company 2-10')
      expect(page).to have_content('Company 11-50')
      expect(page).not_to have_content('Company 51-200')
    end
  end
end
