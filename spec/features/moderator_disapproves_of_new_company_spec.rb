require 'rails_helper'

RSpec.describe 'moderator approves of company' do
  it 'sees list of newly added companies and approves them' do
    moderator_logs_in
    create_unapproved_company('Test Company')
    visit moderator_companies_approval_path
    click_on 'Reject'

    expect(page).to have_content('Test Company Status Successfully Rejected')
    expect(Company.last.approved?).to eq(false)
  end
end
