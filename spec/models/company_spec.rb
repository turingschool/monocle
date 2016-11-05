require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should belong_to(:category) }
end
