# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::CreatePaymentHistory do
  describe '#call' do
    let(:user) { create(:user, email: 'buyer@example.com') }
    let(:product) { create(:product) }

    it 'payment_history is created' do
      expect do
        described_class.new(user).call(product)
      end.to change(PaymentHistory, :count).by(1)
    end
  end
end
