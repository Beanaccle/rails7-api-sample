# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::CreateProduct do
  describe '#call' do
    let(:user) { create(:user) }

    context 'with valid params' do
      it 'product is created' do
        valid_params = { name: 'test', price: 1_000 }

        expect do
          described_class.new(user).call(valid_params)
        end.to change(Product, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'raise ActiveRecord::RecordInvalid' do
        # NOTE: nameが空
        invalid_params = { name: '', price: 1_000 }

        expect do
          described_class.new(user).call(invalid_params)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
