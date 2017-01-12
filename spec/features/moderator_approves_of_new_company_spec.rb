require 'rails_helper'

RSpec.describe 'moderator approves of company' do
  it 'sees list of newly added companies and approves them' do
    VCR.use_cassette('company_creation') do
      moderator_logs_in
      company = create_unapproved_company('Test Company')
      visit moderator_companies_approval_path
      click_on 'Approve'
      company.reload
      
      expect(page).to have_content('Test Company Status Successfully Approved')
      expect(company.approved?).to eq(true)
    end
  end
end
