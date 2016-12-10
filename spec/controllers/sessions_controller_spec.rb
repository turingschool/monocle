require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST create" do
    xit "creates a user" do
      VCR.use_cassette("DO_NOT_DELETE_exchange_slack_code_for_token") do
        params = {"code"=>"2329094327.102692926898.bec22894d5",
                  "state"=>""}

        expect{post :create, params: params}.to change{User.count}.from(0).to(1)
      end
    end
  end

  describe "POST create" do
    it "fails to create a user" do
      params = {"error"=>"access_denied",
                "state"=>""}

      expect{post :create, params: params}.to_not change{User.count}.from(0)
    end
  end

  describe "GET new" do
    it "" do
      get :new

      expect(response).to have_http_status(302)
    end
  end

  describe "POST destroy" do
    context "user is not authenticated" do
      it "recieves a 404 response" do
        post :destroy

        expect(response).to have_http_status(404)
      end
    end
  end
end
