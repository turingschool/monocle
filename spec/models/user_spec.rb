require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:starred_companies) }
  it { should have_many(:companies) }

  context "When given valid census user info" do
    it "creates a new user" do
      user_info = OpenStruct.new({"uid"=>"abc123",
                   "credentials"=>{"token"=>"xoxp-xxxxxxxxxx"},
                   "info"=>{"first_name"=>"Cal",
                            "last_name"=>"Away"}})

      new_user = User.create_from_census(user_info)

      expect(new_user).to be_an_instance_of(User)
      expect(new_user).to eq(User.last)
      expect(new_user.username).to eq("Cal Away")
      expect(new_user.census_uid).to eq("abc123")
      expect(new_user.census_access_token).to eq("xoxp-xxxxxxxxxx")
    end
  end

  context "When given invalid census user info" do
    it "returns false and does not create a new user" do
      user_info = OpenStruct.new({"census_uid"=>"abc123",
                   "credentials"=>{"token"=>"xoxp-xxxxxxxxxx"},
                   "info"=>{"last_name"=>"Away"}})

      result = User.create_from_census(user_info)

      expect(result).to eq(false)
      expect(User.count).to eq(0)
    end
  end

  it "can star a company" do
    user = create(:user)
    company = create(:company)

    expect{user.star(company)}.to change{user.companies.count}.from(0).to(1)
  end

  it "cannot star an already starred company" do
    user = create(:user)
    company = create(:company)

    user.star(company)
    expect{user.star(company)}.to_not change{user.companies.count}.from(1)
  end
end
