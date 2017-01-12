require 'rails_helper'

RSpec.describe "A user can see recent job posts" do
  it "shows posts from lookingfor" do
    VCR.use_cassette "Recent Jobs" do
      user_logs_in
      visit '/jobs'
      expect(page).to have_css('.job')
      within('.job:first-of-type') do
        expect(page).to have_content('Location:')  
        expect(page).to have_content('Posted Date:')  
        expect(page).to have_content('Remote:')  
        expect(page).to have_content('Company:')  
        expect(page).to have_content('Technologies:')  
      end
    end
  end
end
