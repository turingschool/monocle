require 'rails_helper'

RSpec.describe Industry, type: :model do
  it { should have_many(:companies) }
end
