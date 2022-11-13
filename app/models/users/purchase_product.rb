# frozen_string_literal: true

module Users
  class PurchaseProduct
    def initialize(user)
      @user = user
    end

    def call(product_id)
      product = Product.find(product_id)

      ActiveRecord::Base.transaction do
        TransferPoints.new(@user).call(product.user, product.price)
        ChangeProductOwner.new(@user).call(product)
        CreatePaymentHistory.new(@user).call(product)
      end

      product
    end
  end
end
