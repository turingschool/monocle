require 'rails_helper'

RSpec.describe 'admin approves of company' do
  it 'sees list of newly added companies and approves them' do
    admin_logs_in
    company = create_unapproved_company('Test Company')
    visit admin_companies_approval_path
    click_on 'Approve'
    company.reload

    expect(page).to have_content('Company information updated')
    expect(company.approved?).to eq(true)
  end
end
