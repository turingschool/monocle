require 'rails_helper'

RSpec.describe 'moderator logs in' do
  it 'sees moderator tools' do
    moderator_logs_in
    visit root_path

    expect(page).to have_content('Moderator Tools')
    expect(page).to_not have_content('Admin Tools')
  end
end
