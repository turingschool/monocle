require 'rails_helper'

RSpec.describe "User can see single job listing" do
  it "can see the job listing on a separate page" do
    VCR.use_cassette "Single Job" do
      user_logs_in
      
      visit '/jobs'
      
      within('.job:first-of-type') do
        first(:link).click
      end
      
      expect(page).to have_content('Location:')  
      expect(page).to have_content('Posted Date:')  
      expect(page).to have_content('Remote:')  
      expect(page).to have_content('Company:')  
      expect(page).to have_content('Technologies:')  
      expect(page).to have_content('Description:')  
      expect(page).to have_content('URL:')  
    end
  end
end
