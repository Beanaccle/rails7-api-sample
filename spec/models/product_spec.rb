require 'rails_helper'

RSpec.describe Product, type: :model do
  it "has a valid factory" do
    expect(build(:product)).to be_valid
  end

  describe "validations" do
    let(:product) { build(:product) }

    it { expect(product).to validate_presence_of(:name) }
    it { expect(product).to validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }
  end
end
