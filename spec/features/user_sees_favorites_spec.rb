require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  context 'when I click favorites' do
    it "shows a list of starred companies" do
      user_logs_in
      user = User.first
      companies = create_list(:company, 2)

      user.companies << companies

      visit companies_path
      click_on 'My Starred Companies'

      within first('[data-id]') do
        expect(page).to have_content(companies[1].name)
      end

    end
  end
end

RSpec.describe 'As an unauthenticated user' do
  context 'when I click favorites' do
    it "shows me an error" do
      visit companies_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
