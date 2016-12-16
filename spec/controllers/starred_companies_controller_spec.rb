require 'rails_helper'

RSpec.describe StarredCompaniesController, type: :controller do
  describe "POST create" do
    it "associates user and company" do
      user = create(:user)
      company = create(:company)
      stub_login(user)

      params = {company_id: company.id}

      expect{post :create, params: params}.to change{user.companies.count}.from(0).to(1)
    end
  end

  describe "POST create" do
    context "user is not authenticated" do
      it "receives a 404 response" do
        company = create(:company)

        params = {company: company.id}
        post :create, params: params

        expect(response).to have_http_status(404)
      end
    end
  end
end
