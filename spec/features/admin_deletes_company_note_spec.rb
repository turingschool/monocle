require 'rails_helper'

RSpec.feature 'admin deletes company note' do
  it 'clicks delete note button on company page' do
    create_note_with_company_and_user
    admin_logs_in
    
    visit company_path(Company.last)
    
    expect(page).to have_content('Solid Company')
    expect(page).to have_content('They are solid.')
  
    within "#notes" do
      first('.delete-button').click
    end
    expect(page).to_not have_content('Solid Company')
    expect(page).to_not have_content('They are solid.')
  end
end