require 'rails_helper'

RSpec.feature 'admin edits company information' do
  it 'clicks edit button on company page and changes information' do
    company = create_approved_company('TestCo')
    admin_logs_in
    visit company_path(company)
    click_on 'Edit Company Information'
    fill_in 'company_name', with: 'Test Edit'
    click_on 'Update Company'

    expect(page).to have_content('Test Edit')
    expect(page).to_not have_content(company.name)
  end
end
