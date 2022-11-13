require 'rails_helper'

RSpec.describe Users::CreatePaymentHistory do
  describe "#call" do
    let(:user) { create(:user, email: "buyer@example.com") }
    let(:product) { create(:product) }

    it "payment_history is created" do
      expect {
        described_class.new(user).call(product)
      }.to change(PaymentHistory, :count).by(1)
    end
  end
end
