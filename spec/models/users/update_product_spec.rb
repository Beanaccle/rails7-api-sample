require 'rails_helper'

RSpec.describe Products::UpdateProduct do
  describe "#call" do
    let(:user) { create(:user) }

    context "when user's product" do
      let(:product) { create(:product, user: user, name: "test", price: 1_000) }

      context "with valid params" do
        let(:valid_params) do
          { name: "update_test", price: 100_000 }
        end

        it "returns product instance" do
          expect(described_class.new(user).call(product.id, valid_params)).to be_a(Product)
        end

        it "product is updated" do
          expect {
            described_class.new(user).call(product.id, valid_params)
            product.reload
          }.to change(product, :name).from("test").to("update_test")
          .and change(product, :price).from(1_000).to(100_000)
        end
      end

      context "with invalid params" do
        it "raise ActiveRecord::RecordInvalid" do
          # NOTE: nameが空
          invalid_params = { name: "", price: 100_000 }

          expect {
            described_class.new(user).call(product.id, invalid_params)
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context "when unrelated product" do
      let(:unrelated_user) { create(:user, email: "unrelated@example.com") }
      let(:product) { create(:product, user: unrelated_user, name: "test", price: 1_000) }

      context "with valid params" do
        it "raise ActiveRecord::RecordNotFound" do
          valid_params = { name: "update_test", price: 100_000 }

          expect {
            described_class.new(user).call(product.id, valid_params)
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
