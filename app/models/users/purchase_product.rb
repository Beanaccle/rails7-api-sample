module Users
  class PurchaseProduct
    def initialize(user)
      @user = user
    end

    def call(product_id)
      product = Product.find(product_id)
      PointPayment.new(@user).call(product.user, product.price)

      product
    end
  end
end
