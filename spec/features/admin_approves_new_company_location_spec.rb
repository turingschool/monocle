require 'rails_helper'

RSpec.describe 'admin approves of company location' do
  it 'sees list of newly added company locations and approves them' do
    admin_logs_in
    company = create_approved_company('Test Company')
    add_unapproved_location_to_company(company)
    visit admin_companies_approval_path
    click_on "Approve"
    company.reload

    expect(page).to have_content('Company location information updated')
    expect(company.approved?).to eq(true)
  end
end
