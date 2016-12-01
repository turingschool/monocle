require 'rails_helper'

describe "user can add a company" do
  it "and then see pending approval" do

    state = State.create(name: "Colorado")
    city = City.create(name: "Denver")
    zip_code = ZipCode.create(zip_code: "80202")
    category = Category.create(name: "Applesauce")

    user = create(:user)
    stub_login(user)
    visit '/companies'
    click_on "Add Company"
    fill_in "company_name", with: "Monocle"
    fill_in "company_street_address", with: "1234 Main St"
    fill_in "company_city_state_zip", with: "Denver, CO, 80203"
    fill_in "company_phone", with: "123-456-789"
    fill_in "company_website", with: "www.monocle.com"
    fill_in "company_headquarters", with: "Denver, CO"
    fill_in "company_products_services", with: "Jobs"
    fill_in "company_person_in_charge", with: "Dan Broadbent"
    find('#company_state_id').find(:xpath, 'option[1]').select_option
    find('#company_city_id').find(:xpath, 'option[1]').select_option
    find('#company_zip_code_id').find(:xpath, 'option[1]').select_option
    find('#company_category_id').find(:xpath, 'option[1]').select_option

    click_button "Create Company"
    company = Company.last
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content("Company is pending approval.")
  end
end
