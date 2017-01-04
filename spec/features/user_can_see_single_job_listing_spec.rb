require 'rails_helper'

RSpec.describe "User can see single job listing" do
  it "can see the job listing on a separate page" do
    VCR.use_cassette "Single Job" do
      user_logs_in
      
      visit '/jobs'
      
      within('.job:first-of-type') do
        click_link 'Software Engineer (Full Stack) at Eyenuk, Inc. (Los Angeles, CA)'
      end
      
      expect(page).to have_content('Software Engineer (Full Stack) at Eyenuk, Inc. (Los Angeles, CA)')  
      expect(page).to have_content('Location: Los Angeles, CA')  
      expect(page).to have_content('Posted Date: 2017-01-04')  
      expect(page).to have_content('Remote: false')  
      expect(page).to have_content('Company: Eyenuk, Inc.')  
      expect(page).to have_content('Technologies: Python')  
      expect(page).to have_content('Description: Eyenuk is a dynamic, well funded, medical software startup that has developed a powerful retinal image')  
      expect(page).to have_content('URL: http://stackoverflow.com/jobs/131937/software-engineer-full-stack-eyenuk-inc')  
      expect(page).not_to have_content('title: Linux Operations Engineer at Ticketmaster UK Limited (Greater London, UK)')  
    end
  end
end