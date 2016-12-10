require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_many(:company_industries) }
  it { should have_many(:starred_companies) }
  it { should have_many(:locations) }
  it { should have_many(:users) }
end
