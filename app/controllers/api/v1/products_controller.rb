module Api
  module V1
    class ProductsController < ApplicationController
      before_action :authenticate_user!

      def create
        product = Products::Create.new(current_user).call(product_params)

        render json: {
          data: {
            message: "#{product.name} created",
          }
        }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { data: { message: e.message } }, status: :unprocessable_entity
      end

      private

      def product_params
        params.require(:product).permit(:name, :price)
      end
    end
  end
end
