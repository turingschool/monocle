FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    census_uid { SecureRandom.hex(4) }
    census_access_token "xxxx-xxxxxxxxxx-xxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  end
end
