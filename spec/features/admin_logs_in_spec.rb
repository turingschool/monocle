require 'rails_helper'

RSpec.describe 'admin logs in' do
  it 'sees admin tools in navbar' do
    admin_logs_in
    visit root_path

    expect(page).to have_content('Admin Tools')
    expect(page).to_not have_content('Moderator Tools')
  end
end
