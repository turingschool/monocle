require 'rails_helper'

RSpec.feature 'admin edits company information' do
  it 'clicks edit button on company page and changes information' do
    company = create(:company)
    admin_logs_in
    visit company_path(company)
    click_on 'Edit Information'
    fill_in 'company_name', with: 'Test Edit'
    click_on 'Update Company'

    expect(page).to have_content('Test Edit')
    expect(page).to_not have_conten(company.name)
  end
end
