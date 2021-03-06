require 'rails_helper'

RSpec.describe 'api/v1/companies/:id/admin' do
  context 'POST /api/v1/companies/:id/admin/employees' do
    xit "should add an employee" do
      admin_logs_in
      user = create(:user, username: "Jeff Casimir")
      company = create(:company)

      params = {
        name: user.username
      }

      post "/api/v1/companies/#{company.id}/admin/employees", params: params

      expect(response).to be_success
      expect(company.employees.first.first_name.downcase).to eq(user.username.split(' ')[0].downcase)
      expect(company.employees.first.last_name.downcase).to eq(user.username.split(' ')[1].downcase)
    end
  end
end
