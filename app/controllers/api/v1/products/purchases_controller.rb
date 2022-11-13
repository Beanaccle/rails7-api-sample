module Api
  module V1
    module Products
      class PurchasesController < ApplicationController
        before_action :authenticate_user!

        def create
          product = Users::PurchaseProduct.new(current_user).call(params[:product_id])

          render json: {
            data: {
              message: "#{product.name} purchased"
            }
          }, status: :ok
        rescue ActiveRecord::RecordInvalid => e
          render json: { data: { message: e.message } }, status: :unprocessable_entity
        rescue ActiveRecord::RecordNotFound
          render status: :not_found
        rescue Users::NotEnoughPointsError
          render json: { data: { message: "not enough points" } }, status: :unprocessable_entity
        end
      end
    end
  end
end
