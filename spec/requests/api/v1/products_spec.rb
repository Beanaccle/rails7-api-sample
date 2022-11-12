require 'rails_helper'

RSpec.describe "/api/v1/products", type: :request do
  describe "POST /api/v1/products" do
    context "when legged in" do
      let!(:user) { create(:user) }
      let!(:auth_headers) { user.create_new_auth_token }

      context "with valid params" do
        let(:valid_params) do
          { product: { name: "test", price: 1_000 } }
        end

        it "returns 200 ok" do
          post "/api/v1/products", params: valid_params, headers: auth_headers

          expect(response).to have_http_status(:created)
        end

        it "product is created" do
          expect {
            post "/api/v1/products", params: valid_params, headers: auth_headers
          }.to change(Product, :count).by(1)
        end
      end

      context "with invalid params" do
        let(:invalid_params) do
          # NOTE: priceが空
          { product: { name: "test", price: nil } }
        end

        it "returns 422 unprocessable_entity" do
          post "/api/v1/products", params: invalid_params, headers: auth_headers

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "product is not created" do
          expect {
            post "/api/v1/products", params: invalid_params, headers: auth_headers
          }.not_to change(Product, :count)
        end
      end
    end

    context "when logged out" do
      context "with valid params" do
        let(:valid_params) do
          { product: { name: "test", price: 1_000 } }
        end

        it "returns 200 ok" do
          post "/api/v1/products", params: valid_params

          expect(response).to have_http_status(:unauthorized)
        end

        it "product is not created" do
          expect {
            post "/api/v1/products", params: valid_params
          }.not_to change(Product, :count)
        end
      end
    end
  end
end
