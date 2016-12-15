require 'rails_helper'

RSpec.feature "User can unstar a company" do
  context "from their starred company page" do
    it "can unstar a company" do 
      VCR.use_cassette('company_creation') do
        user_logs_in_with_starred_company
        
        visit '/'
        
        click_on 'My Starred Companies'
        expect(page).to have_content('TestCo')
        expect(current_path).to eq('/starred_companies')
        click_on 'Remove from starred companies'
        expect(page).not_to have_content('TestCo')
        expect(current_path).to eq('/starred_companies')
      end
    end
    
    context "from the company show page" do
      it "can unstar a company" do
        VCR.use_cassette('company_creation') do
          company = user_logs_in_with_starred_company
          
          visit '/'
          
          click_on 'TestCo'
          expect(page).to have_button('Unstar')
          expect(current_path).to eq("/companies/#{company.id}")
          click_on 'Unstar'
          expect(page).to have_button('Star')
          expect(current_path).to eq("/companies/#{company.id}")
        end
      end
    end
  end
end
