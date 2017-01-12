require 'rails_helper'

RSpec.describe "A user stars a job" do
  it "shows that job on the user's starred jobs" do
    user_logs_in 

    visit '/jobs/12675'

  end
end
