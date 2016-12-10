require 'rails_helper'

RSpec.describe SlackService, type: :service do
  context "Slack validation returns error" do
    it "#authenticate returns false" do
      params = {"error"=>"access_denied",
                "state"=>""}

      expect(SlackService.authenticate(params)).to eq(false)
    end
  end

  context "Slack validation returns no code" do
    it "#authenticate returns false" do
      params = {"state"=>""}

      expect(SlackService.authenticate(params)).to eq(false)
    end
  end

  context "We send an incorrect code to Slack" do
    it "#authenticate returns false" do
      VCR.use_cassette("invalid_slack_code") do
        params = {"code"=>"xxxxxxxxxx.xxxxxxxxxxxx.xxxxxxxxxx",
                  "state"=>""}

        expect(SlackService.authenticate(params)).to eq(false)
      end
    end
  end

  # Note: If this test is run without a previously recorded and valid VCR
  # cassette then it will require a new code from slack. This can be obtained in
  # development by putting debugger on the first line of sessions#create. Then
  # capture the code out of the params hash. Do NOT release the debugger until
  # after you have inserted the fresh code into this test and have the test
  # passing, thereby recording a new valid cassette. (If the debugger is
  # released first it will use the code, which is one-time-use only.)
  context "Slack validation succeded" do
    xit "returns a user object" do
      VCR.use_cassette("DO_NOT_DELETE_exchange_slack_code_for_token") do
        params = {"code"=>"2329094327.102692926898.bec22894d5",
                  "state"=>""}

        result = SlackService.authenticate(params)

        expect(result).to be_truthy
        expect(result).to be_an_instance_of(User)
      end
    end
  end
end
