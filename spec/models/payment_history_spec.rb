# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentHistory do
  it 'has a valid factory' do
    expect(build(:payment_history)).to be_valid
  end

  describe 'associations' do
    let(:payment_history) { build(:payment_history) }

    it { expect(payment_history).to belong_to(:product).optional }
    it { expect(payment_history).to belong_to(:seller).class_name('User').inverse_of(:seller_payment_histories) }
    it { expect(payment_history).to belong_to(:buyer).class_name('User').inverse_of(:buyer_payment_histories) }
  end

  describe 'validations' do
    let(:payment_history) { build(:payment_history) }

    it { expect(payment_history).to validate_presence_of(:product_name) }

    it {
      expect(payment_history).to validate_numericality_of(:product_price).only_integer.is_greater_than_or_equal_to(0)
    }
  end
end
