require 'rails_helper'

RSpec.describe 'standard user logs in' do
  it 'does not see any additional tools in navbar' do
    user_logs_in
    visit root_path

    expect(page).to_not have_content('Admin Tools')
    expect(page).to_not have_content('Moderator Tools')
  end
end
