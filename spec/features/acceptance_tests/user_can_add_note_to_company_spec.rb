require 'rails_helper'

describe 'A user adds a note to a company' do
  it 'shows the note on the company page' do
    user = create(:user)
    company = create(:company)

    stub_login(user)
    visit company_path(company)
    fill_in 'note_title', with: 'So cool!'
    fill_in 'note_body', with: 'what a cool company!'
    click_on 'Add Note'

    expect(current_path).to eq(company_path(company))
    within('#notes .note-block:first') do
      expect(page).to have_content('So cool!')
      expect(page).to have_content('what a cool company!')
    end
  end
end

#As a user
#When I visit a company detail page
#and I click "add note"
#and I give the note a title and body
#and I click save
#Then I see the company show page
#And I see my note at the top of the notes
