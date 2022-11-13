require 'rails_helper'

RSpec.describe PaymentHistory, type: :model do
  it "has a valid factory" do
    expect(build(:payment_history)).to be_valid
  end

  describe "associations" do
    let(:payment_history) { build(:payment_history) }

    it { expect(payment_history).to belong_to(:product).optional }
    it { expect(payment_history).to belong_to(:seller).class_name("User").with_foreign_key(:seller_id) }
    it { expect(payment_history).to belong_to(:buyer).class_name("User").with_foreign_key(:buyer_id) }
  end

  describe "validations" do
    let(:payment_history) { build(:payment_history) }

    it { expect(payment_history).to validate_presence_of(:product_name) }
    it { expect(payment_history).to validate_numericality_of(:product_price).only_integer.is_greater_than_or_equal_to(0) }
  end
end
