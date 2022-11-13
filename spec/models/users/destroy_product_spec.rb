# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::DestroyProduct do
  describe '#call' do
    let(:user) { create(:user) }

    context "when user's product" do
      let!(:product) { create(:product, user:) }

      it 'product is destroyed' do
        expect do
          described_class.new(user).call(product.id)
        end.to change(Product, :count).by(-1)
      end
    end

    context 'when unrelated product' do
      let(:unrelated_user) { create(:user, email: 'unrelated@example.com') }
      let!(:product) { create(:product, user: unrelated_user) }

      it 'raise ActiveRecord::RecordNotFound' do
        expect do
          described_class.new(user).call(product.id)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
