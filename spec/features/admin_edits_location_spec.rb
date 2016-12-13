require 'rails_helper'

RSpec.feature 'admin edits company location' do
  it 'clicks edit location button on company page' do
    company = create_approved_company
    admin_logs_in
    visit company_path(company)

    expect(page).to have_content("123 Test St City")
    within "#locations" do
      click_on "Edit Location"
    end
    fill_in 'Street address', with: 'New Address'
    click_on 'Update Location'

    expect(page).to have_content("New Address")
    expect(page).to_not have_content("123 Test St City")
  end
end
