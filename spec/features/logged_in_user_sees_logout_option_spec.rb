require 'rails_helper'

RSpec.feature "After stubbing login" do
  scenario "user sees logout option" do
    user = create(:user)

    visit root_path

    expect(page).to have_link("Sign in with Census")

    stub_login(user)
    visit companies_path

    expect(page).to_not have_link("Sign in with Census")
    expect(page).to have_content("Signed in as #{user.username}")
    expect(page).to have_button("Sign Out")
  end

  scenario "logging out shows flash message" do
    user = create(:user)
    stub_login(user)
    visit companies_path
    click_button"Sign Out"

    expect(page).to have_content("Signed out successfully.")
  end
end
