require 'rails_helper'

describe 'A user edits own note to a company' do
  it 'shows the changes on the company page' do
    user = create(:user)
    company = create(:company)

    stub_login(user)
    visit company_path(company)
    fill_in 'note_title', with: 'So cool!'
    fill_in 'note_body', with: 'what a cool company!'
    click_on 'Add Note'
    within "#notes" do
      first('.edit-button').click
    end
    fill_in 'note_title', with: 'just kidding'
    fill_in 'note_body', with: 'changed my mind'
    click_on "Update Note"
    expect(page).to have_content('just kidding')
    expect(page).to_not have_content('So cool!')
  end

  it 'prevents a user from editing another users note' do
    user = create(:user)
    user_2 = create(:user)
    company = create(:company)
    note = create(:note, company_id: company.id, user_id: user.id, title: 'Note Title', body: 'Note Body')

    stub_login(user_2)
    visit company_path(company)
    expect(page).to have_content('Note Title')
    expect(page).to have_content('Note Body')
    expect(page).to_not have_css('.edit-button')
  end
end