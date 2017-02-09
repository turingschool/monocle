require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_many(:company_industries) }
  it { should have_many(:starred_companies) }
  it { should have_many(:locations) }
  it { should have_many(:users) }

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:website)}
  it { should validate_presence_of(:headquarters)}
  it { should validate_presence_of(:products_services)}
end
