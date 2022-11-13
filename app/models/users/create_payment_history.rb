# frozen_string_literal: true

module Users
  class CreatePaymentHistory
    def initialize(buyer)
      @buyer = buyer
    end

    def call(product)
      product.payment_histories.create!(
        buyer: @buyer,
        seller: product.user,
        product_name: product.name,
        product_price: product.price
      )
    end
  end
end
