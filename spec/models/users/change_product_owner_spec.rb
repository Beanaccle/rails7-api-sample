# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ChangeProductOwner do
  describe '#call' do
    let(:user) { create(:user, email: 'buyer@example.com') }
    let(:product) { create(:product) }

    it 'product user is changed' do
      expect do
        described_class.new(user).call(product)
      end.to change(product, :user).from(product.user).to(user)
    end
  end
end
