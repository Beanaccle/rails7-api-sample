require 'rails_helper'

RSpec.describe Users::PurchaseProduct do
  describe "#call" do
    let(:user) { create(:user) }
    let(:product) { create(:product, user: user) }

    before "mock Users::PointPayment" do
      @point_payment_mock = instance_double(Users::PointPayment)
      allow(Users::PointPayment).to receive(:new).and_return(@point_payment_mock)
      allow(@point_payment_mock).to receive(:call)
    end

    context "when product found" do
      it "called Users::PointPayment" do
        described_class.new(user).call(product.id)

        expect(@point_payment_mock).to have_received(:call).once
      end

      it "returns product instance" do
        expect(described_class.new(user).call(product.id)).to be_a(Product)
      end
    end

    context "when product not found" do
      it "not calling Users::PointPayment" do
        expect {
          described_class.new(user).call(0)
        }.to raise_error(ActiveRecord::RecordNotFound)

        expect(@point_payment_mock).not_to have_received(:call)
      end
    end
  end
end
