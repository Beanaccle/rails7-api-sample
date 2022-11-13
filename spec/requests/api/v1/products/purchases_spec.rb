# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/products/:product_id/purchase' do
  describe 'POST /api/v1/products/:product_id/purchase' do
    let!(:product) { create(:product) }
    let(:purchase_product_mock) { instance_double(Users::PurchaseProduct) }

    before 'mock Users::PurchaseProduct' do
      allow(Users::PurchaseProduct).to receive(:new).and_return(purchase_product_mock)
      allow(purchase_product_mock).to receive(:call).and_return(product)
    end

    context 'when legged in' do
      let!(:auth_headers) { product.user.create_new_auth_token }

      it 'returns 200 ok' do
        post "/api/v1/products/#{product.id}/purchase", headers: auth_headers

        expect(response).to have_http_status(:ok)
      end

      it 'called Users::PurchaseProduct' do
        post "/api/v1/products/#{product.id}/purchase", headers: auth_headers

        expect(purchase_product_mock).to have_received(:call).once
      end
    end

    context 'when legged out' do
      it 'returns 401 unauthorized' do
        post "/api/v1/products/#{product.id}/purchase"

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
