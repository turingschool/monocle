require 'rails_helper'

RSpec.feature "User visits home page" do
  context "without logging in" do
    scenario "they see the root path" do
      visit root_path

      expect(page).to have_http_status(200)
      expect(page).to have_content("Welcome to Monocle")
      expect(page).to have_link("Sign in with Census")
      expect(page).to_not have_css(".navbar")
    end
  end

  context "after logging in" do
    scenario "they are redirected" do
      user = create(:user)
      stub_login(user)
      visit root_path

      expect(current_path).to_not eq(root_path)
      expect(page).to have_css(".navbar")
    end
  end
end
