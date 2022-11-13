# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/auth' do
  describe 'POST /auth' do
    context 'with valid params' do
      let(:valid_params) do
        { email: 'test@example.com', password: 'password', password_confirmation: 'password' }
      end

      it 'returns 200 ok' do
        post '/auth', params: valid_params

        expect(response).to have_http_status(:ok)
      end

      it 'user is created' do
        expect do
          post '/auth', params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'created user has 10_000 points' do
        post '/auth', params: valid_params

        expect(User.last.points).to eq(10_000)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        # NOTE: password_confirmationが空
        { email: 'test@example.com', password: 'password', password_confirmation: '' }
      end

      it 'returns 422 unprocessable_entity' do
        post '/auth', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'user is not created' do
        expect do
          post '/auth', params: invalid_params
        end.not_to change(User, :count)
      end
    end
  end
end
