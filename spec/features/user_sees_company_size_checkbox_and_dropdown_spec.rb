require 'rails_helper'

RSpec.describe 'As a logged in user' do

  before(:each) do
    user_logs_in
  end

  context 'when I visit /companies' do
    VCR.use_cassette('companies_filtering') do
      it "I see a checkbox for 'at most x employees'" do
        visit '/companies'

        expect(page).to have_content("At most X employees")
      end
    end
  end

end
