require 'rails_helper'

RSpec.describe "A user can see recent job posts" do
  it "shows posts from lookingfor" do
    VCR.use_cassette "Recent Jobs" do
      user_logs_in
      visit '/jobs'
      expect(page).to have_css('.job')
      within('.job:first-of-type') do
        expect(page).to have_content('Software Engineer (Full Stack) at Eyenuk, Inc. (Los Angeles, CA)')  
        expect(page).to have_content('Location: Los Angeles, CA')  
        expect(page).to have_content('Posted Date: 2017-01-04')  
        expect(page).to have_content('Remote: false')  
        expect(page).to have_content('Company: Eyenuk, Inc.')  
        expect(page).to have_content('Technologies: Python')  
      end
    end
  end
end
