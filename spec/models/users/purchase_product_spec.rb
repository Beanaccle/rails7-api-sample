require 'rails_helper'

RSpec.describe Users::PurchaseProduct do
  describe "#call" do
    let(:buyer) { create(:user, email: "buyer@example.com", points: 100_000) }
    let(:seller) { create(:user, email: "seller@example.com", points: 0) }
    let(:product) { create(:product, user: seller, price: 50_000) }

    context "when product found" do
      it "points are transferred" do
        expect {
          described_class.new(buyer).call(product.id)
          buyer.reload
          seller.reload
        }.to change(buyer, :points).from(100_000).to(50_000)
        .and change(seller, :points).from(0).to(50_000)
      end

      it "payment_history is created" do
        expect {
          described_class.new(buyer).call(product.id)
        }.to change(PaymentHistory, :count).by(1)
      end

      it "returns product instance" do
        expect(described_class.new(buyer).call(product.id)).to be_a(Product)
      end

      context "when failed to save payment_history" do
        it "points are not transferred" do
          allow(Users::CreatePaymentHistory).to receive(:new).and_raise(ActiveRecord::RecordInvalid)

          expect {
            described_class.new(buyer).call(product.id)
          }.to raise_error(ActiveRecord::RecordInvalid)

          expect(buyer.reload.points).to eq(100_000)
          expect(seller.reload.points).to eq(0)
        end
      end
    end

    context "when product not found" do
      it "not calling Users::PointPayment" do
        expect {
          described_class.new(buyer).call(0)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
