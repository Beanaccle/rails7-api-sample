# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/products' do
  describe 'POST /api/v1/products' do
    context 'when legged in' do
      let!(:user) { create(:user) }
      let!(:auth_headers) { user.create_new_auth_token }

      context 'with valid params' do
        let(:valid_params) do
          { product: { name: 'test', price: 1_000 } }
        end

        it 'returns 201 created' do
          post '/api/v1/products', params: valid_params, headers: auth_headers

          expect(response).to have_http_status(:created)
        end

        it 'product is created' do
          expect do
            post '/api/v1/products', params: valid_params, headers: auth_headers
          end.to change(Product, :count).by(1)
        end
      end

      context 'with invalid params' do
        let(:invalid_params) do
          # NOTE: priceが空
          { product: { name: 'test', price: nil } }
        end

        it 'returns 422 unprocessable_entity' do
          post '/api/v1/products', params: invalid_params, headers: auth_headers

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'product is not created' do
          expect do
            post '/api/v1/products', params: invalid_params, headers: auth_headers
          end.not_to change(Product, :count)
        end
      end
    end

    context 'when logged out' do
      context 'with valid params' do
        let(:valid_params) do
          { product: { name: 'test', price: 1_000 } }
        end

        it 'returns 401 unauthorized' do
          post '/api/v1/products', params: valid_params

          expect(response).to have_http_status(:unauthorized)
        end

        it 'product is not created' do
          expect do
            post '/api/v1/products', params: valid_params
          end.not_to change(Product, :count)
        end
      end
    end
  end

  describe 'PUT /api/v1/products/:id' do
    let!(:product) { create(:product, name: 'test', price: 1_000) }

    context 'when legged in' do
      let!(:auth_headers) { user.create_new_auth_token }

      context 'with own product' do
        let(:user) { product.user }

        context 'with valid params' do
          let(:valid_params) do
            { product: { name: 'update_test', price: 100_000 } }
          end

          it 'returns 200 ok' do
            put "/api/v1/products/#{product.id}", params: valid_params, headers: auth_headers

            expect(response).to have_http_status(:ok)
          end

          it 'product is updated' do
            expect do
              put "/api/v1/products/#{product.id}", params: valid_params, headers: auth_headers
              product.reload
            end.to change(product, :name).from('test').to('update_test')
                                         .and change(product, :price).from(1_000).to(100_000)
          end
        end

        context 'with invalid params' do
          let(:invalid_params) do
            # NOTE: priceが空
            { product: { name: 'update_test', price: nil } }
          end

          it 'returns 422 unprocessable_entity' do
            put "/api/v1/products/#{product.id}", params: invalid_params, headers: auth_headers

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'product is not updated' do
            expect do
              put "/api/v1/products/#{product.id}", params: invalid_params, headers: auth_headers
            end.not_to change(product, :name)
          end
        end
      end

      context 'with not own product' do
        let(:user) { create(:user, email: 'notown@example.com') }

        context 'with valid params' do
          let(:valid_params) do
            { product: { name: 'update_test', price: 100_000 } }
          end

          it 'returns 403 not found' do
            put "/api/v1/products/#{product.id}", params: valid_params, headers: auth_headers

            expect(response).to have_http_status(:not_found)
          end

          it 'product is not updated' do
            expect do
              put "/api/v1/products/#{product.id}", params: valid_params, headers: auth_headers
            end.not_to change(product, :name)
          end
        end
      end
    end

    context 'when logged out' do
      context 'with valid params' do
        let(:valid_params) do
          { product: { name: 'update_test', price: 100_000 } }
        end

        it 'returns 401 unauthorized' do
          put "/api/v1/products/#{product.id}", params: valid_params

          expect(response).to have_http_status(:unauthorized)
        end

        it 'product is not updated' do
          expect do
            put "/api/v1/products/#{product.id}", params: valid_params
          end.not_to change(product, :name)
        end
      end
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    let!(:product) { create(:product) }

    context 'when legged in' do
      let!(:auth_headers) { user.create_new_auth_token }

      context 'with own product' do
        let(:user) { product.user }

        it 'returns 204 no content' do
          delete "/api/v1/products/#{product.id}", headers: auth_headers

          expect(response).to have_http_status(:no_content)
        end

        it 'product is destroyed' do
          expect do
            delete "/api/v1/products/#{product.id}", headers: auth_headers
          end.to change(Product, :count).by(-1)
        end
      end

      context 'with not own product' do
        let(:user) { create(:user, email: 'notown@example.com') }

        it 'returns 403 not found' do
          delete "/api/v1/products/#{product.id}", headers: auth_headers

          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when logged out' do
      it 'returns 401 unauthorized' do
        delete "/api/v1/products/#{product.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
